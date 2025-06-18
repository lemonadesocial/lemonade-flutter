import 'dart:async';

import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_namespace_rules.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/lens/namespace/query/get_lens_namespace.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/graphql/lens/transaction/query/lens_transaction_status.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:uuid/uuid.dart';

class LensUtils {
  static String constructLensUsername({
    required User user,
  }) {
    final randomString = const Uuid().v4();
    // Use username if available and not empty, otherwise fallback to userId
    String baseUsername = (user.username != null && user.username!.isNotEmpty)
        ? '${user.username}_$randomString'
        : 'lemonade_$randomString';

    // 1. Convert to lowercase
    String username = baseUsername.toLowerCase();

    final validCharsRegex = RegExp(r'[^a-z0-9_-]');
    username = username.replaceAll(validCharsRegex, '_');

    // 3. Ensure it starts with a letter or digit
    final startsWithValidCharRegex = RegExp(r'^[a-z0-9]');
    if (!startsWithValidCharRegex.hasMatch(username)) {
      username = 'u$username'; // Prepend 'u' if it doesn't start correctly
    }
    // 4. Truncate to 26 characters (maximum allowed by Lens)
    if (username.length > 26) {
      username = username.substring(0, 26);
    }

    // 5. Ensure it doesn't end with _ or - after truncation (Lens requirement)
    while (username.endsWith('_') || username.endsWith('-')) {
      if (username.length == 1) {
        // If the username becomes just '_' or '-', prepend 'u' again
        username = 'u';
        break; // Exit loop as 'u' is valid
      } else {
        username = username.substring(0, username.length - 1);
      }
    }
    // Handle case where username becomes empty after trimming trailing _/-
    if (username.isEmpty) {
      username =
          'lemonade_${const Uuid().v4().substring(0, 8)}'; // Generate a fallback
    }
    // Prepend the app scheme as originally intended
    return username;
  }

  static Map<String, dynamic> constructLensAccountMetadata({
    required String username,
  }) {
    return {
      "\$schema": "https://json-schemas.lens.dev/account/1.0.0.json",
      "lens": {
        "id": const Uuid().v4(),
        "name": username,
        "bio": "",
      },
    };
  }

  static Map<String, dynamic> constructLensFeedMetadata({
    required String name,
    required String description,
  }) {
    return {
      "\$schema": "https://json-schemas.lens.dev/feed/1.0.0.json",
      "lens": {
        "id": const Uuid().v4(),
        "name": name,
        "description": description,
      },
    };
  }

  static Future<LensTransactionStatusResult> pollTransactionStatus({
    required String txHash,
  }) async {
    const timeout = Duration(minutes: 2);
    const pollInterval = Duration(seconds: 5);
    final stopwatch = Stopwatch()..start();
    LensTransactionStatusResult? latestResult;

    while (stopwatch.elapsed < timeout) {
      try {
        final resultEither = await getIt<LensRepository>().transactionStatus(
          input: Variables$Query$TransactionStatus(
            request: Input$TransactionStatusRequest(
              txHash: txHash,
            ),
          ),
        );

        resultEither.fold(
          (failure) {
            // ignore
          },
          (transactionResult) {
            latestResult = transactionResult;
          },
        );

        if (latestResult is FinishedTransactionStatus ||
            latestResult is FailedTransactionStatus) {
          return latestResult!;
        }
      } catch (e) {
        // ignore
      }

      if (stopwatch.elapsed < timeout) {
        await Future.delayed(pollInterval);
      }
    }
    stopwatch.stop();
    if (latestResult != null) {
      return latestResult!;
    } else {
      throw TimeoutException(
        'Transaction status polling timed out without receiving any status.',
        timeout,
      );
    }
  }

  static String getLensUsername({
    LensAccount? lensAccount,
  }) {
    if (lensAccount?.username?.localName?.isNotEmpty == true) {
      return lensAccount!.username!.localName!;
    }
    return '';
  }

  static LensUsernamePricePerLengthRule parsePricePerLengthRule(
    Query$Namespace$namespace$rules$required rule,
  ) {
    String tokenSymbol = '';
    String tokenAddress = '';
    List<LensPricePerLength> pricePerLengthList = [];

    for (final configItem in rule.config) {
      configItem.when(
        addressKeyValue: (addressKeyValue) {
          if (addressKeyValue.key == "assetContract") {
            tokenAddress = addressKeyValue.address;
          }
        },
        stringKeyValue: (stringKeyValue) {
          if (stringKeyValue.key == "assetSymbol") {
            tokenSymbol = stringKeyValue.string;
          }
        },
        arrayKeyValue: (arrayKeyValue) {
          if (arrayKeyValue.key == "overrides") {
            for (final item in arrayKeyValue.array) {
              item.maybeWhen(
                orElse: () {},
                dictionaryKeyValue: (dictionaryKeyValue) {
                  int? length;
                  String? price;
                  for (final dictEntry in dictionaryKeyValue.dictionary) {
                    dictEntry.maybeWhen(
                      orElse: () {},
                      intKeyValue: (intKeyValue) {
                        if (intKeyValue.key == "length") {
                          length = intKeyValue.$int;
                        }
                      },
                      bigDecimalKeyValue: (bigDecimalKeyValue) {
                        if (bigDecimalKeyValue.key == "amount") {
                          price = bigDecimalKeyValue.bigDecimal;
                        }
                      },
                    );
                  }
                  if (length != null && price != null) {
                    pricePerLengthList.add(
                      LensPricePerLength(
                        length: length!,
                        price: price!,
                      ),
                    );
                  }
                },
              );
            }
          }
        },
        booleanKeyValue: (_) {},
        intKeyValue: (_) {},
        bigDecimalKeyValue: (_) {},
        dictionaryKeyValue: (_) {},
        intNullableKeyValue: (_) {},
        rawKeyValue: (_) {},
        orElse: () {},
      );
    }

    return LensUsernamePricePerLengthRule(
      tokenSymbol: tokenSymbol,
      tokenAddress: tokenAddress,
      pricePerLength: pricePerLengthList,
    );
  }

  static Input$PostsRequest getDefaultFeedQueryInput({
    String? lensFeedId,
    String? cursor,
  }) {
    return Input$PostsRequest(
      cursor: cursor,
      filter: Input$PostsFilter(
        postTypes: [Enum$PostType.ROOT, Enum$PostType.REPOST],
        metadata: Input$PostMetadataFilter(
          mainContentFocus: [
            Enum$MainContentFocus.TEXT_ONLY,
            Enum$MainContentFocus.IMAGE,
            Enum$MainContentFocus.EVENT,
            Enum$MainContentFocus.LINK,
          ],
        ),
        feeds: lensFeedId != null
            ? [
                Input$FeedOneOf(
                  feed: lensFeedId,
                ),
              ]
            : null,
      ),
    );
  }
}
