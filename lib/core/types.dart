import 'dart:collection';

import 'package:flutter/material.dart';

typedef CategoryEntry = DropdownMenuEntry<CategoryOptions>;

enum CategoryOptions {
  cat("Cat", "cat"),
  flowers("Flowers", "flowers");

  const CategoryOptions(this.label, this.value);
  final String label;
  final String value;

  static final List<CategoryEntry> entries =
      UnmodifiableListView<CategoryEntry>(
        values.map<CategoryEntry>(
          (CategoryOptions category) =>
              CategoryEntry(value: category, label: category.label),
        ),
      );
}
