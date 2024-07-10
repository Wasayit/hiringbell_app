import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_box/bt_box.dart';
import 'package:hiringbell/pages/common/bt_circular_container/bt_circular_container.dart';
import 'package:hiringbell/pages/common/button/bt_button.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';

import '../../common/bt_divider/bt_divider.dart';

class PageWallContainer extends GetView<ProfileController> {
  const PageWallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 240,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/profile-dg-1.jpg'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: BtCircularContainer(
                radius: 140,
                child: const Text("IMG"),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 70,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                radius: 15,
                child: const Icon(
                  Icons.edit,
                  size: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              const Text(
                "Colleen McKenna",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              const Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text("Principal, Intero Advisor"),
                  Text(
                    "Reinvesting How Companies Increase Sales + Recruiting",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Intero Advisor"),
                  BtBox(
                    hSpace: 10,
                    child: const Icon(
                      Icons.circle_rounded,
                      size: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "My job is to shake up your digital status uo, help you connect "
                        "the dots, and leverage LinkedIn to further your reach, Increase your influence and engineering "
                        "work also get increased.",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            children: [
              BtButton(
                title: "Applied Jobs",
                onClick: () {},
                addHGap: 5,
                roundedValue: 50,
              ),
              BtButton(
                title: "Saved Jobs",
                onClick: () {},
                addHGap: 5,
                roundedValue: 50,
                bgColor: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BtDivider(
          space: 0,
          thickness: 6,
        ),
      ],
    );
  }
}
