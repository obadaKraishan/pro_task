/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import 'add_todo_screen.dart';

/// This screen displays the details of a todos item and allows editing and deletion.
class TodoDetailScreen extends StatelessWidget {
  final Todo todo;
  final Function(String) toggleStatus;
  final Function(String) deleteTodo;
  final Function(Todo) updateTodo;

  TodoDetailScreen({
    required this.todo,
    required this.toggleStatus,
    required this.deleteTodo,
    required this.updateTodo,
  });

  /// Formats the DateTime to a more readable string.
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set back button color to white
        ),
        title: Text('Todo Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () async {
              // Navigate to the AddTodoScreen to edit the current todos.
              final updatedTodo = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AddTodoScreen(todo: todo),
                ),
              );
              if (updatedTodo != null) {
                updateTodo(updatedTodo);
                Navigator.of(context).pop(updatedTodo); // Pass back the updated todos
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              // Delete the current todos and close the screen.
              deleteTodo(todo.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              todo.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Created: ${_formatDateTime(todo.createdTime)}',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              'Updated: ${_formatDateTime(todo.updatedTime)}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ${todo.isDone ? "Completed" : "Pending"}',
                  style: TextStyle(
                      fontSize: 18,
                      color: todo.isDone ? Colors.green : Colors.red),
                ),
                ElevatedButton(
                  child: Text(todo.isDone ? 'Mark as Pending' : 'Mark as Done'),
                  onPressed: () {
                    // Toggle the status of the todos item.
                    toggleStatus(todo.id);
                    Navigator.of(context).pop(todo);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
