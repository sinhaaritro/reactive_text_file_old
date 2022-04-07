// import 'dart:convert';

// import 'package:flutter/widgets.dart';

enum OperationType { create, read, update, move, insert, delete }

abstract class Operation {
  Map<String, dynamic> toMap();
  String toJson();
}

// class InsertOperation implements Operation {
//   final String text;
//   final int startIndex;

//   InsertOperation({required this.text, this.startIndex = -1});

//   InsertOperation copyWith({String? text, int? index}) {
//     return InsertOperation(
//       text: text ?? this.text,
//       startIndex: index ?? this.startIndex,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     return {'text': text, 'index': startIndex};
//   }

//   factory InsertOperation.fromMap(Map<String, dynamic> map) {
//     return InsertOperation(
//       text: map['text'] as String,
//       startIndex: map['index'] as int,
//     );
//   }

//   @override
//   String toJson() => json.encode(toMap());

//   factory InsertOperation.fromJson(String source) =>
//       InsertOperation.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'InsertOperation(text: $text, index: $startIndex)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is InsertOperation &&
//         other.text == text &&
//         other.startIndex == startIndex;
//   }

//   @override
//   int get hashCode => text.hashCode ^ startIndex.hashCode;

//   @override
//   TextStyle get textStyle => const TextStyle(fontWeight: FontWeight.normal);
// }

class DeleteOperation {
  int startIndex;
  int endIndex;

  DeleteOperation({required this.startIndex, required this.endIndex});
}
