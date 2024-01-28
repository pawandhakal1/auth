import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_app/resources/pages/auth/signuppage.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("HomePage")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Get.to(() => const signuppage());
            },
            child: const Text("Logout")),
      ),
    );
  }
}
