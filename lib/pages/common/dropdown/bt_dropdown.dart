import 'package:flutter/material.dart';
import 'package:hiringbell/models/dropdown_items.dart';

class BtDropdown extends StatefulWidget {
  final bool materialStyle;
  final Function(DropdownItems<int>)? onChanged;
  final List<DropdownItems<int>> items;
  final String label;

  const BtDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    required this.label,
  })  : assert(true),
        materialStyle = false;

  const BtDropdown.styled({
    super.key,
    required this.onChanged,
    required this.items,
    required this.label,
  })  : assert(true),
        materialStyle = true;

  @override
  State<BtDropdown> createState() => _BtDropdownState();
}

class _BtDropdownState extends State<BtDropdown> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  DropdownItems<int>? selectedItem;

  Widget getStyledDropdown() {
    return DropdownMenu<DropdownItems<int>>(
      controller: iconController,
      enableFilter: true,
      requestFocusOnTap: true,
      leadingIcon: const Icon(Icons.search),
      label: Text(widget.label),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      onSelected: (DropdownItems<int>? x) {
        widget.onChanged!(x!);
        setState(() {
          selectedItem = x;
        });
      },
      dropdownMenuEntries:
          widget.items.map<DropdownMenuEntry<DropdownItems<int>>>(
        (DropdownItems<int> x) {
          return DropdownMenuEntry<DropdownItems<int>>(
            value: x,
            label: x.text,
            leadingIcon: x.icon,
          );
        },
      ).toList(),
    );
  }

  Widget getFullDropdown() {
    return DropdownMenu<DropdownItems<int>>(
      initialSelection: widget.items.first,
      controller: colorController,
      requestFocusOnTap: true,
      label: const Text('Color'),
      onSelected: (DropdownItems<int>? x) {
        widget.onChanged!(x!);
        setState(() {
          selectedItem = x;
        });
      },
      dropdownMenuEntries:
          widget.items.map<DropdownMenuEntry<DropdownItems<int>>>(
        (DropdownItems<int> x) {
          return DropdownMenuEntry<DropdownItems<int>>(
            value: x,
            label: x.text,
            leadingIcon: x.icon,
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
                widget.materialStyle ? getStyledDropdown() : getFullDropdown(),
          ),
        ],
      ),
    );
  }
}
