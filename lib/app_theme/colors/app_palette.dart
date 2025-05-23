import 'package:flutter/material.dart';

abstract class AppPalette {
  static final black = _BlackColors();

  static final white = _WhiteColors();

  static final woodSmoke = _WoodsmokeColors();

  static final shark = _SharkColors();

  static final violet = _VioletColors();

  static final emerald = _EmeraldColors();

  static final blue = _BlueColors();

  static final amber = _AmberColors();

  static final rose = _RoseColors();
}

/// Alternative way to group colors in the palette.
///
/// The downside is that you won't be able
/// to use them as constructor default values,
/// because they are not constants.
class _BlackColors {
  _BlackColors();
  final black950 = Colors.black.withAlpha(0);
  final black950_4 = Colors.black.withAlpha(10);
  final black950_8 = Colors.black.withAlpha(20);
  final black950_12 = Colors.black.withAlpha(31);
  final black950_16 = Colors.black.withAlpha(41);
  final black950_24 = Colors.black.withAlpha(61);
  final black950_28 = Colors.black.withAlpha(71);
  final black950_32 = Colors.black.withAlpha(82);
  final black950_40 = Colors.black.withAlpha(102);
  final black950_48 = Colors.black.withAlpha(122);
  final black950_56 = Colors.black.withAlpha(143);
  final black950_64 = Colors.black.withAlpha(163);
  final black950_72 = Colors.black.withAlpha(184);
  final black950_80 = Colors.black.withAlpha(204);
  final black950_100 = Colors.black;
}

class _WhiteColors {
  _WhiteColors();
  final white50 = Colors.white.withAlpha(0);
  final white50_4 = Colors.white.withAlpha(10);
  final white50_8 = Colors.white.withAlpha(20);
  final white50_12 = Colors.white.withAlpha(31);
  final white50_16 = Colors.white.withAlpha(41);
  final white50_24 = Colors.white.withAlpha(61);
  final white50_28 = Colors.white.withAlpha(71);
  final white50_32 = Colors.white.withAlpha(82);
  final white50_40 = Colors.white.withAlpha(102);
  final white50_48 = Colors.white.withAlpha(122);
  final white50_56 = Colors.white.withAlpha(143);
  final white50_64 = Colors.white.withAlpha(163);
  final white50_72 = Colors.white.withAlpha(184);
  final white50_80 = Colors.white.withAlpha(204);
  final white50_100 = Colors.white;
}

class _WoodsmokeColors {
  final woodSmoke50 = const Color(0xFFF7F7F8);
  final woodSmoke50_80 = const Color(0xCCF7F7F8);
  final woodSmoke100 = const Color(0xFFEEEDF1);
  final woodSmoke200 = const Color(0xFFD9D8DF);
  final woodSmoke300 = const Color(0xFFB8B5C4);
  final woodSmoke400 = const Color(0xFF918DA3);
  final woodSmoke500 = const Color(0xFF736F88);
  final woodSmoke600 = const Color(0xFF5E5970);
  final woodSmoke700 = const Color(0xFF4C495B);
  final woodSmoke800 = const Color(0xFF423F4D);
  final woodSmoke900 = const Color(0xFF393743);
  final woodSmoke950 = const Color(0xFF141317);
  final woodSmoke950_64 = const Color(0xA3141317);
  final woodSmoke950_80 = const Color(0xCC141317);
}

class _SharkColors {
  final shark50 = const Color(0xFFF5F5F6);
  final shark100 = const Color(0xFFE6E6E7);
  final shark200 = const Color(0xFFCFD0D2);
  final shark300 = const Color(0xFFADAEB3);
  final shark400 = const Color(0xFF84858C);
  final shark500 = const Color(0xFF696A71);
  final shark600 = const Color(0xFF5A5B60);
  final shark700 = const Color(0xFF4D4D51);
  final shark800 = const Color(0xFF434347);
  final shark900 = const Color(0xFF3B3B3E);
  final shark950 = const Color(0xFF202022);
  final shark950_80 = const Color(0xCC202022);
}

