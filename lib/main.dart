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
      home: const HomeView(),
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
