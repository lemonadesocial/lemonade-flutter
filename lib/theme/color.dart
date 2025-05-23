import 'package:app/app_theme/colors/dark_theme_color.dart';
import 'package:flutter/material.dart';

// Support convert color to hex string
extension ColorExtension on Color {
  String toHex() => '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
}

class LemonColor {
  static Color black = const Color(0xff000000);
  static Color black50 = const Color.fromRGBO(0, 0, 0, 0.5);
  static Color black87 = const Color(0x000f0f0f).withOpacity(0.87);
  static Color atomicBlack = const Color(0xff0f0f0f);
  static Color raisinBlack = const Color(0xff212121);
  static Color raisinBlack0 = const Color(0xff212121).withOpacity(0);
  static Color chineseBlack = const Color(0xff171717);
  static Color oliveBlack = const Color(0xff404040);
  static Color tertiaryBlack = const Color(0x4Debebf5);
  static Color white = const Color(0xffffffff);
  static Color white03 = const Color(0xffFFFFFF).withOpacity(0.03);
  static Color white06 = const Color(0xffFFFFFF).withOpacity(0.06);
  static Color white09 = const Color(0xffFFFFFF).withOpacity(0.09);
  static Color white6 = const Color(0xffFFFFFF).withOpacity(0.6);
  static Color white10 = const Color(0xffFFFFFF).withOpacity(0.10);
  static Color white12 = const Color(0xffFFFFFF).withOpacity(0.12);
  static Color white12Solid = const Color.fromRGBO(75, 75, 75, 1);
  static Color white15 = const Color(0xffFFFFFF).withOpacity(0.15);
  static Color white18 = const Color(0xffFFFFFF).withOpacity(0.18);
  static Color white23 = const Color(0xffFFFFFF).withOpacity(0.23);
  static Color white36 = const Color(0xffFFFFFF).withOpacity(0.36);
  static Color white54 = const Color(0xffFFFFFF).withOpacity(0.54);
  static Color white72 = const Color(0xffFFFFFF).withOpacity(0.72);
  static Color white87 = const Color(0xffFFFFFF).withOpacity(0.87);
  static Color lavender = const Color(0xffA667F3);
  static Color lavender18 = const Color(0xffA667F3).withOpacity(0.18);
  static Color paleViolet = const Color(0xffC69DF7);
  static Color paleViolet12 = const Color(0xffC69DF7).withOpacity(0.12);
  static Color paleViolet18 = const Color(0xffC69DF7).withOpacity(0.18);
  static Color paleViolet36 = const Color(0xffC69DF7).withOpacity(0.36);
  static Color red = const Color(0xFFFE4A49);
  static const errorRedBg = Color(0xFFED7E8C);
  static const usernameApproved = Color(0xFF49DB95);
  static Color black54 = const Color(0xff000000).withOpacity(0.54);
  static Color online = const Color(0xFF5FCB90);
  static Color ownMessage = const Color(0xFF8F71B2);
  static Color otherMessage = const Color(0xFF272727);
  static Color shadow5b = const Color(0x5B000000);
  static Color greyBg = const Color(0xFF494949);
  static Color black33 = const Color(0xFF333333);
  static Color darkCharcoalGray = const Color(0xFF1B1B1B);
  static Color babyPurple = const Color(0xFFc69df7);

  // UI specific
  static Color dropdownBackground = const Color.fromARGB(221, 32, 32, 32);
  static Color dialogBackground = const Color(0xFF141414);

  // Button
  static Color arsenic = const Color(0xff424242);
  static Color charlestonGreen = const Color(0xff2c2c2c);
  static Color buttonLinear1 = const Color(0xFFB17AF4);
  static Color buttonLinear2 = const Color(0xFF6F3FAA);
  static Color grape = const Color(0xffB17AF4);
  static Color shadow = const Color.fromARGB(91, 0, 0, 0);
  static Color disableButtonLavender = const Color(0xFF3c2557);

  // Slider
  static Color sunrise = const Color(0xffFFDB00);
  static Color sunrise18 = const Color(0xffFFDB00).withOpacity(0.18);

  // Textfield
  static Color darkCharcoal = const Color(0xff2e2e2e);
  static const onboardingTitle = Color(0xFFDDDDDD);

  // FAB
  static const fabSecondaryBg = Color(0xFFB17AF4);
  static const fabFirstBg = Color(0xFF6F3FAA);
  static const fabShadow = Color(0x89090909);

  // Onboarding gender color
  static const femaleDefault = Color(0x2DF691B5);
  static const maleDefault = Color(0x1E91C0F6);
  static const ambiguousDefault = Color(0x1EA591F6);
  static const femaleActiveColor = Color(0xFFF691B5);
  static const maleActiveColor = Color(0xFF91C0F6);
  static const ambiguousActiveColor = Color(0xFFA591F6);

  // ripple animation
  static const rippleMarkerColor = Color.fromRGBO(89, 210, 116, 0.24);
  static const rippleDark = Color.fromRGBO(32, 41, 38, 1);

  // custom red error
  static const menuRed = Color(0xFFFF6565);
  static const deleteAccountRed = Color(0xFFE58585);

  // Progress indicator
  static const progressBg = Color(0xFF5E4E70);

