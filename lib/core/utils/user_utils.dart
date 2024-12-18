import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class UserUtils {
  static String getUserAge({User? user, String emptyText = ''}) {
    final now = DateTime.now();
    final birthDate = user?.dateOfBirth;
    if (birthDate == null) {
      return emptyText;
    }
    int age = now.year - birthDate.year;
    return age.toString();
  }

  static bool isWalletVerified(
    User? user, {
    required Enum$BlockchainPlatform platform,
  }) {
    final verifiedWallets = user?.walletsNew;
    List<String>? verifiedAddresses;
    if (platform == Enum$BlockchainPlatform.ethereum) {
      verifiedAddresses = verifiedWallets?['ethereum'];
    }
    if (platform == Enum$BlockchainPlatform.solana) {
      verifiedAddresses = verifiedWallets?['solana'];
    }
    return platform == Enum$BlockchainPlatform.ethereum
        ? (verifiedAddresses?.length ?? 0) >= 2
        : verifiedAddresses?.isNotEmpty == true;
  }
}
