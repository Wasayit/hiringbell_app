import 'package:flutter/material.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_input_decoration/bt_input_decoration.dart';
import 'package:hiringbell/pages/common/bt_select/form_util.dart';
import 'package:hiringbell/utilities/util.dart';
import 'package:jiffy/jiffy.dart';

class BtDatePicker extends StatefulWidget {
  final String? hintText;
  // final String labelText;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime?)? onChanged;
  final String? Function(DateTime?)? validator;
  final bool isEmptyValidation;
  final String? emptyMessage;

  const BtDatePicker({
    super.key,
    this.hintText,
    // required this.labelText,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    required this.onChanged,
    this.validator,
    this.isEmptyValidation = true,
    this.emptyMessage,
  });

  @override
  _BtDatePickerState createState() => _BtDatePickerState();
}

class _BtDatePickerState extends State<BtDatePicker> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
    _controller = TextEditingController(
      text: _selectedDate == null ? '' : _formatDate(_selectedDate!),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return Constants.empty;
    return Jiffy.parseFromDateTime(date).format(pattern: 'E, d MMMM  yyyy');
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      // initialDate: _selectedDate ?? widget.initialValue,
      initialDate: _selectedDate,
      firstDate: widget.firstDate ?? DateTime(1990),
      lastDate: widget.lastDate ?? DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black54,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = _formatDate(_selectedDate!);
      });
      widget.onChanged!(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          decoration: btInputDecoration(
            hintText: widget.hintText,
            // prefixIcon: prefixIcon,
          ),
          textInputAction: TextInputAction.next,
          // initialValue:
          //     FormUtil.isEdit ? _formatDate(widget.initialValue) : null,
          onChanged: (value) {
            if (widget.onChanged == null) return;
            widget.onChanged!(Util.convertToDateTime(value));
          },
          validator: (value) {
            if (widget.isEmptyValidation && (value == null || value.isEmpty)) {
              return widget.emptyMessage ?? "Please enter ${widget.hintText}";
            }
            if (widget.validator == null) return null;
            if (value == null) return widget.validator!(null);
            return widget.validator!(Util.convertToDateTime(value));
          },
        ),
      ),
    );
  }
}
