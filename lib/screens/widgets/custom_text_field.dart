import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walleto/shared/theme.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String? val)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLines;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    // this.errorValidation,
    this.inputFormatter,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
            textAlignVertical: TextAlignVertical.center,
            showCursor: true,
            cursorColor: Theme.of(context).iconTheme.color,
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatter,
            maxLines: (maxLines != null) ? maxLines : 1,
            // onChanged: onChanged,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(16.0),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kBlueColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: hintText,
              hintStyle:
                  greyTextStyle.copyWith(fontSize: 15, fontWeight: medium),
            ),
            validator: validator),
      ],
    );
  }
}