  // event buy tickets
  static const promoApplied = Color(0xff5fcb90);
  static const promoAppliedBackground = Color(0x2D5ECA90);
  static const darkBackground = Color(0xFF1d1d1d);

  // Create post dialog
  static const collectibleColor = Color(0xFFFFA6C6);
  static const poapColor = Color(0xFF9DF7E7);
  static const roomColor = Color(0xFFF7B39D);
  static const postColor = Color(0xFF9DC1F7);

  // My event ticket
  static const downloadIcColor = Color(0xffff9500);
  static Color downloadBgColor = const Color(0xffff9500).withOpacity(0.24);

  static const inviteIcColor = Color(0xffffc50f);
  static Color inviteBgColor = const Color(0xffffc50f).withOpacity(0.24);

  static const assignIcColor = Color(0xffA667F3);
  static Color assignBgColor = const Color(0xffba82ff);

  static const mailIcColor = Color(0xffff7979);
  static Color mailBgColor = const Color(0xffff7979).withOpacity(0.24);

  static const accessCodeColor = Color(0xffABD611);

  //Snackbar
  static const snackBarSuccess = Color(0xff5fcb90);
  static const jet = Color(0xff353535);

  // report
  static const report = Color(0xffFF6565);

  //Switch
  static const switchActive = Color(0xFFABC93D);

  static const coralReef = Color(0xFFF57968);

  static const malachiteGreen = Color(0xFF67F38E);

  static const acidGreen = Color(0x2DC69DF7);
  static const cloudyGrey = Color(0xFF6A6A6A);
  static const jordyBlue = Color(0xFF86B4F8);
  static const venetianRed = Color(0xFFF19884);
  static const topaz = Color(0xFFFFD177);

  // farcaster
  static const farcasterViolet = Color.fromRGBO(134, 96, 204, 1);
  static const aero = Color(0xff68A0F5);

  static const rajah = Color(0xffF5AC68);

  // voting
  static const blueBerry = Color(0xff4B84FF);
  static const royalOrange = Color(0xffFF8E42);

  // token gating
  static const fluorescentBlue = Color(0xff19E8E2);
  static const darkCyan = Color(0xff008F91);
}

final ColorScheme lemonadeLightThemeColorScheme = ColorScheme.light(
  primary: LemonColor.white,
  onPrimary: LemonColor.black,
  secondary: LemonColor.white54,
  onSecondary: LemonColor.raisinBlack,
  background: LemonColor.white,
  onBackground: LemonColor.black,
  tertiary: LemonColor.paleViolet,
  onTertiary: LemonColor.lavender,
  surface: LemonColor.white72,
  surfaceVariant: LemonColor.white72,
  onSurface: LemonColor.raisinBlack,
  onSurfaceVariant: LemonColor.raisinBlack,
  outline: LemonColor.oliveBlack,
  tertiaryContainer: LemonColor.tertiaryBlack,
  onPrimaryContainer: LemonColor.dialogBackground,
  errorContainer: LemonColor.errorRedBg,
);

final ColorScheme lemonadeDarkThemeColorScheme = ColorScheme.dark(
  // primary: LemonColor.black,
  // primaryContainer: LemonColor.darkCharcoal,
  // onPrimary: LemonColor.white,
  // secondary: LemonColor.raisinBlack,
  // secondaryContainer: LemonColor.chineseBlack,
  // onSecondary: LemonColor.white54,
  // tertiary: LemonColor.paleViolet,
  // onTertiary: LemonColor.lavender,
  // background: LemonColor.black,
  // onBackground: LemonColor.white,
  // surface: LemonColor.raisinBlack,
  // surfaceVariant: LemonColor.black87,
  // onSurface: LemonColor.white72,
  // onSurfaceVariant: LemonColor.white36,
  // outline: LemonColor.white12,
  // outlineVariant: LemonColor.white03,
  // tertiaryContainer: LemonColor.tertiaryBlack,
  // onPrimaryContainer: LemonColor.dialogBackground,
  // onSecondaryContainer: LemonColor.disableButtonLavender,
  // errorContainer: LemonColor.errorRedBg,
  primary: darkThemeColors.pageBg,
  primaryContainer: darkThemeColors.pageBg,
  onPrimary: darkThemeColors.textPrimary,
  secondary: darkThemeColors.pageBg,
  secondaryContainer: darkThemeColors.pageBg,
  onSecondary: darkThemeColors.textTertiary,
  tertiary: darkThemeColors.buttonTertiaryBg,
  onTertiary: darkThemeColors.buttonTertiary,
  background: darkThemeColors.pageBg,
  onBackground: darkThemeColors.textPrimary,
  surface: darkThemeColors.cardBg,
  surfaceVariant: darkThemeColors.cardBg,
  onSurface: darkThemeColors.textTertiary,
  onSurfaceVariant: darkThemeColors.textTertiary,
  outline: darkThemeColors.pageDivider,
  outlineVariant: darkThemeColors.pageDivider,
  tertiaryContainer: darkThemeColors.buttonTertiaryBg,
  onPrimaryContainer: darkThemeColors.pageBg,
  errorContainer: darkThemeColors.buttonErrorBg,
);
