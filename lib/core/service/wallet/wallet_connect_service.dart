// ignore_for_file: unused_element
import 'dart:convert';

import 'package:app/core/config.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:reown_appkit/reown_appkit.dart';

@lazySingleton
class WalletConnectService {
  static const String defaultNamespace = 'eip155';
  static String defaultRequiredChainId =
      AppConfig.isProduction ? ETHEREUM.chainId : GOERLI.chainId;

  static final lemonadeDAppMetadata = PairingMetadata(
    name: 'Lemonade',
    description: 'Lemonade',
    url: AppConfig.webUrl,
    icons: [
      'https://explorer-api.walletconnect.com/v3/logo/lg/1ab2c2a3-4353-472e-41a1-1ae295473600?projectId=2f05ae7f1116030fde2d36508f472bfb',
    ],
    redirect: Redirect(
      native: '${AppConfig.appScheme}://wallet-callback',
      linkMode: true,
    ),
  );

  late ReownAppKitModal _w3mService;

  IReownAppKit? _app;

  ReownAppKitModal? get w3mService => initialized ? _w3mService : null;

  bool get initialized => _app != null;

  Future<Map<String, RequiredNamespace>> _setupChains() async {
    final chains =
        (await getIt<Web3Repository>().getChainsList()).getOrElse(() => []);
    // add our backend supported chains to reown appkit
    ReownAppKitModalNetworks.addSupportedNetworks(
      'eip155',
      [
        // currently not require lens when connect to wallet initially
        // AppConfig.isProduction ? LensUtils.lensMainnet : LensUtils.lensTestnet,
        ...chains,
      ]
          .map(
            (chain) => ReownAppKitModalNetworkInfo(
              name: chain.name ?? '',
              chainId: chain.chainId ?? '',
              currency: chain.nativeToken?.symbol ?? '',
              rpcUrl: chain.rpcUrl ?? '',
              explorerUrl: chain.explorerUrl ?? '',
              isTestNetwork: !AppConfig.isProduction,
            ),
          )
          .toList(),
    );
    final supportedEip155Chains =
        ReownAppKitModalNetworks.getAllSupportedNetworks(
      namespace: 'eip155',
    ).map((chain) => chain.chainId).toList();

    // TODO:
    // final supportedSolanaChains = ReownAppKitModalNetworks.getAllSupportedNetworks(
    //   namespace: 'solana',
    // ).map((chain) => chain.chainId).toList();

    return {
      'eip155': RequiredNamespace.fromJson({
        'chains': supportedEip155Chains,
        'methods': NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
        'events': NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
      }),
      // TODO:
      // 'solana': RequiredNamespace.fromJson({
      //   'chains': supportedSolanaChains,
      //   'methods': NetworkUtils.defaultNetworkMethods['solana']!.toList(),
      //   'events': [],
      // }),
    };
  }

  Future<bool> init(BuildContext context) async {
    try {
      if (initialized) return true;

      _w3mService = ReownAppKitModal(
        context: context,
        projectId: AppConfig.walletConnectProjectId,
        metadata: lemonadeDAppMetadata,
        logLevel: AppConfig.isProduction ? LogLevel.nothing : LogLevel.all,
        optionalNamespaces: await _setupChains(),
        featuredWalletIds: {
          // Family wallet id
          "445ced0f482742632dfa6684f802eb1a2bb3cb97531bd06e02fb297c6ad21de1",
          // coinbase wallet id
          "fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa",
        },
      );
      await _w3mService.init();
      _app = _w3mService.appKit;
      return true;
    } catch (e) {
      return false;
    }
  }

  void close() {
    if (_app == null) return;
    _app!.onSessionEvent.unsubscribeAll();
    _app!.onSessionUpdate.unsubscribeAll();
    _app!.onSessionConnect.unsubscribeAll();
    _app!.onSessionDelete.unsubscribeAll();

    _w3mService.onModalConnect.unsubscribeAll();
    _w3mService.onModalUpdate.unsubscribeAll();
    _w3mService.onModalNetworkChange.unsubscribeAll();
    _w3mService.onModalDisconnect.unsubscribeAll();
    _w3mService.onModalError.unsubscribeAll();
  }

  Future<ReownAppKitModalSession?> getActiveSession() async {
    if (!initialized) {
      return null;
    }
    return _w3mService.session;
  }

