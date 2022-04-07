import 'package:flutter/material.dart';

class AllTextOptions extends StatelessWidget {
  const AllTextOptions({Key? key}) : super(key: key);

  void _printSelection(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    // ignore: avoid_print
    print(selection);
    // ignore: avoid_print
    print(cause);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText.rich(
          TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: const <InlineSpan>[
              TextSpan(text: 'Hello '),
              TextSpan(
                text: 'beautiful ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  backgroundColor: Color(0xffaec3cb),
                ),
              ),
              // WidgetSpan(
              //     child: SizedBox(
              //   width: 120,
              //   height: 50,
              //   child: Card(child: Center(child: Text('Hello World!'))),
              // )),
              TextSpan(
                text: 'world',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          showCursor: true,
          onSelectionChanged: _printSelection,
          toolbarOptions: const ToolbarOptions(
            cut: true,
            copy: true,
            paste: true,
            selectAll: true,
          ),
        ),
        const Text.rich(
          TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                  child: SizedBox(
                width: 120,
                height: 50,
                child: Card(child: Center(child: Text('Hello World!'))),
              )),
              TextSpan(
                text: 'Widget in flutter',
                style: TextStyle(
                  // background: ,
                  backgroundColor: Color.fromARGB(255, 252, 186, 3),
                  color: Color.fromARGB(255, 14, 20, 40),
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromARGB(255, 14, 20, 40),
                  decorationStyle: TextDecorationStyle.solid,
                  fontFamily: 'Roboto',
                  // fontFamilyFallback: ,
                  // fontFeatures: FontFeature.proportionalFigures(),
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // foreground: ,
                  // height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                  // letterSpacing: 1,
                  // shadows: ,
                  textBaseline: TextBaseline.ideographic,
                  wordSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
