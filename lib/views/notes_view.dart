import 'package:flutter/material.dart';
import 'package:notes/services/auth/Auth.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:notes/services/storage/sqlite_storage_service.dart';
import 'package:notes/utils/error_dialog.dart';

class Notes_View extends StatefulWidget {
  const Notes_View({super.key});
  @override
  State<Notes_View> createState() => _Notes_View();
}

class _Notes_View extends State<Notes_View> {
  late NoteService _noteService;
  List<Note> arrNotes = [];

  Future<void> getAllNotes() async {
    List<Note> allnotes = await _noteService.getNotes();
    arrNotes = allnotes;
    print(arrNotes);
  }

  Future<void> startService() async {
    _noteService = NoteService();
    _noteService.openDb().whenComplete(() async {
      return await getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: startService(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Scaffold(
                appBar: AppBar(title: const Text("Notes"), actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: "Logout",
                          child: Text("Logout"),
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
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/login/", (route) => false);
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
                        leading: Text(arrNotes[index].id.toString()),
                        title: Text(arrNotes[index].text),
                        subtitle: Text(arrNotes[index].text),
                        trailing: const Icon(Icons.delete_outline),
                      ),
                    );
                  },
                  itemCount: arrNotes.length,
                ),
                floatingActionButton: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              );
            default:
              return Scaffold(
                appBar: AppBar(
                  title: Text("Notes"),
                ),
                body: const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
          }
        });
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
