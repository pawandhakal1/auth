// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_app/app/controller/authcontroller.dart';
import 'package:mvc_app/resources/pages/homepage.dart';
import 'package:sign_in_button/sign_in_button.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppage();
}

class _signuppage extends State<signuppage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // create your account container
                  Container(
                    child: const Center(
                      child: Text(
                        "Create your new account",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ),
                  ),
                  // textfield for fullname
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter FullName';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter FullName",
                          labelText: "FullName",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        RegExp emailRegExp = RegExp("@");
                        if (!emailRegExp.hasMatch(value)) {
                          return ("Please Enter Valid Email");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone Number';
                        }
                        // RegExp phoneRegExp = RegExp(
                        //     "^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}");
                        // if (!phoneRegExp.hasMatch(value)) {
                        //   return ("Enter Valid Phone Number");
                        // }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Enter Phone",
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: _passController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }

                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: _confirmPassController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm Password';
                        }
                        if (value != _passController.text) {
                          return ("Password not match");
                        }
                        return null;
                      },
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                isVisible = !isVisible;
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _authenticationController.register(
                            _nameController.text,
                            _emailController.text,
                            _phoneController.text,
                            _passController.text,
                            _confirmPassController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Ink(
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 5,
                      ),
                      child: InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {
                          //   _authenticationController.register(
                          //     _nameController.text,
                          //     _emailController.text,
                          //     _phoneController.text,
                          //     _passController.text,
                          //     _confirmPassController.text,
                          //   );
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 5),
                          child: Ink(
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child:
                                  SignInButton(Buttons.google, onPressed: () {
                                _authenticationController.signInWithGoogle();
                              })),
                              
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 2,
                          width: 145,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: const Text("OR"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 2,
                          width: 140,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            "Already have an account?",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ),
                        const SizedBox(),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => Homepage());
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
