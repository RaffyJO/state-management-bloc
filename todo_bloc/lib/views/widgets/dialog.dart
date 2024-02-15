import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onTap;
  final String titleDialog;

  const CustomDialog({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onTap,
    required this.titleDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DInput(
          title: 'Title',
          controller: titleController,
        ),
        const SizedBox(
          height: 10,
        ),
        DInput(
          title: 'Description',
          controller: descriptionController,
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: onTap,
          child: Text(titleDialog),
        )
      ],
    );
  }
}
