import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/app_widgets/button.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'dart:io';
import 'package:notes_application/utils/cropper.dart';
import 'package:notes_application/utils/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordNotVisible = true;

  File? pickedFile;
  String? urlDownload;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) {
      return;
    }

    pickedFile = await Cropper.cropSquareImage(File(result.files.first.path!));
  }

  Future uploadFile() async {
    if (pickedFile == null) {
      Fluttertoast.showToast(
        msg: 'Please select a profile picture',
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        number: _numberController.text.trim(),
        pickedFile: pickedFile,
        context: context,
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
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
              HeadingText("Welcome", screenHeight / 29.233, null, Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight / 54.8125,
                  horizontal: screenWidth / 12.84375,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter user name",
                        labelText: "User name",
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          size: screenHeight / 29.2333,
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenHeight / 54.8125,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenHeight / 87.7,
                    ),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        labelText: "Phone Number",
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          size: screenHeight / 29.2333,
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenHeight / 54.8125,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number cannot be empty";
                        } else if (value.length < 10) {
                          return "Password must be atleast 10 characters long";
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
                      onTap: () => selectFile(),
                      child: MyButton(
                        "Select file",
                        screenHeight / 17.54,
                        screenWidth / 2.74,
                        screenWidth / 30,
                      ),
                      // child: Container(
                      //   height: screenHeight / 17.54,
                      //   width: screenWidth / 2.74,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.circular(screenWidth / 30),
                      //   ),
                      //   child: Text(
                      //     "Select image",
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: screenHeight / 45),
                      //   ),
                      // ),
                    ),
                    SizedBox(
                      height: screenHeight / 40,
                    ),
                    InkWell(
                      onTap: () => uploadFile(),
                      child: MyButton(
                        "Sign Up",
                        screenHeight / 17.54,
                        screenWidth / 2.74,
                        screenWidth / 30,
                      ),
                      // child: Container(
                      //   height: screenHeight / 17.54,
                      //   width: screenWidth / 2.74,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.circular(screenWidth / 30),
                      //   ),
                      //   child: Text(
                      //     "Sign Up",
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: screenHeight / 45),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
