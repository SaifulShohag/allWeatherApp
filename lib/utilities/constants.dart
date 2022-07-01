import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 55.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 27.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25.0,
);

const smallDetails = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 15.0,
  height: 1.5,
);


const textFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(7.0),
    ),
    borderSide: BorderSide.none,
  ),
);
