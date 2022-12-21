import 'package:flutter/material.dart';
import 'package:notes/services/Auth.dart';
import 'package:notes/services/auth_exceptions.dart';
import 'package:notes/utils/error_dialog.dart';

class Notes_View extends StatefulWidget {
  Notes_View({super.key});
  @override
  State<Notes_View> createState() => _Notes_View();
}

class _Notes_View extends State<Notes_View> {
  List arrNotes = [
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
    {"title": "My Note", "note": "buy grocery"},
  ];

  @override
  Widget build(BuildContext context) {
    print(arrNotes.length);
    return Scaffold(
      appBar: AppBar(title: Text("Notes"), actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: "Logout",
                child: const Text("Logout"),
              )
            ];
          },
          onSelected: (value) async {
            switch (value) {
              case "Logout":
                bool logout = await showLogoutConfirmation(context);
                if (logout) {
                  try {
                    await FirebaseAuthService.logoutUser();
                  } on UserNotLoggedInAuthException {
                    showErrorDialog(context, "User Not Logegd In");
                  } catch (e) {
                    showErrorDialog(context, "Something Went Wrong");
                  }
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login/", (route) => false);
                }
                break;
              default:
                break;
            }
          },
        )
      ]),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text('${index + 1}'),
              title: Text(arrNotes[index]['title']),
              subtitle: Text(arrNotes[index]['note']),
              trailing: Icon(Icons.delete_outline),
            ),
          );
        },
        itemCount: arrNotes.length,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<bool> showLogoutConfirmation(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout ?"),
          content: const Text("Are you sure you want to Logout ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Logout")),
          ],
        );
      }).then((value) => value ?? false);
}
