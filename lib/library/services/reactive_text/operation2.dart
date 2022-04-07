import 'dart:convert';

import 'package:collection/collection.dart';

class InsertOperation {
  final I i;
  InsertOperation({required this.i});

  InsertOperation copyWith({I? i}) {
    return InsertOperation(i: i ?? this.i);
  }

  Map<String, dynamic> toMap() {
    return {'i': i.toMap()};
  }

  factory InsertOperation.fromMap(Map<String, dynamic> map) {
    return InsertOperation(
      i: I.fromMap(map['i'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory InsertOperation.fromJson(String source) =>
      InsertOperation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Insert(i: $i)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InsertOperation && other.i == i;
  }

  @override
  int get hashCode => i.hashCode;
}

class I {
  final String text;
  final int index;
  final List<String>? mark;

  I({
    required this.text,
    this.index = -1,
    this.mark,
  });

  I copyWith({String? text, int? index, List<String>? mark}) {
    return I(
      text: text ?? this.text,
      index: index ?? this.index,
      mark: mark ?? this.mark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
      'mark': mark,
    }..removeWhere(
        (dynamic key, dynamic value) => key == null || value == null);
  }

  factory I.fromMap(Map<String, dynamic> map) {
    return I(
      text: map['text'] as String,
      index: map['index'] == null ? -1 : map['index'] as int,
      // mark: List<String>.from(map['mark'] as List<dynamic>),
      mark: map['mark'] == null
          ? null
          : List<String>.from(map['mark'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory I.fromJson(String source) =>
      I.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'I(text: $text, index: $index, mark: $mark)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is I &&
        other.text == text &&
        other.index == index &&
        const ListEquality().equals(other.mark, mark);
  }

  @override
  int get hashCode => text.hashCode ^ index.hashCode ^ mark.hashCode;
}

// void main() {
  // const String jsonData = '{"text": "World.","index": -1,"mark": ["bold"]}';
  // final deserealizeJ = I.fromJson(jsonData);
  // final serialize = deserealizeJ.toJson();
  // print('serialize: $serialize');
  // print('deserealizeJ: $deserealizeJ');

  // Simple json.
  // Case 1: The first text is inserted.
  // Only "text"
  // String jsonC1 = '{"i": {"txt": "The "}}';

  // Case 2: A text is inserted at the end.
  // Only "text"
  // String jsonC2 = '{"i": {"txt": "fox."}}';

  // Case 3: A text is inserted in the middle.
  // Only "text" and "st"
  // String jsonC3 = '{"i": {"txt": " jumps","st": 7}}';
  // final deserealize3 = InsertOperation.fromJson(jsonC3);
  // final serialize3 = deserealizeJ3.toJson();
  // print('serialize3: $serialize3');
  // print('deserealize3: $deserealizeJ3');

  // With Mark List.
  // Case 4: A text at the end with mark.
  // Only "text" and list of "mrk"
  // String jsonC4 = '{"i": {"txt": " jumps","mrk": ["bold"]}}';
  // final deserealize4 = InsertOperation.fromJson(jsonC4);
  // final serialize4 = deserealizeJ4.toJson();
  // print('serialize4: $serialize4');
  // print('deserealize4: $deserealizeJ4');

  // Case 5: A text at the end with empty mark list.
  // Only "text" and list of empty "mrk"
  // String jsonC5 = '{"i": {"txt": " jumps","mrk": []}}';

  // Case 6: A text in the middle with mark.
  // Only "text", "st" and list of "mrk"
  // String jsonC6 = '{"i": {"txt": " jumps","st": 4,"mrk": ["bold"]}}';
  // final deserealize6 = I.fromJson(jsonC6);
  // final serialize6 = deserealize6.toJson();
  // print('serialize6: $serialize6');
  // print('deserealize6: $deserealize6');

  // Case 7: A text in the middle empty mark list.
  // Only "text", "st" and list of empty "mrk"
  // String jsonC7 = '{"i": {"txt": " jumps","st": 4,"mrk": []}}';

  // Extra modifier like Text Size, Text Color, Highlight Color.
  // Case 8: A text is inserted at the end with text size.
  // Only "text" and text size value
  // String jsonC8 = '{"i": {"txt": "fox.","textSize": 16}}';

  // Case 9: A text is inserted in the middle with text size.
  // Only "text" and text size value
  // String jsonC9 = '{"i": {"txt": "fox.","st": 7,"textSize": 16}}';

  // Case 10: A text is inserted at the end with text color.
  // Only "text" and text color value
  // String jsonC10 = '{"i": {"txt": "fox.","textColor": "#fcba03ff"}}';

  // Case 11: A text is inserted in the middle with text color.
  // Only "text", "st" and text color value
  // String jsonC11 = '{"i": {"txt": " jumps","st": 7,"textColor": "#fcba03ff"}}';

  // Case 12: A text is inserted at the end with highlight color.
  // Only "text" and text color value
  // String jsonC10 = '{"i": {"txt": "fox.","highlightColor": "#fcba03ff"}}';

  // Case 13: A text is inserted in the middle with highlight color.
  // Only "text", "st" and text color value
  // String jsonC11 = '{"i": {"txt": " jumps","st": 7,"highlightColor": "#fcba03ff"}}';

  // Case 14: A text is inserted at the end with text size, text color, highlight color.
  // Only "text" and text color value
  // String jsonC10 = '{"i": {"txt": "fox.","textSize": 16,"textColor": "#fcba03ff"},"highlightColor": "#fcba03ff"}}';

  // Case 15: A text is inserted in the middle with text size, text color, highlight color.
  // Only "text", "st" and text color value
  // String jsonC11 = '{"i": {"txt": " jumps","st": 7,"textSize": 16,"textColor": "#fcba03ff"},"highlightColor": "#fcba03ff"}}';

  // print('done');
// }
