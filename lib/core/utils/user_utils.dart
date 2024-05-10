import 'package:app/core/domain/user/entities/user.dart';

class UserUtils {
  static String getBasedInLocation({User? user, String emptyText = ''}) {
    String city = user?.addresses?.first.city ?? '';
    String country = user?.addresses?.first.country ?? '';
    String basedInValue = '';
    if (city.isNotEmpty) {
      basedInValue = city;
      if (country.isNotEmpty) {
        basedInValue += ', $country';
      }
    } else if (country.isNotEmpty) {
      basedInValue = country;
    } else {
      basedInValue = emptyText;
    }
    return basedInValue;
  }

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
