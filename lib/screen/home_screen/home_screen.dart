// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:reactive_text_file/library/services/reactive_text/simple_selectable_text.dart';
import 'package:reactive_text_file/library/services/reactive_text/text_caret.dart';
import 'package:reactive_text_file/screen/home_screen/all_text_options.dart';
import 'package:reactive_text_file/screen/home_screen/editable_text_test.dart';
import 'package:reactive_text_file/screen/home_screen/raw_keyboard_input_test.dart';
import 'package:reactive_text_file/screen/home_screen/selectable_text_test.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            // RawKeyboardExample(),
            // const TextField(),
            // const SizedBox(height: 50),
            // RawKeyboardExample(),
            // const EditableTextTest(),
            // const SizedBox(height: 50),
            // const SelectableTextTest(),
            // const SizedBox(height: 50),
            const AllTextOptions(),
            const SizedBox(height: 50),
            const SimpleSelectableText(
              textSpan: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Hello '),
                  TextSpan(
                      text: 'bold',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' world!'),
                ],
              ),
              showDebugPaint: true,
              textSelection: TextSelection(baseOffset: 2, extentOffset: 5),
              highlightWhenEmpty: true,
              showCaret: true,
              textCaret: TextCaret(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
