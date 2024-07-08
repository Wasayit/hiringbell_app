import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/utilities/Util.dart';

class BtTextarea extends StatefulWidget {
  final TextEditingController textController;
  final int limit;

  const BtTextarea({
    super.key,
    required this.textController,
    this.limit = 500,
  });

  @override
  State<BtTextarea> createState() => _BtTextareaState();
}

class _BtTextareaState extends State<BtTextarea> {
  int _characterCount = 0;
  Util util = Util.getInstance();

  void _updateCharCount() {
    setState(() {
      _characterCount = widget.limit - widget.textController.text.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _characterCount = 500;
      widget.textController.addListener(_updateCharCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: null,
          controller: widget.textController,
          keyboardType: TextInputType.multiline,
          // Allows multi-line input
          decoration: Util.getTextFieldDecoration(
              placeholder: 'Write your text here...'
          ),
          validator: (value) {
            if (value!.isEmpty) {
              util.showToast("Please enter text", type: Constants.fail);
              return "Please enter text";
            }
            return null;
          },
          inputFormatters: [LengthLimitingTextInputFormatter(100)],
          onChanged: (value) {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Maximum $_characterCount charters",
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
