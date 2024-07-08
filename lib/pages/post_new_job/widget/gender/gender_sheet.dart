import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';

class GenderSheet extends StatefulWidget {
  final int genderId;

  const GenderSheet({
    super.key,
    required this.genderId,
  });

  @override
  State<GenderSheet> createState() => _GenderSheetState();
}

enum Gender { male, female, both, any }

class GenderType {
  String title;
  String desc;
  Gender type;
  bool active;

  GenderType({
    required this.title,
    required this.desc,
    required this.type,
    required this.active,
  });
}

class _GenderSheetState extends State<GenderSheet> {
  List<GenderType> items = [];
  var controller = Get.find<PostNewJobController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = [
      GenderType(
        title: "Male",
        desc: "Select this, if only for the male candidate",
        type: Gender.male,
        active: widget.genderId == 1 ? true : false,
      ),
      GenderType(
        title: "Female",
        desc: "Select this, if only for the female candidate",
        type: Gender.female,
        active: widget.genderId == 2 ? true : false,
      ),
      GenderType(
        title: "Any",
        desc: "Opening for any gender",
        type: Gender.any,
        active: widget.genderId == 3 ? true : false,
      ),
    ];

    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose gender for applicant",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Constants.fontSize * 1.2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
          items.length,
          (i) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: const TextStyle(
                        fontSize: Constants.fontSize * 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                      items[i].title,
                    ),
                    const Text(
                      "Select this, if only for the male candidate",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Constants.fontSize * .9,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<Gender>(
                value: items[i].type,
                groupValue: items[i].active ? items[i].type : null,
                onChanged: (Gender? value) {
                  controller.genderSelected(value!.index + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
