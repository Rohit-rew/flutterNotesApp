import 'package:flutter/material.dart';

Future showErrorDialog(BuildContext context, String errMsg) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error),
            Container(
              width: 10,
            ),
            const Text("Error"),
          ],
        ),
        content: Text(errMsg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("ok"),
          )
        ],
      );
    },
  );
}
