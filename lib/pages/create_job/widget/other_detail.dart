import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';

class OtherDetail extends GetView<JobPostController> {
  const OtherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Other information",
      children: [
        BtSelectWithLabel(
          isEmptyValidation: true,
          label: 'Medical insurance',
          hintText: 'Select medical insurance',
          items: controller.listMedicalInsurance,
          initSelectionCriteria: (c) => c.value == 1,
          onChanged: (value) {
            controller.jobPost.isMedicalInsuranceProvide = value.value == 1;
          },
        ),
        BtSelectWithLabel(
          isEmptyValidation: true,
          label: 'Visa Type',
          hintText: 'Select visa type',
          items: controller.listVisaType,
          initSelectionCriteria: (c) => c.value == controller.jobPost.visaType,
          onChanged: (value) {
            controller.jobPost.visaType = value.value;
          },
        ),
        Row(
          children: [
            Expanded(
              child: BtSelectWithLabel(
                isEmptyValidation: true,
                label: 'Min Age',
                hintText: 'Minimum age',
                items: controller.listMinAge,
                initSelectionCriteria: (c) =>
                    c == controller.jobPost.minAgeLimit,
                onChanged: (value) {
                  controller.jobPost.minAgeLimit = value;
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BtSelectWithLabel(
                isEmptyValidation: true,
                label: 'Max Age',
                hintText: 'Maximum age',
                items: controller.listMinAge,
                initSelectionCriteria: (c) =>
                    c == controller.jobPost.maxAgeLimit,
                onChanged: (value) {
                  controller.jobPost.maxAgeLimit = value;
                },
                validator: (maxAge) {
                  if (controller.jobPost.minAgeLimit > (maxAge ?? 0)) {
                    return "Max Age can't be less than min age";
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpansionPanelList(
              dividerColor: Colors.grey.shade300,
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return const ListTile(
                      title: Text(
                        "Overtime detail",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "if overtime allowed then use this section to define overtime",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      leading: Icon(Icons.timelapse),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 6,
                      bottom: 16,
                    ),
                    child: SizedBox(
                      width: 250,
                      child: BtSelectWithLabel(
                        label: 'Overtime',
                        hintText: 'Overtime hours',
                        items: controller.listOverTime,
                        initSelectionCriteria: (c) =>
                            c == controller.jobPost.maxOTHours,
                        onChanged: (value) {
                          controller.jobPost.maxOTHours = value;
                        },
                      ),
                    ),
                  ),
                  isExpanded: controller.overtimeFlag.value,
                ),
              ],
              expansionCallback: controller.updateOvertimeFlag,
              elevation: 4,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text("All field are mandatory in this section"),
        const SizedBox(height: 20),
      ],
    );
  }
}

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         const Padding(
//           padding: EdgeInsets.only(
//             left: 4,
//           ),
//           child: Text(
//             "Other information",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         Card(
//           color: Colors.white,
//           elevation: 6,
//           child: Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 const ListTile(
//                   leading: Icon(Icons.calendar_today),
//                   title: Text(
//                     'Other important detail',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   subtitle: Text('Age limit, insurance, # vacancy etc'),
//                   trailing: Icon(Icons.more_vert),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ListTile(
//                   title: const Text(
//                     'Medical insurance',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   trailing: SizedBox(
//                     width: 200,
//                     child: BtSelect(
//                       hintText: 'Select medical insurance',
//                       items: controller.listMedicalInsurance,
//                       initSelectionCriteria: (c) => c.value == 1,
//                       onChanged: (value) {
//                         controller.jobPost.isMedicalInsuranceProvide =
//                             value.value == 1;
//                       },
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text(
//                     'Visa Type',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   trailing: SizedBox(
//                     width: 200,
//                     child: BtSelect(
//                       hintText: 'Select visa type',
//                       items: controller.listVisaType,
//                       initSelectionCriteria: (c) =>
//                           c.value == controller.jobPost.visaType,
//                       onChanged: (value) {
//                         controller.jobPost.visaType = value.value;
//                       },
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8.0,
//                       ),
//                       child: Text("Age Limit"),
//                     ),
//                     ListTile(
//                       title: const Text(
//                         'Min Age',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: SizedBox(
//                         width: 200,
//                         child: BtSelect(
//                           hintText: 'Minimum age',
//                           items: controller.listMinAge,
//                           initSelectionCriteria: (c) =>
//                               c == controller.jobPost.minAgeLimit,
//                           onChanged: (value) {
//                             controller.jobPost.minAgeLimit = value;
//                           },
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       title: const Text(
//                         'Max Age',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: SizedBox(
//                         width: 200,
//                         child: BtSelect(
//                           hintText: 'Maximum age',
//                           items: controller.listMinAge,
//                           initSelectionCriteria: (c) =>
//                               c == controller.jobPost.maxAgeLimit,
//                           onChanged: (value) {
//                             controller.jobPost.maxAgeLimit = value;
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Obx(
//                   () => Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                     ),
//                     child: ExpansionPanelList(
//                       dividerColor: Colors.grey.shade300,
//                       children: [
//                         ExpansionPanel(
//                           headerBuilder: (context, isOpen) {
//                             return const ListTile(
//                               title: Text(
//                                 "Overtime detail",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 "if overtime allowed then use this section to define overtime",
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               leading: Icon(Icons.timelapse),
//                             );
//                           },
//                           body: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 15,
//                               right: 15,
//                               top: 6,
//                               bottom: 16,
//                             ),
//                             child: SizedBox(
//                               width: 250,
//                               child: BtSelect(
//                                 hintText: 'Overtime hours',
//                                 items: controller.listOverTime,
//                                 initSelectionCriteria: (c) =>
//                                     c == controller.jobPost.maxOTHours,
//                                 onChanged: (value) {
//                                   controller.jobPost.maxOTHours = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                           isExpanded: controller.overtimeFlag.value,
//                         ),
//                       ],
//                       expansionCallback: controller.updateOvertimeFlag,
//                       elevation: 4,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text("All field are mandatory in this section"),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//       ],
//     );
//   }
// }
