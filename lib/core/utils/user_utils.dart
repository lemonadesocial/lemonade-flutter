import 'package:app/core/domain/user/entities/user.dart';

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
}
