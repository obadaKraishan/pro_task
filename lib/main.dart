/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Hive.initFlutter(); // Initialize Hive for Flutter
  Hive.registerAdapter(TodoAdapter()); // Register the Todos adapter with Hive
  await Hive.openBox<Todo>('todos'); // Open a Hive box for storing todos
  runApp(MyApp()); // Run the MyApp widget
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Create a ThemeProvider instance
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Advanced Todo App',
            debugShowCheckedModeBanner: false, // Remove the debug banner
            themeMode: themeProvider.themeMode, // Use the theme mode from ThemeProvider
            theme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                color: Colors.purple[400],
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.dark,
              appBarTheme: AppBarTheme(
                color: Colors.purple[700],
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            home: HomeScreen(), // Set HomeScreen as the home widget
          );
        },
      ),
    );
  }
}
