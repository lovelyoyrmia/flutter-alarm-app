import 'dart:ui';

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<Color> air = [Color(0xFF61A3FE), Color(0xFF5FC6FF)];
}

class GradientAlarmTemplate {
  static List<GradientColors> color = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.air),
  ];
}

class GradientMyListTemplate {
  static List<GradientColors> color = [
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.air),
    GradientColors(GradientColors.fire),
    
  ];
}
