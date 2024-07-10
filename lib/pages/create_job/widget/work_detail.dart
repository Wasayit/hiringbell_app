import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';
import 'package:hiringbell/pages/create_job/widget/days_card.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';

class WorkDetail extends GetView<JobPostController> {
  const WorkDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Work experience & Shift detail",
      // subtitle: "Fill experience shift and weekends",
      // icon: Icons.calendar_today,
      children: [
        BtSelectWithLabel(
          label: 'Working hours',
          hintText: 'Hours',
          items: controller.listDailyWorkingHours,
          initSelectionCriteria: (c) =>
              c == controller.jobPost.dailyWorkingHours,
          onChanged: (value) {
            controller.jobPost.dailyWorkingHours = value;
          },
        ),
        Obx(
          () => ExpansionPanelList(
            dividerColor: Colors.grey.shade300,
            expansionCallback: controller.updateExperienceFlag,
            elevation: 4,
            children: [
              _buildExperienceExpansionPanel(
                title: "Candidate experience detail",
                subtitle:
                    "Use this section to add experience i.e. overseas and local",
                icon: Icons.add_alarm_sharp,
                isExpanded: controller.experienceFlag.value,
                children: [
                  _buildExperienceDetail(
                    controller: controller,
                    label: "Enter overseas experience detail",
                    years: controller.overseasExperienceYears,
                    months: controller.overseasExperienceMonths,
                    onYearsChanged: (years) {
                      controller.jobPost.overseasExperience =
                          years * 12 + controller.overseasExperienceMonths;
                      debugPrint(
                          'overseas exp: ${controller.jobPost.overseasExperience}');
                    },
                    onMonthsChanged: (months) {
                      controller.jobPost.overseasExperience =
                          months + controller.overseasExperienceYears * 12;
                      debugPrint(
                          'overseas exp: ${controller.jobPost.overseasExperience}');
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildExperienceDetail(
                    controller: controller,
                    label: "Enter local experience detail",
                    years: controller.localExperienceYears,
                    months: controller.localExperienceMonths,
                    onYearsChanged: (years) {
                      controller.jobPost.localExperience =
                          years * 12 + controller.localExperienceMonths;
                      debugPrint(
                          'local exp: ${controller.jobPost.localExperience}');
                    },
                    onMonthsChanged: (months) {
                      controller.jobPost.localExperience =
                          months + controller.localExperienceYears * 12;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.days.length,
          itemBuilder: (context, index) {
            return DaysCard(
              label: controller.days[index].text,
              index: index + 1,
              initialValue: controller.getWeekdaysStatus(index + 1),
              onChanged: (status) {
                debugPrint('days updateWeekdaysStatusUI called');
                controller.updateWeekdaysStatusUI(index + 1, status);
              },
            );
          },
        ),
        const Text("All fields are mandatory in this section"),
      ],
    );
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     const Padding(
    //       padding: EdgeInsets.only(
    //         left: 4,
    //       ),
    //       child: Text(
    //         "Work experience information",
    //         style: TextStyle(
    //           fontSize: 18,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //     ),
    //     Card(
    //       color: Colors.white,
    //       elevation: 6,
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 10,
    //         ),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: Column(
    //           children: [
    //             const ListTile(
    //               leading: Icon(Icons.calendar_today),
    //               title: Text(
    //                 'Work experience & Shift detail',
    //                 style: TextStyle(fontWeight: FontWeight.w500),
    //               ),
    //               subtitle: Text('Fill experience shift and weekends'),
    //               trailing: Icon(Icons.more_vert),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             ListTile(
    //               title: const Text(
    //                 'Working hours',
    //                 style: TextStyle(fontWeight: FontWeight.w500),
    //               ),
    //               trailing: SizedBox(
    //                 width: 200,
    //                 // child: IMultiSelectDropdown<int>(
    //                 //   initialItem: controller.jobPost.dailyWorkingHours,
    //                 //   hintText: 'Hours',
    //                 //   items: controller.listDailyWorkingHours,
    //                 //   decoration: IMultiSelectDropdownDecoration(
    //                 //     closedFillColor: Colors.grey.shade100,
    //                 //   ),
    //                 //   onChanged: (value) {
    //                 //     controller.jobPost.dailyWorkingHours = value;
    //                 //   },
    //                 // ),
    //                 child: BTSelect(
    //                   hintText: 'Hours',
    //                   items: controller.listDailyWorkingHours,
    //                   initSelectionCriteria: (c) =>
    //                       c == controller.jobPost.dailyWorkingHours,
    //                   onChanged: (value) {
    //                     controller.jobPost.dailyWorkingHours = value;
    //                   },
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Obx(
    //               () => Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: 8,
    //                 ),
    //                 child: ExpansionPanelList(
    //                   dividerColor: Colors.grey.shade300,
    //                   children: [
    //                     ExpansionPanel(
    //                       headerBuilder: (context, isOpen) {
    //                         return const ListTile(
    //                           title: Text(
    //                             "Candidate experience detail",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                           ),
    //                           subtitle: Text(
    //                             "Use this section to add experience i.e. overseas and local",
    //                             style: TextStyle(
    //                               color: Colors.grey,
    //                             ),
    //                           ),
    //                           leading: Icon(Icons.add_alarm_sharp),
    //                         );
    //                       },
    //                       body: Padding(
    //                         padding: const EdgeInsets.only(
    //                           left: 15,
    //                           right: 15,
    //                           top: 6,
    //                           bottom: 16,
    //                         ),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             const Text(
    //                               "Enter overseas experience detail",
    //                               style: TextStyle(
    //                                 color: Colors.grey,
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               height: 4,
    //                             ),
    //                             Row(
    //                               mainAxisSize: MainAxisSize.min,
    //                               children: [
    //                                 Expanded(
    //                                   // child: IMultiSelectDropdown<int>(
    //                                   //   initialItem:
    //                                   //       controller.overseasExperienceYears,
    //                                   //   hintText: 'Years',
    //                                   //   items: controller.listExperience,
    //                                   //   decoration:
    //                                   //       IMultiSelectDropdownDecoration(
    //                                   //     closedFillColor: Colors.grey.shade100,
    //                                   //   ),
    //                                   //   onChanged: (years) {
    //                                   //     controller
    //                                   //             .jobPost.overseasExperience =
    //                                   //         years * 12 +
    //                                   //             controller
    //                                   //                 .overseasExperienceMonths;
    //                                   //     debugPrint(
    //                                   //         'oversease exp: ${controller.jobPost.overseasExperience}');
    //                                   //   },
    //                                   // ),
    //                                   child: BTSelect(
    //                                     hintText: 'Years',
    //                                     items: controller.listExperience,
    //                                     initSelectionCriteria: (c) =>
    //                                         c ==
    //                                         controller.overseasExperienceYears,
    //                                     onChanged: (years) {
    //                                       controller
    //                                               .jobPost.overseasExperience =
    //                                           years * 12 +
    //                                               controller
    //                                                   .overseasExperienceMonths;
    //                                       debugPrint(
    //                                           'overseas exp: ${controller.jobPost.overseasExperience}');
    //                                     },
    //                                   ),
    //                                 ),
    //                                 const SizedBox(
    //                                   width: 10,
    //                                 ),
    //                                 Expanded(
    //                                   // child: IMultiSelectDropdown<int>(
    //                                   //   initialItem:
    //                                   //       controller.overseasExperienceMonths,
    //                                   //   hintText: 'Months',
    //                                   //   items: controller.listMonths,
    //                                   //   decoration:
    //                                   //       IMultiSelectDropdownDecoration(
    //                                   //     closedFillColor: Colors.grey.shade100,
    //                                   //   ),
    //                                   //   onChanged: (months) {
    //                                   //     controller
    //                                   //             .jobPost.overseasExperience =
    //                                   //         months +
    //                                   //             controller
    //                                   //                     .overseasExperienceYears *
    //                                   //                 12;
    //                                   //     debugPrint(
    //                                   //         'oversease exp: ${controller.jobPost.overseasExperience}');
    //                                   //   },
    //                                   // ),
    //                                   child: BTSelect(
    //                                     hintText: 'Months',
    //                                     items: controller.listMonths,
    //                                     initSelectionCriteria: (c) =>
    //                                         c ==
    //                                         controller.overseasExperienceMonths,
    //                                     onChanged: (months) {
    //                                       controller
    //                                               .jobPost.overseasExperience =
    //                                           months +
    //                                               controller
    //                                                       .overseasExperienceYears *
    //                                                   12;
    //                                       debugPrint(
    //                                           'overseas exp: ${controller.jobPost.overseasExperience}');
    //                                     },
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             const SizedBox(
    //                               height: 20,
    //                             ),
    //                             const Text(
    //                               "Enter local experience detail",
    //                               style: TextStyle(
    //                                 color: Colors.grey,
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               height: 4,
    //                             ),
    //                             Row(
    //                               mainAxisSize: MainAxisSize.min,
    //                               children: [
    //                                 Expanded(
    //                                   // child: IMultiSelectDropdown<int>(
    //                                   //   initialItem:
    //                                   //       controller.localExperienceYears,
    //                                   //   hintText: 'Years',
    //                                   //   items: controller.listExperience,
    //                                   //   decoration:
    //                                   //       IMultiSelectDropdownDecoration(
    //                                   //     closedFillColor: Colors.grey.shade100,
    //                                   //   ),
    //                                   //   onChanged: (years) {
    //                                   //     controller.jobPost.localExperience =
    //                                   //         years * 12 +
    //                                   //             controller
    //                                   //                 .localExperienceMonths;
    //                                   //     debugPrint(
    //                                   //         'local exp: ${controller.jobPost.localExperience}');
    //                                   //   },
    //                                   // ),
    //                                   child: BTSelect(
    //                                     hintText: 'Years',
    //                                     items: controller.listExperience,
    //                                     initSelectionCriteria: (c) =>
    //                                         c ==
    //                                         controller.localExperienceYears,
    //                                     onChanged: (years) {
    //                                       controller.jobPost.localExperience =
    //                                           years * 12 +
    //                                               controller
    //                                                   .localExperienceMonths;
    //                                       debugPrint(
    //                                           'local exp: ${controller.jobPost.localExperience}');
    //                                     },
    //                                   ),
    //                                 ),
    //                                 const SizedBox(
    //                                   width: 10,
    //                                 ),
    //                                 Expanded(
    //                                   // child: IMultiSelectDropdown<int>(
    //                                   //   initialItem:
    //                                   //       controller.localExperienceMonths,
    //                                   //   hintText: 'Months',
    //                                   //   items: controller.listMonths,
    //                                   //   decoration:
    //                                   //       IMultiSelectDropdownDecoration(
    //                                   //     closedFillColor: Colors.grey.shade100,
    //                                   //   ),
    //                                   //   onChanged: (months) {
    //                                   //     controller.jobPost.localExperience =
    //                                   //         months +
    //                                   //             controller
    //                                   //                     .localExperienceYears *
    //                                   //                 12;
    //                                   //   },
    //                                   // ),
    //                                   child: BTSelect(
    //                                     hintText: 'Months',
    //                                     items: controller.listMonths,
    //                                     initSelectionCriteria: (c) =>
    //                                         c ==
    //                                         controller.localExperienceMonths,
    //                                     onChanged: (months) {
    //                                       controller.jobPost.localExperience =
    //                                           months +
    //                                               controller
    //                                                       .localExperienceYears *
    //                                                   12;
    //                                     },
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       isExpanded: controller.experienceFlag.value,
    //                     ),
    //                   ],
    //                   expansionCallback: controller.updateExperienceFlag,
    //                   elevation: 4,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             ListView.builder(
    //               shrinkWrap: true,
    //               scrollDirection: Axis.vertical,
    //               itemCount: controller.days.length,
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemBuilder: (context, index) {
    //                 return DaysCard(
    //                   label: controller.days[index].text,
    //                   index: index + 1,
    //                   initialValue: controller.getWeekdaysStatus(index + 1),
    //                   onChanged: (status) {
    //                     debugPrint('days updateWeekdaysStatusUI  called');
    //                     controller.updateWeekdaysStatusUI(index + 1, status);
    //                   },
    //                 );
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             const Text("All field are mandatory in this section"),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );
  }
}

ExpansionPanel _buildExperienceExpansionPanel({
  required String title,
  required String subtitle,
  required IconData icon,
  required bool isExpanded,
  required List<Widget> children,
}) {
  return ExpansionPanel(
    headerBuilder: (context, isOpen) {
      return ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        leading: Icon(icon),
      );
    },
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
    isExpanded: isExpanded,
  );
}

Widget _buildExperienceDetail({
  required String label,
  required int years,
  required int months,
  required Function(int) onYearsChanged,
  required Function(int) onMonthsChanged,
  required JobPostController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Colors.grey),
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          Expanded(
            child: BtSelectWithLabel(
              label: 'Years',
              hintText: 'Years',
              items: controller.listExperience,
              initSelectionCriteria: (c) => c == years,
              onChanged: onYearsChanged,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BtSelectWithLabel(
              label: 'Months',
              hintText: 'Months',
              items: controller.listMonths,
              initSelectionCriteria: (c) => c == months,
              onChanged: onMonthsChanged,
            ),
          ),
        ],
      ),
    ],
  );
}
