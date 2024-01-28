import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_app/app/controller/authcontroller.dart';
import 'package:mvc_app/resources/pages/auth/signuppage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
              fontSize: 30,
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
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username or email required";
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "username or email",
                          labelText: "Enter Username Or Email ",
                          suffixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password Requied";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      controller: _passController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Enter Password ",
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
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 230),
                        child: Text(
                          "Forgot Password ? ",
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await _authenticationController.login(
                        _emailController.text,
                        _passController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Ink(
                    height: 55,
                    width: 345,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )),
                const Text("OR"),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  child: InkWell(
                    splashColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.to(() => const signuppage());
                    },
                    child: Ink(
                      height: 55,
                      width: 345,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // Get.to(() => const signuppage());
                        },
                        child: Ink(
                            height: 55,
                            width: 345,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Login With Phone Number",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.phone,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
