import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const FormCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 4,
            ),
            child: Text(
              title,
              style: const TextStyle(
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16.0, left: 8, right: 8),
                child: Wrap(
                  runSpacing: 12,
                  children: children,
                ),
              ),
            ),
          ),
        ]);
  }
}
