/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';

/// This screen is used to add or edit a Todos item.
class AddTodoScreen extends StatefulWidget {
  final Todo? todo;

  AddTodoScreen({this.todo});

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If a todos is passed, pre-fill the fields with its details.
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
    }
  }

  /// Saves the todos item. If either field is empty, shows an error message.
  void _saveTodo() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showErrorMessage("Both fields are required");
      return;
    }

    final newTodo = Todo(
      id: widget.todo?.id ?? Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text,
      createdTime: widget.todo?.createdTime ?? DateTime.now(),
      updatedTime: DateTime.now(),
    );

    // Close the screen and return the new/updated todos item.
    Navigator.of(context).pop(newTodo);
  }

  /// Displays an error message using a SnackBar.
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set back button color to white
        ),
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: _saveTodo,
            ),
          ],
        ),
      ),
    );
  }
}
