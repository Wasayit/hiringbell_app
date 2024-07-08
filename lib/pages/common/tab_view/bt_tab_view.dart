import 'package:flutter/material.dart';

class BtTabView extends StatefulWidget {
  final List<String> tabs;

  const BtTabView({super.key, required this.tabs});

  @override
  State<BtTabView> createState() => _BtTabViewState();
}

class _BtTabViewState extends State<BtTabView> {
  int selectedIndex = 0; // Track the selected tab index
  final List<Widget> tabViews = [
    const Center(child: Text('Content of Tab 1')),
    const Center(child: Text('Content of Tab 2')),
    const Center(child: Text('Content of Tab 3')),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Custom TabBar
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.tabs.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    debugPrint('Tab ${index + 1} selected');
                    selectedIndex = index;
                    (context as Element).markNeedsBuild();
                    setState(() {
                      selectedIndex = selectedIndex;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: selectedIndex == index
                          ? const Border(
                              bottom: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            )
                          : null,
                    ),
                    child: Text(
                      widget.tabs[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // TabBarView
        Flexible(
          child: IndexedStack(
            index: selectedIndex, // Initial tab index
            children: tabViews,
          ),
        ),
      ],
    );
  }
}
