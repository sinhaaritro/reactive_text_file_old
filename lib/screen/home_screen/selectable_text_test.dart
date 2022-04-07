import 'package:flutter/material.dart';
import 'package:reactive_text_file/library/services/reactive_text/insert_operation.dart';
import 'package:reactive_text_file/library/services/reactive_text/text_block.dart';

class SelectableTextTest extends StatefulWidget {
  const SelectableTextTest({Key? key}) : super(key: key);

  @override
  _SelectableTextTestState createState() => _SelectableTextTestState();
}

class _SelectableTextTestState extends State<SelectableTextTest> {
  void _printSelection(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    // ignore: avoid_print
    print(selection);
    // ignore: avoid_print
    print(cause);
    // ignore: avoid_print
    print(textEditingController.text);
  }

  final TextEditingController textEditingController = TextEditingController();

  final TextBlock tr = TextBlock(id: '11s', ops: [
    InsertOperation(text: 'First '),
    InsertOperation(text: 'Insert '),
    InsertOperation(text: 'BoldEnd', marks: ['b']),
    InsertOperation(text: 'Extra', startIndex: 17, marks: ['b']),
  ]);

  @override
  void initState() {
    textEditingController.addListener(_addressControllerListener);
    super.initState();
  }

  void _addressControllerListener() {
    setState(() {});
    print(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(_addressControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // tr.generateRichTextBlock();
    return SelectableText.rich(
      TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
        children: tr.richTextBlock,
      ),
      showCursor: true,
      onSelectionChanged: _printSelection,
      toolbarOptions: const ToolbarOptions(
        cut: true,
        copy: true,
        paste: true,
        selectAll: true,
      ),
    );
  }
}
