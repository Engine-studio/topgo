import 'package:flutter/widgets.dart';

class ClrStyle {
  static const Color lightBackground = const Color(0xFFFDFDFD);
  static const Color darkBackground = const Color(0xFFEEEDED);
  static const Color lightPanel = const Color(0xFF6AA5D7);
  static const Color darkPanel = const Color(0xFF6788DA);
  static const Color lightDecline = const Color(0xFFFF8C82);
  static const Color darkDecline = const Color(0xFFFE6250);
  static const Color lightAccept = const Color(0xFF96D35F);
  static const Color darkAccept = const Color(0xFF76BB40);
  static const Color lightSelect = const Color(0xFFFECB3E);
  static const Color darkSelect = const Color(0xFFFEB43F);
  static const Color lightButton = const Color(0xFF937FF5);
  static const Color darkButton = const Color(0xFF735CE6);
  static const Color lightWave = const Color(0xFF16A7D8);
  static const Color darkWave = const Color(0xFF1290B4);
  static const Color text = const Color(0xFF31477B);
  static const Color icons = const Color(0xFF31477B);
  static const Color dropShadow = const Color(0x266A9DD9);
}

class TxtStyle {
  static const TextStyle mainHeader = const TextStyle(
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: ClrStyle.text,
  );
  static const TextStyle smallHeader = const TextStyle(
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: ClrStyle.text,
  );
  static const TextStyle button = const TextStyle(
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: ClrStyle.text,
  );
  static const TextStyle mainText = const TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: ClrStyle.text,
  );
  static const TextStyle selectedMainText = const TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: ClrStyle.text,
  );
  static const TextStyle smallText = const TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: ClrStyle.text,
  );
  static const TextStyle selectedSmallText = const TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: ClrStyle.text,
  );
}

class GrdStyle {
  static const LinearGradient panel = const LinearGradient(colors: [
    ClrStyle.lightPanel,
    ClrStyle.darkPanel,
  ]);
  static const LinearGradient decline = const LinearGradient(colors: [
    ClrStyle.lightDecline,
    ClrStyle.darkDecline,
  ]);
  static const LinearGradient accept = const LinearGradient(colors: [
    ClrStyle.lightAccept,
    ClrStyle.darkAccept,
  ]);
  static const LinearGradient select = const LinearGradient(colors: [
    ClrStyle.lightSelect,
    ClrStyle.darkSelect,
  ]);
  static const LinearGradient button = const LinearGradient(colors: [
    ClrStyle.lightButton,
    ClrStyle.darkButton,
  ]);
  static const LinearGradient wave = const LinearGradient(colors: [
    ClrStyle.lightWave,
    ClrStyle.darkWave,
  ]);
  static const LinearGradient splash = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xFF16A7D8),
      const Color(0xFF937FF5),
    ],
  );
  static const LinearGradient lightPanel = const LinearGradient(colors: [
    const Color(0x336AA5D7),
    const Color(0x336788DA),
  ]);
}
