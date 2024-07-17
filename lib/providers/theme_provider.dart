/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';

/// A provider class for managing the app's theme.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // The current theme mode of the app.

  /// Getter to retrieve the current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Toggles the theme mode between light and dark based on the boolean value.
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners to rebuild the UI with the new theme.
  }
}
