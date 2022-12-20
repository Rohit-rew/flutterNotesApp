

import 'package:flutter/material.dart';

class Register_View extends StatefulWidget {
  Register_View({super.key});
  @override
  State<Register_View> createState() => _Register_View();
}

class _Register_View extends State<Register_View>{

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
  Widget build(BuildContext context){
    print("Register mounts");
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                TextField(
                  controller: _email,
                  decoration: const  InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                          borderSide: BorderSide(color: Colors.black , width: 1)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black , width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                          borderSide: BorderSide(color: Colors.black , width: 1)
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black , width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye))
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: _confirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        borderSide: BorderSide(color: Colors.black , width: 1)
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black , width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye),),
                  ),

                ),
                ElevatedButton(onPressed: (){
                  if(_password.text == _confirmPassword.text){
                    print(_email.text);
                    print(_confirmPassword.text);
                    print("passwords match");
                  }else{
                    print("passwords do not match");
                  }

                }, child: const Text("Register"),),
                TextButton(onPressed: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView() ),);
                  Navigator.of(context).pushNamedAndRemoveUntil("/login/", (route) => false);
                }, child: const Text("Login"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}