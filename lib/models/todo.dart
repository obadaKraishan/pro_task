/*
 * Copyright (c) 2024, Obada Kraishan
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:hive/hive.dart';

part 'todo.g.dart';

/// A model class representing a Todos item.
@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String id; // Unique identifier for the todos item.

  @HiveField(1)
  String title; // Title of the todos item.

  @HiveField(2)
  String description; // Description of the todos item.

  @HiveField(3)
  bool isDone; // Status of the todos item (true if completed, false otherwise).

  @HiveField(4)
  DateTime createdTime; // The time when the todos item was created.

  @HiveField(5)
  DateTime updatedTime; // The time when the todos item was last updated.

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.createdTime,
    required this.updatedTime,
  });
}
