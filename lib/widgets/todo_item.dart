/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import '../models/todo.dart';

/// A widget that displays a single todos item in a list.
class TodoItem extends StatelessWidget {
  final Todo todo; // The todos item to display.
  final Function(String) toggleStatus; // Callback to toggle the status of the todos.

  TodoItem({
    required this.todo,
    required this.toggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title), // Display the title of the todos.
      subtitle: Text(todo.description), // Display the description of the todos.
      trailing: Checkbox(
        value: todo.isDone, // Checkbox to indicate whether the todos is done.
        onChanged: (val) => toggleStatus(todo.id), // Toggle the status when the checkbox is tapped.
      ),
    );
  }
}