class _VioletColors {
  final violet50 = const Color(0xFFF5F3FF);
  final violet100 = const Color(0xFFEDE9FE);
  final violet200 = const Color(0xFFDDD6FF);
  final violet300 = const Color(0xFFC4B4FF);
  final violet400 = const Color(0xFFA684FF);
  final violet400_16 = const Color(0x28A684FF);
  final violet500 = const Color(0xFF8E51FF);
  final violet600 = const Color(0xFF7F22FE);
  final violet600_16 = const Color(0x287F22FE);
  final violet700 = const Color(0xFF7008E7);
  final violet800 = const Color(0xFF5D0EC0);
  final violet900 = const Color(0xFF4D179A);
  final violet950 = const Color(0xFF2F0D68);
}

class _EmeraldColors {
  final emerald50 = const Color(0xFFECFDF5);
  final emerald100 = const Color(0xFFD0FAE5);
  final emerald200 = const Color(0xFFA4F4CF);
  final emerald300 = const Color(0xFF5EE9B5);
  final emerald400 = const Color(0xFF00D492);
  final emerald500 = const Color(0xFF00BC7D);
  final emerald500_16 = const Color(0x2800BC7D);
  final emerald600 = const Color(0xFF009966);
  final emerald700 = const Color(0xFF007A55);
  final emerald700_16 = const Color(0x28007A55);
  final emerald800 = const Color(0xFF006045);
  final emerald900 = const Color(0xFF004F3B);
  final emerald950 = const Color(0xFF002C22);
}

class _BlueColors {
  final blue50 = const Color(0xFFEFF6FF);
  final blue100 = const Color(0xFFDBEAFE);
  final blue200 = const Color(0xFFBEDBFF);
  final blue300 = const Color(0xFF8EC5FF);
  final blue400 = const Color(0xFF51A2FF);
  final blue400_16 = const Color(0x2851A2FF);
  final blue500 = const Color(0xFF2B7FFF);
  final blue600 = const Color(0xFF155DFC);
  final blue600_16 = const Color(0x28155DFC);
  final blue700 = const Color(0xFF1447E6);
  final blue800 = const Color(0xFF193CB8);
  final blue900 = const Color(0xFF1C398E);
  final blue950 = const Color(0xFF162456);
}

class _AmberColors {
  final amber50 = const Color(0xFFFFFBEB);
  final amber100 = const Color(0xFFFEF3C6);
  final amber200 = const Color(0xFFFEE685);
  final amber300 = const Color(0xFFFFD230);
  final amber300_16 = const Color(0x28FFD230);
  final amber400 = const Color(0xFFFFB900);
  final amber500 = const Color(0xFFFE9A00);
  final amber500_16 = const Color(0x28FE9A00);
  final amber600 = const Color(0xFFE17100);
  final amber700 = const Color(0xFFBB4D00);
  final amber800 = const Color(0xFF973C00);
  final amber900 = const Color(0xFF7B3306);
  final amber950 = const Color(0xFF461901);
}

class _RoseColors {
  final rose50 = const Color(0xFFFFF1F2);
  final rose100 = const Color(0xFFFFE4E6);
  final rose200 = const Color(0xFFFFCCD3);
  final rose300 = const Color(0xFFFFA1AD);
  final rose400 = const Color(0xFFFF637E);
  final rose400_16 = const Color(0x28FF637E);
  final rose500 = const Color(0xFFFF2056);
  final rose600 = const Color(0xFFEC003F);
  final rose600_16 = const Color(0x28EC003F);
  final rose700 = const Color(0xFFC70036);
  final rose800 = const Color(0xFFA50036);
  final rose900 = const Color(0xFF8B0836);
  final rose950 = const Color(0xFF4D0218);
}
