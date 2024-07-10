import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_text_form_field/bt_text_form_field.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';
import 'package:hiringbell/utilities/util.dart';

class UserDocumentsWidget extends GetView<ClientRegistrationController> {
  const UserDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => FormCard(
          title: "Documents",
          children: [
            ..._buildUserPickedDocs(context),
            ..._buildUserSavedDocs(context),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: const Text('Add Documnet'),
              icon: const Icon(Icons.add_a_photo, color: Colors.blue),
              onPressed: controller.pickDocument,
              // child: const Text('Add Documnet'),
            )
          ],
        ));
  }

  List<Widget> _buildUserSavedDocs(BuildContext context) {
    var userGroupWidgets = <Widget>[];
    var usrDocs = controller.userSavedDocs;
    for (var i = 0; i < usrDocs.length; i++) {
      userGroupWidgets.add(
        ListTile(
            title: BTTextFormField(
              initialValue: usrDocs[i].docName,
              hintText: "Doc Name",
              onChanged: (value) {
                // controller.documents[i].docName = value;
                usrDocs[i].docName = value;
              },
            ),
            subtitle: SizedBox(
              height: 100,
              child:
                  Util.getInstance().getCachedImageFromUrl(usrDocs[i].docPath),
            ),
            trailing: IconButton(
              onPressed: () {
                controller.removeSavedDocument(i);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            )
            // Other properties for ListTile
            ),
      );
    }
    return userGroupWidgets;
  }

  List<Widget> _buildUserPickedDocs(BuildContext context) {
    var userGroupWidgets = <Widget>[];
    var pickedDocs = controller.pickedDocumnets.value;
    for (var i = 0; i < pickedDocs.length; i++) {
      userGroupWidgets.add(
        ListTile(
            title: BTTextFormField(
              // initialValue: controller.user.userDocs?[i].docName,
              hintText: "Doc Name",
              onChanged: (value) {
                controller.documents[i].docName = value;
                // controller.user.userDocs?[i].docName = value;
              },
            ),
            subtitle: SizedBox(
              height: 100,
              child: Image.file(
                File(controller.pickedDocumnets.value[i].path),
                fit: BoxFit.cover,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                controller.removePickedDocument(i);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            )
            // Other properties for ListTile
            ),
      );
    }
    return userGroupWidgets;
  }

  // Widget? bgImage(int index) {
  //   var imageURL = controller.user.userDocs?[index].docPath;
  //   var pickedDocs = controller.pickedDocumnets.value;
  //   if (pickedDocs.length > index) {
  //     return Image.file(
  //       File(pickedDocs[index].path),
  //       fit: BoxFit.cover,
  //     );
  //   } else if (imageURL != null && imageURL.isNotEmpty) {
  //     return Util.getInstance().getCachedImageFromUrl(imageURL);
  //   } else {
  //     return null;
  //   }
  // }
}
