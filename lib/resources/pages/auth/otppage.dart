import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_app/app/controller/authcontroller.dart';
import 'package:mvc_app/resources/pages/auth/signuppage.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "OTP CODE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 42,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                      Container(
                          child: Column(
                        children: [
                          Pinput(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Pin';
                              }
                              return null;
                            },
                            controller: _pinController,
                            length: 6,
                            keyboardType: TextInputType.number,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                          )
                        ],
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: InkWell(
                          splashColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _authenticationController.otppin(
                                _pinController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 100,
                width: 100,
                child: TextButton(
                    onPressed: () {
                      Get.to(() => signuppage());
                    },
                    child: Text(
                      'Back to Signup',
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
