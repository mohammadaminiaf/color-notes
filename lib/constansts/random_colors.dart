import 'package:flutter/material.dart';

import '/models/note_color.dart';

const List<NoteColor> colors = [
  NoteColor(bodyColor: bodyRed, headerColor: headerRed),
  NoteColor(bodyColor: bodyOrange, headerColor: headerOrange),
  NoteColor(bodyColor: bodyGreen, headerColor: headerGreen),
  NoteColor(bodyColor: bodyBlue, headerColor: headerBlue),
  NoteColor(bodyColor: bodyPurple, headerColor: headerPurple),
  NoteColor(bodyColor: bodyGrey, headerColor: headerGrey),
  NoteColor(bodyColor: bodyYellow, headerColor: headerYellow),
];

const headerRed = Color(0xffF77581);
const bodyRed = Color(0xffFFE6E9);
const headerOrange = Color(0xffFEA853);
const bodyOrange = Color(0xffFFEBD8);
const headerYellow = Color(0xffF5DA65);
const bodyYellow = Color(0xffFEF8BA);
const headerGreen = Color(0xff96D467);
const bodyGreen = Color(0xffE5F8DC);
const headerBlue = Color(0xff83A5FF);
const bodyBlue = Color(0xffE8E9FE);
const headerPurple = Color(0xffB387DE);
const bodyPurple = Color(0xffEFE0FF);
const headerBlack = Color(0xff333333);
const bodyBlack = Color(0xffCCCCCC);
const headerGrey = Color(0xffCCCCCC);
const bodyGrey = Color(0xffEEEEEE);
const headerWhite = Color(0xffF0F0F0);
const bodyWhite = Color(0xffFFFFFF);
