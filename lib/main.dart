import 'package:flutter/material.dart';
import 'package:notes/services/auth/Auth.dart';
import 'package:notes/services/storage/sqlite_storage_service.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/notes_view.dart';
import 'package:notes/views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AddNoteView(),
      routes: {
        "/login/": (context) => const LoginView(),
        "/register/": (context) => Register_View(),
        "/notes/": (context) => Notes_View(),
      },
    ),
  );
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuthService.initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            var user = FirebaseAuthService.currentUser();
            if (user != null) {
              return Notes_View();
            } else {
              return const LoginView();
            }
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteView();
}

class _AddNoteView extends State<AddNoteView> {
  late TextEditingController noteText;

  @override
  void initState() {
    noteText = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    noteText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: Center(
        child: Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: noteText,
                  decoration: const InputDecoration(
                      hintText: "Enter your note here",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      )),
                ),
                ElevatedButton(
                    onPressed: () {
                      print(noteText.text);
                    },
                    child: const Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
