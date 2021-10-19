import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isLightTheme = false;

  void changeTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;
}
