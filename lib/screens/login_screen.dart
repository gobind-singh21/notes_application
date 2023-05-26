import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/screens/home_screen.dart';
import 'package:notes_application/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = "";
  bool isLogin = true;

  bool _passwordNotVisible = true;

  bool _changeButton = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _changeButton = true;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.popUntil(context, ModalRoute.withName('name'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = "";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 43.85,
                ),
                Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.cover,
                  height: screenHeight / 4,
                ),
                SizedBox(
                  height: screenHeight / 43.85,
                ),
                Text(
                  "Welcome $name",
                  style: TextStyle(
                    fontSize: screenHeight / 29.233,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight / 54.8125,
                    horizontal: screenWidth / 12.84375,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Enter user name",
                          labelText: "User name",
                          prefixIcon: Icon(
                            Icons.person,
                            size: screenHeight / 29.2333,
                          ),
                          labelStyle: TextStyle(
                            fontSize: screenHeight / 54.8125,
                          ),
                          hintStyle: TextStyle(
                            fontSize: screenHeight / 53,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "User name cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                          // build(context);
                        },
                      ),
                      SizedBox(
                        height: screenHeight / 87.7,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _passwordNotVisible,
                        decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.password,
                              size: screenHeight / 29.2333,
                            ),
                            labelStyle: TextStyle(
                              fontSize: screenHeight / 54.8125,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordNotVisible = !_passwordNotVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordNotVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: screenHeight / 40,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be atleast 6 characters long";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight / 21.925,
                      ),
                      InkWell(
                        onTap: () => moveToHome(context),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: screenHeight / 17.54,
                          width: _changeButton
                              ? screenWidth / 8.22
                              : screenWidth / 2.74,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(_changeButton
                                ? screenWidth / 10.5
                                : screenWidth / 30),
                          ),
                          child: _changeButton
                              ? Icon(
                                  Icons.done,
                                  size: screenWidth / 13.7,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight / 45),
                                ),
                        ),
                      ),
                      TextButton(
                          onPressed: onPressed,
                          child: Text(
                            "Don't have an account? Register here.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
