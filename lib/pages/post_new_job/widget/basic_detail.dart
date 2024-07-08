import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/pages/post_new_job/widget/basic_into/basic_info_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/gender/gender_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/job_type/job_type_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/location/location_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/salary/salary_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/vacancy/vacancy_section.dart';

class BasicDetail extends GetView<PostNewJobController> {
  const BasicDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BasicInfoSection(),
          BtDivider(
            thickness: 8,
          ),
          const JobTypeSection(),
          BtDivider(
            thickness: 8,
          ),
          const GenderSection(),
          BtDivider(
            thickness: 8,
          ),
          VacancySection(),
          BtDivider(
            thickness: 8,
          ),
          SalarySection(),
          BtDivider(
            thickness: 8,
          ),
          const LocationSection(),
          BtDivider(
            thickness: 8,
          ),
        ],
      ),
    );
  }
}
