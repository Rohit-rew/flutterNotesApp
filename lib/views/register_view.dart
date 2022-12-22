import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/auth/Auth.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:notes/utils/error_dialog.dart';

import '../utils/success_dialog.dart';

class Register_View extends StatefulWidget {
  Register_View({super.key});
  @override
  State<Register_View> createState() => _Register_View();
}

class _Register_View extends State<Register_View> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_red_eye))),
                ),
                TextField(
                  obscureText: true,
                  controller: _confirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_password.text == _confirmPassword.text) {
                      try {
                        String email = _email.text;
                        String password = _password.text;
                        await FirebaseAuthService.registerNewUser(
                            email: email, password: password);
                        showSuccessDialog(context);
                        // send user to another route if registered in
                      } on EmailAlreadyInUseAuthException {
                        showErrorDialog(context, "Email already in use");
                      } on InvalidEmailAuthException {
                        showErrorDialog(context, "Invalid Email");
                      } on WeekpasswordAuthException {
                        showErrorDialog(context, "Weak password");
                      } on GenericAuthException {
                        showErrorDialog(context, "Something Went Wrong");
                      } catch (e) {
                        showErrorDialog(context, e.toString());
                      }
                    } else {
                      showErrorDialog(context, "Passwords do not match");
                    }
                  },
                  child: const Text("Register"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (route) => false);
                  },
                  child: const Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
