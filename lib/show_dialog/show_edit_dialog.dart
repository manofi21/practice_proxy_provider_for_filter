import 'package:flutter/material.dart';

void showEditDialog(
    BuildContext context, TextEditingController nameController) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: TextFormField(
                controller: nameController,
              ),
            ),
          ],
        ),
      );
    },
  );
}