  Future<String?> personalSign({
    required String message,
    required String wallet,
    String? chainId,
  }) async {
    if (chainId == null && _w3mService.selectedChain == null) {
      throw Exception('No chain selected');
    }
    _w3mService.launchConnectedWallet();
    final data = await _w3mService.request(
      topic: _w3mService.session?.topic ?? '',
      chainId:
          chainId ?? _w3mService.selectedChain?.chainId ?? ETHEREUM.chainId,
      request: SessionRequestParams(
        method: 'personal_sign',
        params: [message, wallet],
      ),
    );
    if (data is String) return data;
    throw Exception('Failed to sign message');
  }

  Future<String?> signTypedDataV4({
    required Map<String, dynamic> data,
    required String wallet,
    String? chainId,
  }) async {
    if (chainId == null) {
      throw Exception('No chain selected');
    }
    await switchChain(chainId: chainId);
    _w3mService.launchConnectedWallet();
    final result = await _w3mService.request(
      topic: _w3mService.session?.topic ?? '',
      chainId: chainId,
      request: SessionRequestParams(
        method: 'eth_signTypedData_v4',
        params: [wallet, jsonEncode(data)],
      ),
    );
    if (result is String) return result;
    throw Exception('Failed to sign typed data');
  }

  Future<String> requestTransaction({
    required String chainId,
    required EthereumTransaction transaction,
  }) async {
    await switchChain(chainId: chainId);

    await Future.delayed(const Duration(milliseconds: 500));
    _w3mService.launchConnectedWallet();

    final transactionId = await _w3mService.request(
      topic: _w3mService.session?.topic ?? '',
      chainId: chainId,
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [
          transaction.copyWith(data: transaction.data ?? '').toJson(),
        ],
      ),
    );
    if (transactionId is! String) {
      throw Exception('Failed to send transaction ${transactionId.toString()}');
    }
    return transactionId;
  }

  Future<void> disconnect() async {
    await _w3mService.disconnect(disconnectAllSessions: true);
  }

  Future<Chain> _getChainFromChainId(
    String chainId, {
    bool onlyEip155 = true,
  }) async {
    Chain? chain;
    if (chainId == LensUtils.lensMainnet.fullChainId) {
      chain = LensUtils.lensMainnet;
    } else if (chainId == LensUtils.lensTestnet.fullChainId) {
      chain = LensUtils.lensTestnet;
    } else {
      chain = (await getIt<Web3Repository>().getChainByFullChainId(
        fullChainId: chainId,
      ))
          .fold(
        (failure) => null,
        (chain) => chain,
      );
    }

    if (chain == null) {
      throw Exception('Chain $chainId not found');
    }

    final namespace =
        NamespaceUtils.getNamespaceFromChain(chain.fullChainId ?? '');

    if (onlyEip155 && namespace != NetworkUtils.eip155) {
      throw Exception('Chain $chainId is not supported');
    }
    return chain;
  }

  Future<void> switchChain({
    required String chainId,
  }) async {
    if (_w3mService.session == null) {
      return;
    }
    final chain = await _getChainFromChainId(chainId);

    final targetChain = ReownAppKitModalNetworkInfo(
      name: chain.name ?? '',
      chainId: chain.fullChainId ?? '',
      currency: chain.nativeToken?.symbol ?? '',
      rpcUrl: chain.rpcUrl ?? '',
      explorerUrl: chain.rpcUrl ?? '',
    );
    if (_w3mService.session?.hasSwitchMethod() == true) {
      _w3mService.launchConnectedWallet();
      await _w3mService.requestSwitchToChain(targetChain);
    } else {
      await _w3mService.selectChain(
        targetChain,
      );
    }
  }
}

enum WCRpcErrorCode {
  userRejected(code: 5000),
  userRejectedChains(code: 5001),
  userRejectedMethods(code: 5002),
  userRejectedEvents(code: 5003),
  unsupportedChains(code: 5100),
  unsupportedMethods(code: 5101),
  unsupportedEvents(code: 5102),
  unsupportedAccounts(code: 5103),
  unsupportedNamespaceKey(code: 5104);

  final int code;
  const WCRpcErrorCode({required this.code});
}

extension WalletConnectServiceExtension on WalletConnectService {
  String getWalletImageUrl(String imageId) {
    if (imageId.isEmpty) {
      return '';
    }
    if (imageId.startsWith('http')) {
      return imageId;
    }
    return 'https://api.web3modal.com/getWalletImage/$imageId';
  }
}
