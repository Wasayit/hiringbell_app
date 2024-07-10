import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/login/login_controller.dart';
import 'package:hiringbell/pages/login/widgets/login_actions.dart';
import 'package:hiringbell/pages/registration/short_registration_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: double.infinity,
      child: Form(
        key: login.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: login.usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.blueAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Enter email or mobile no#",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    var msg = login.validateUserName(value);
                    if (msg != null) {
                      Fluttertoast.showToast(msg: msg);
                    }

                    return msg;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    prefixIcon: Icon(
                      Icons.key_outlined,
                      color: Colors.blueAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Enter password",
                  ),
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: login.passwordController,
                  validator: (value) {
                    var msg = login.validatePassword(value);
                    if (msg != null) {
                      Fluttertoast.showToast(msg: msg);
                    }

                    return msg;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 18,
                  bottom: 18,
                ),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                width: 150,
                child: LoginActions(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  login.signInWithGoogle();
                },
                label: const Text('Login with Google'),
                icon: const Icon(Icons.g_mobiledata),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(const ShortRegistrationForm());
                },
                label: const Text('Sign Up'),
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
