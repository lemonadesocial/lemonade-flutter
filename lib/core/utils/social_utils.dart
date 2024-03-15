import 'package:app/core/config.dart';

class SocialUtils {
  static RegExp get twitterRegx => RegExp(r'twitter', caseSensitive: false);

  static RegExp get githubRegx => RegExp(r'github', caseSensitive: false);

  static RegExp get instagramRegx => RegExp(r'instagram', caseSensitive: false);

  static RegExp get linkedInRegx => RegExp(r'linkedin', caseSensitive: false);

  static RegExp get facebookRegx => RegExp(r'facebook', caseSensitive: false);

  static bool isSocialFieldName({
    required String fieldName,
  }) {
    return twitterRegx.hasMatch(fieldName) ||
        githubRegx.hasMatch(fieldName) ||
        instagramRegx.hasMatch(fieldName) ||
        linkedInRegx.hasMatch(fieldName) ||
        facebookRegx.hasMatch(fieldName);
  }

  static String buildSocialLinkBySocialFieldName({
    required String socialFieldName,
    required String socialUserName,
  }) {
    if (socialFieldName.isEmpty || socialUserName.isEmpty) {
      return '';
    }
    String urlPrefix = '';
    if (twitterRegx.hasMatch(socialFieldName)) {
      urlPrefix = AppConfig.twitterUrl;
    }

    if (githubRegx.hasMatch(socialFieldName)) {
      urlPrefix = AppConfig.githubUrl;
    }

    if (instagramRegx.hasMatch(socialFieldName)) {
      urlPrefix = AppConfig.instagramUrl;
    }

    if (linkedInRegx.hasMatch(socialFieldName)) {
      urlPrefix = AppConfig.linkedinUrl;
    }

    if (facebookRegx.hasMatch(socialFieldName)) {
      urlPrefix = AppConfig.facebookUrl;
    }

    return '$urlPrefix/$socialUserName';
  }
}
