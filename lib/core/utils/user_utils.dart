import 'package:app/core/domain/user/entities/user.dart';
import 'package:collection/collection.dart';

class UserUtils {
  static String getBasedInLocation({User? user, String emptyText = ''}) {
    String city = user?.addresses?.firstOrNull?.city ?? '';
    String country = user?.addresses?.firstOrNull?.country ?? '';
    String basedInValue =
        [city, country].where((element) => element.isNotEmpty).join(', ');
    return basedInValue.isNotEmpty ? basedInValue : emptyText;
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
