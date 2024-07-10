import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/common/bt_text_form_field/bt_text_form_field_with_label.dart';
import 'package:hiringbell/pages/registration/short_registration_controller.dart';

class ShortRegistrationForm extends StatelessWidget {
  const ShortRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ShortRegistrationController());
    var password = "";

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Image.asset(
                "assets/bg1.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      BTTextFormFieldWithLabel(
                        controller: controller.usernameController,
                        label: 'Name',
                        isEmptyValidation: true,
                      ),
                      const SizedBox(height: 10),
                      BtSelectWithLabel(
                        label: "Gender",
                        items: controller.listGender,
                        onChanged: (g) {
                          controller.gender = g.value;
                        },
                      ),
                      const SizedBox(height: 10),
                      BTTextFormFieldWithLabel(
                        controller: controller.emailController,
                        label: 'Email',
                        isEmptyValidation: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      BTTextFormFieldWithLabel(
                        controller: controller.passwordController,
                        label: 'Password',
                        isEmptyValidation: true,
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (p) {
                          if (p!.length < 6) {
                            return 'Password must be at least 6 chars';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      BTTextFormFieldWithLabel(
                        label: 'Confirm Password',
                        isEmptyValidation: true,
                        obscureText: true,
                        validator: (p) {
                          if (p != password) {
                            return "Confirm Password should be same as password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: controller.onSubmit,
                          child: const Text('Register')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
