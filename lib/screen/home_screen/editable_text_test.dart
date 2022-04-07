import 'package:flutter/material.dart';

class EditableTextTest extends StatefulWidget {
  const EditableTextTest({Key? key}) : super(key: key);

  @override
  _EditableTextTestState createState() => _EditableTextTestState();
}

class _EditableTextTestState extends State<EditableTextTest> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: 60,
          child: Text('This is a text from the text widget'),
        ),
        SizedBox(
          width: 60,
          child: Wrap(
            children: const <Widget>[
              Text('This is a text '),
              Text('from the text widget')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.red,
                child: EditableText(
                  controller: TextEditingController(text: 'Text1'),
                  focusNode: FocusNode(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  cursorColor: const Color.fromARGB(255, 14, 20, 40),
                  backgroundCursorColor: const Color.fromARGB(255, 252, 186, 3),
                ),
              ),
              Container(
                width: 50,
                color: Colors.green,
                child: EditableText(
                  controller: TextEditingController(text: 'Text2'),
                  focusNode: FocusNode(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  cursorColor: const Color.fromARGB(255, 14, 20, 40),
                  backgroundCursorColor: const Color.fromARGB(255, 252, 186, 3),
                ),
              ),
            ],
          ),
        ),
        EditableText(
          controller: TextEditingController(text: 'This is text'),
          focusNode: focusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
          cursorColor: const Color.fromARGB(255, 14, 20, 40),
          backgroundCursorColor: const Color.fromARGB(255, 252, 186, 3),
          showSelectionHandles: true,
        ),
      ],
    );
  }
}
