import 'package:flutter/material.dart';

Future showSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: const [Icon(Icons.done), Text("Registered Successfuly")],
        ),
        content: const Text("Please log in"),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login/", (route) => false);
            },
            child: const Text("Login"),
          )
        ],
      );
    },
  );
}
