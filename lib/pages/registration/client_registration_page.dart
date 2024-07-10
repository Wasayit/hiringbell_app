import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';
import 'package:hiringbell/pages/registration/widget/user_additional_info.dart';
import 'package:hiringbell/pages/registration/widget/user_documents.dart';
import 'package:hiringbell/pages/registration/widget/user_job_preferences.dart';
import 'package:hiringbell/pages/registration/widget/user_location_details.dart';
import 'package:hiringbell/pages/registration/widget/user_personal_info.dart';
import 'package:hiringbell/pages/registration/widget/user_profile_image_upload.dart';

class ClientRegistrationForm extends StatelessWidget {
  final int? userId;
  final bool isJobSeeker;
  final String label;
  final ClientRegistrationController controller;

  ClientRegistrationForm(
      {super.key, this.userId, this.isJobSeeker = false, required this.label})
      : controller = ClientRegistrationController(
            regId_: userId, isJobSeeker_: isJobSeeker);

  @override
  Widget build(BuildContext context) {
    // return jobFormWidget(controller: controller);
    return FutureBuilder<void>(
        future: controller.onInitRefresh(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Get.put(controller);
            return ClientRegWidget(controller: controller, label: label);
          }
        });
  }
}

class ClientRegWidget extends StatelessWidget {
  final ClientRegistrationController controller;
  final String label;
  const ClientRegWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text(label),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          width: double.infinity,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const UserDocuments(),
                const UserProfileImageUpload(),
                const UserPersonalInfo(),
                const UserLocationDetails(),
                if (controller.isJobSeeker_) const UserJobPreferences(),
                const UserAdditionalInfo(),
                if (!controller.isJobSeeker_) const UserDocumentsWidget(),
                const SizedBox(height: 20),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: SizedBox(
                      width: 150,
                      child: controller.isSubmitted.value
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Wait ..."),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add_alt_1_sharp),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Register"),
                              ],
                            ),
                    ),
                    onPressed: () => {
                      controller.isSubmitted(true),
                      controller.saveFormData(),
                      controller.isSubmitted(false),
                    },
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
