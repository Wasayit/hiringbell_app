import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/currency.dart';
import 'package:hiringbell/models/key_value_items.dart';
import 'package:hiringbell/pages/common/imulti_select/imulti_select_dropdown.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';

import '../../common/bt_single_select/bt_single_select.dart';
import '../../common/bt_text_form_field/bt_text_form_field.dart';

class SalaryDetail extends GetView<JobPostController> {
  const SalaryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 4,
          ),
          child: Text(
            "Salary & Allowance",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text(
                    'Salary & Allowance',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text('Define salary/month & allowance'),
                  trailing: Icon(Icons.more_vert),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Min salary"),
                            BTTextFormField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee,
                              hintText: "0.0",
                              initialValue:
                                  controller.jobPost.minimumCTC.toString(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Minimum salary is required";
                                }
                                controller.jobPost.minimumCTC =
                                    double.parse(value);
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Max salary"),
                            BTTextFormField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee,
                              hintText: "0.0",
                              initialValue:
                                  controller.jobPost.maximumCTC.toString(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Maximum salary is required";
                                }
                                controller.jobPost.maximumCTC =
                                    double.parse(value);
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Bonus"),
                            BTTextFormField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee,
                              hintText: "0.0",
                              initialValue: controller.jobPost.bonus.toString(),
                              onChanged: (value) {
                                controller.jobPost.bonus = double.parse(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Special Allowance"),
                            BTTextFormField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee,
                              hintText: "0.0",
                              // initialValue: controller.jobPost.s.toString(),
                              onChanged: (value) {
                                // controller.jobPost. = double.parse(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: ExpansionPanelList(
                      dividerColor: Colors.grey.shade300,
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isOpen) {
                            return const ListTile(
                              title: Text(
                                "HRA",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Use this section for HRA allowance",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              leading: Icon(Icons.house),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 6,
                              bottom: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Enter for HRA allowance amount",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                BTTextFormField(
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.currency_rupee,
                                  hintText: "0.0",
                                  initialValue: controller
                                      .jobPost.hRAAllowanceAmount
                                      .toString(),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      controller.jobPost.hRAAllowanceAmount =
                                          double.parse(value);
                                      controller.jobPost.isHRAAllowance = true;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          isExpanded: controller.openFlags[0],
                        ),
                        ExpansionPanel(
                          headerBuilder: (context, isOpen) {
                            return const ListTile(
                              title: Text(
                                "Travel allowance",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Use this section for Travel allowance",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              leading: Icon(Icons.car_rental),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 6,
                              bottom: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Enter for Travel allowance amount",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                BTTextFormField(
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.currency_rupee,
                                  hintText: "0.0",
                                  initialValue: controller
                                      .jobPost.travelAllowanceAmount
                                      .toString(),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      controller.jobPost.travelAllowanceAmount =
                                          double.parse(value);
                                      controller.jobPost.isTravelAllowance =
                                          true;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          isExpanded: controller.openFlags[1],
                        ),
                        ExpansionPanel(
                          headerBuilder: (context, isOpen) {
                            return const ListTile(
                              title: Text(
                                "Food allowance",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Use this section for Food allowance",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              leading: Icon(Icons.dinner_dining),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 6,
                              bottom: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Enter food allowance amount",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                BTTextFormField(
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.currency_rupee,
                                  hintText: "0.0",
                                  initialValue: controller
                                      .jobPost.foodAllowanceAmount
                                      .toString(),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      controller.jobPost.foodAllowanceAmount =
                                          double.parse(value);
                                      controller.jobPost.isFoodAllowance = true;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          isExpanded: controller.openFlags[2],
                        ),
                      ],
                      expansionCallback: controller.updateAllowanceExpansion,
                      elevation: 4,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    'Currency',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: SizedBox(
                    width: 200,
                    // child: IMultiSelectDropdown<Currency>(
                    //   initialItem: controller.listCurrency.firstWhereOrNull(
                    //       (c) => c.id == controller.jobPost.salaryCurrency),
                    //   hintText: 'Select currency',
                    //   items: controller.listCurrency,
                    //   decoration: IMultiSelectDropdownDecoration(
                    //     closedFillColor: Colors.grey.shade100,
                    //   ),
                    //   onChanged: (value) {
                    //     controller.jobPost.salaryCurrency = value.id;
                    //   },
                    // ),
                    child: BTSingleSelect(
                      hintText: 'Select currency',
                      items: controller.listCurrency,
                      initSelectionCriteria: (c) =>
                          c.id == controller.jobPost.salaryCurrency,
                      onChanged: (value) {
                        controller.jobPost.salaryCurrency = value.id;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("All field are mandatory in this section"),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
