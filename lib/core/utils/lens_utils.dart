import 'dart:async';

import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
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
    required User user,
  }) {
    return {
      "\$schema": "https://json-schemas.lens.dev/account/1.0.0.json",
      "lens": {
        "id": const Uuid().v4(),
        "name": user.username ?? user.name ?? user.displayName,
        "bio": user.description ?? "",
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
}
