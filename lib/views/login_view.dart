import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: hideText,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideText = !hideText;
                          });
                        },
                        icon: Icon(Icons.remove_red_eye,
                            color: hideText ? Colors.grey : Colors.green),
                      )),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String email = _email.text;
                      String password = _password.text;
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: password);
                      // do something on successfull login
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/notes/", (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "wrong-password") {
                        showErrorDialog(context, "Wrong Password");
                      } else if (e.code == "user-not-found") {
                        showErrorDialog(context, "User does not exist");
                      } else if (e.code == "invalid-email") {
                        showErrorDialog(context, "Invalid Email");
                      } else {
                        showErrorDialog(context, e.code.toString());
                      }
                    } catch (e) {
                      // show generic error code
                      showErrorDialog(context, e.toString());
                    }
                  },
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> Register_View(),),);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/register/", (route) => false);
                  },
                  child: const Text("Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future showErrorDialog(BuildContext context, String errMsg) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
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
