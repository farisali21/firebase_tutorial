import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xffEF4760);
const Color defaultColor = Color(0xffEF4760);
const Color kSecondaryColor = Color(0xffF591A0);
var kBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: kPrimaryColor, width: 1));
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a Value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF8BBD0), width: 1.0),
    // borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEF4760), width: 2.0),
  ),
);
