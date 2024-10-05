//lib/widgets/add_point_form.dart
import 'package:flutter/material.dart';

class AddPointForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const AddPointForm({super.key, 
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Título"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: "Descripción"),
        ),
      ],
    );
  }
}
