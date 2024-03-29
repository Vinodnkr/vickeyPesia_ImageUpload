// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

class InlineEditableText extends StatefulWidget {
  const InlineEditableText({
    Key? key,
    required this.text,
    required this.style,
    required this.onTextChanged, // Add this callback
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final ValueChanged<String> onTextChanged; // Callback for text changes

  @override
  State<InlineEditableText> createState() => _InlineEditableTextState();
}

class _InlineEditableTextState extends State<InlineEditableText> {
  var _isEditing = false;
    late TextEditingController _controller; // Ch

 @override
  void initState() {
    _controller = TextEditingController(text: widget.text); // And this line
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isEditing = !_isEditing;
          if (_isEditing) {
            _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length)); // Add this line
          }
        });
      },
      child: _isEditing
          ? TextField(
              maxLines: null,
              style: widget.style,
              textAlign: TextAlign.left,
              controller: _controller, // And this line
              onChanged: (newValue) {
                setState(() {
                  _controller.text = newValue; // And this line
                });
                widget.onTextChanged(newValue);
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 4.4,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            )
          : Text(
              _controller.text, // And this line
              style: widget.style,
            ),
    );
  }
}