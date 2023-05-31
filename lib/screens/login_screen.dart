import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/button.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordNotVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(
                //   height: screenHeight / 43.85,
                // ),
                // Image.asset(
                //   "assets/images/login_image.png",
                //   fit: BoxFit.cover,
                //   height: screenHeight / 4,
                // ),
                SizedBox(
                  height: screenHeight / 43.85,
                ),
                HeadingText(
                  "Create your account",
                  screenHeight / 29.233,
                  null,
                  Colors.white,
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.person_outline,
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
                              Icons.lock_outline,
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
                        onTap: () => signInWithEmailAndPassword(context),
                        child: MyButton(
                          "Login",
                          screenHeight / 17.54,
                          screenWidth / 2.74,
                          screenWidth / 30,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
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
