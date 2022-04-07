import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_text_file/library/services/reactive_text/insert_operation.dart';

void main() {
  group('Insert Operation, to and fro JSON: ', () {
    group('With Text: ', () {
      test(
          'Given Json string with "text" When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text"}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, null);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: null, ts: null, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with "text" field When changed to Json Then prints the minimum json with txt as the property',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(text: 'Text');

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text"}');
      });

      test(
          'Given Json string with "text" and "index" When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","st":7}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, 7);
        expect(io.marks, null);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: 7, mrk: null, ts: null, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with "text" and "index" field When changed to Json Then prints the minimum json with txt and start as the property',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(text: 'Text', startIndex: 7);

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","st":7}');
      });
    });

    group('With Text and Marks: ', () {
      test(
          'Given Json string with "text" and "mark" list When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","mrk":["b"]}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, ['b']);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: [b], ts: null, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "mark" list field When changed to Json Then prints the minimum json with txt and mark list as the property',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(text: 'Text', marks: ['b']);

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","mrk":["b"]}');
      });

      test(
          'Given Json string with "text" and "mark" empty list When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","mrk":[]}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, []);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: [], ts: null, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "mark" empty list field When changed to Json Then prints the minimum json with txt and mark as the property',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(text: 'Text', marks: []);

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","mrk":[]}');
      });

      test(
          'Given Json string with "text" and "mark" list with multiple values When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","mrk":["b","i"]}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, ['b', 'i']);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: [b, i], ts: null, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "mark" list with multiple values field When changed to Json Then prints the minimum json with txt and "mark" list as the property',
          () async {
        // ARRANGE
        final InsertOperation io =
            InsertOperation(text: 'Text', marks: ['b', 'i']);

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","mrk":["b","i"]}');
      });
    });

    group('With Text and Extra Modifier: ', () {
      test(
          'Given Json string with "text" and "text size" When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","ts":20}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, null);
        expect(io.textSize, 20);
        expect(io.textColor, null);
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: null, ts: 20, tc: null, bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "text size" field When changed to Json Then prints the minimum json with "txt" and "ts" as properties',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(text: 'Text', textSize: 20);

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","ts":20}');
      });

      test(
          'Given Json string with "text" and "text color" When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","tc":"#fcba03ff"}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, null);
        expect(io.textSize, null);
        expect(io.textColor, const Color.fromARGB(255, 252, 186, 3));
        expect(io.backgroundColor, null);
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: null, ts: null, tc: Color(0xfffcba03), bc: null)',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "text color" field When changed to Json Then prints the minimum json with "txt" and "tc" as properties',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(
          text: 'Text',
          textColor: const Color.fromARGB(255, 252, 186, 3),
        );

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","tc":"#fcba03ff"}');
      });

      test(
          'Given Json string with "text" and "highlight color" When made into InsertOperation Then the class toString() prints only required property',
          () async {
        // ARRANGE
        const String jsonData = '{"txt":"Text","bc":"#fcba03ff"}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, null);
        expect(io.marks, null);
        expect(io.textSize, null);
        expect(io.textColor, null);
        expect(io.backgroundColor, const Color.fromARGB(255, 252, 186, 3));
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: null, mrk: null, ts: null, tc: null, bc: Color(0xfffcba03))',
        );
      });
      test(
          'Given a class InsertOperation with only "text" and "highlight color" field When changed to Json Then prints the minimum json with "txt" and "bc" as properties',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(
          text: 'Text',
          backgroundColor: const Color.fromARGB(255, 252, 186, 3),
        );

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(serealize, '{"txt":"Text","bc":"#fcba03ff"}');
      });
    });

    group('With Text and Marks and Extra Modifiers: ', () {
      test(
          'Given Json string with "text", "marks" list and "extra modifier" When made into InsertOperation Then the class toString() prints all property',
          () async {
        // ARRANGE
        const String jsonData =
            '{"txt":"Text","st":7,"mrk":["b","i"],"ts":20,"tc":"#0e1428ff","bc":"#fcba03ff"}';

        // ACT
        final InsertOperation io = InsertOperation.fromJson(jsonData);

        // ASSERT
        expect(io.text, 'Text');
        expect(io.startIndex, 7);
        expect(io.marks, ['b', 'i']);
        expect(io.textSize, 20);
        expect(io.textColor, const Color.fromARGB(255, 14, 20, 40));
        expect(io.backgroundColor, const Color.fromARGB(255, 252, 186, 3));
        expect(
          io.toString(),
          'InsertOperation(txt: Text, st: 7, mrk: [b, i], ts: 20, tc: Color(0xff0e1428), bc: Color(0xfffcba03))',
        );
      });
      test(
          'Given a class InsertOperation with all fields When changed to Json Then prints the minimum json with all the properties',
          () async {
        // ARRANGE
        final InsertOperation io = InsertOperation(
          text: 'Text',
          startIndex: 7,
          marks: ['b', 'i'],
          textSize: 20,
          textColor: const Color.fromARGB(255, 14, 20, 40),
          backgroundColor: const Color.fromARGB(255, 252, 186, 3),
        );

        // ACT
        final serealize = io.toJson();

        // ASSERT
        expect(
          serealize,
          '{"txt":"Text","st":7,"mrk":["b","i"],"ts":20,"tc":"#0e1428ff","bc":"#fcba03ff"}',
        );
      });
    });
  });
}
