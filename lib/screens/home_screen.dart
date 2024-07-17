/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';
import 'add_todo_screen.dart';
import 'todo_detail_screen.dart';
import '../providers/theme_provider.dart';

/// The main screen displaying the list of todos items.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Todo> _todoBox;

  @override
  void initState() {
    super.initState();
    // Initialize the Hive box for todos.
    _todoBox = Hive.box<Todo>('todos');
  }

  /// Adds or edits a todos item in the Hive box.
  void _addOrEditTodo({
    required String id,
    required String title,
    required String description,
    bool isEditing = false,
  }) {
    final newTodo = Todo(
      id: id,
      title: title,
      description: description,
      createdTime: isEditing ? _todoBox.get(id)!.createdTime : DateTime.now(),
      updatedTime: DateTime.now(),
      isDone: isEditing ? _todoBox.get(id)!.isDone : false,
    );

    setState(() {
      _todoBox.put(id, newTodo);
    });
  }

  /// Toggles the status of a todos item.
  void _toggleTodoStatus(String id) {
    final todo = _todoBox.get(id);
    if (todo != null) {
      final updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isDone: !todo.isDone,
        createdTime: todo.createdTime,
        updatedTime: DateTime.now(),
      );
      _todoBox.put(id, updatedTodo);
      setState(() {});
    }
  }

  /// Deletes a todos item from the Hive box.
  void _deleteTodo(String id) {
    _todoBox.delete(id);
    setState(() {});
  }

  /// Updates a todos item in the Hive box.
  void _updateTodo(Todo updatedTodo) {
    _todoBox.put(updatedTodo.id, updatedTodo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Todo App'),
        actions: [
          // Switch to toggle between light and dark mode.
          Switch(
            value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _todoBox.listenable(),
        builder: (context, Box<Todo> box, _) {
          final todos = box.values.toList().cast<Todo>();

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () async {
                  // Navigate to the TodoDetailScreen to view and edit the selected todos.
                  final updatedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => TodoDetailScreen(
                        todo: todos[index],
                        toggleStatus: _toggleTodoStatus,
                        deleteTodo: _deleteTodo,
                        updateTodo: _updateTodo,
                      ),
                    ),
                  );
                  if (updatedTodo != null) {
                    _updateTodo(updatedTodo);
                  }
                },
                child: TodoItem(
                  todo: todos[index],
                  toggleStatus: _toggleTodoStatus,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // Navigate to the AddTodoScreen to add a new todos.
          final newTodo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AddTodoScreen()),
          );
          if (newTodo != null) {
            _addOrEditTodo(
              id: newTodo.id,
              title: newTodo.title,
              description: newTodo.description,
            );
          }
        },
      ),
    );
  }
}
