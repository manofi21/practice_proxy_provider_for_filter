import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  final String title;
  final List<Widget> listWidget;
  const BasicDialog({Key? key, required this.title, required this.listWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Row(
          children: [
            Text(title),
            const Spacer(),
            InkWell(
              child: const Icon(Icons.close),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 23.0, vertical: 15),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listWidget,
      ),
    );
  }
}
