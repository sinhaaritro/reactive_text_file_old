import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:reactive_text_file/library/utility/color_conversion.dart';

import 'operation.dart';

enum TextMarks {
  bold,
  italic,
  underline,
  highlight,
  strikethrough,
  subscript,
  superscript,
  math,
}

extension TextIndex on TextMarks {
  // Overload the [] getter to get the TextMarks.
  TextMarks operator [](String key) => (name) {
        switch (name) {
          case 'b':
            return TextMarks.bold;
          case 'i':
            return TextMarks.italic;
          case 'u':
            return TextMarks.underline;
          default:
            throw RangeError("enum TextMarks contains no value '$name'");
        }
      }(key);
}

class InsertOperation implements Operation {
  final String text;
  final int? startIndex;
  final List<String>? marks;
  final int? textSize;
  final Color? textColor;
  final Color? backgroundColor;

  InsertOperation({
    required this.text,
    this.startIndex,
    this.marks,
    this.textSize,
    this.textColor,
    this.backgroundColor,
  });

  InsertOperation copyWith({
    String? text,
    int? startIndex,
    List<String>? marks,
    int? textSize,
    Color? textColor,
    Color? backgroundColor,
  }) {
    return InsertOperation(
      text: text ?? this.text,
      startIndex: startIndex ?? this.startIndex,
      marks: marks ?? this.marks,
      textSize: textSize ?? this.textSize,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'txt': text,
      'st': startIndex,
      'mrk': marks,
      'ts': textSize,
      'tc': textColor == null ? null : ColorConversion.toHex(textColor!),
      'bc': backgroundColor == null
          ? null
          : ColorConversion.toHex(backgroundColor!),
    }..removeWhere(
        (dynamic key, dynamic value) => key == null || value == null);
  }

  factory InsertOperation.fromMap(Map<String, dynamic> map) {
    return InsertOperation(
      text: map['txt'] as String,
      // startIndex: map['st'] as int,
      startIndex: map['st'] == null ? null : map['st'] as int,
      // mrk: List<String>.from(map['mrk']),
      marks: map['mrk'] == null
          ? null
          : List<String>.from(map['mrk'] as List<dynamic>),
      textSize: map['ts'] == null ? null : map['ts'] as int,
      textColor: map['tc'] == null
          ? null
          : ColorConversion.hex4ToColor(map['tc'] as String),
      backgroundColor: map['bc'] == null
          ? null
          : ColorConversion.hex4ToColor(map['bc'] as String),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory InsertOperation.fromJson(String source) =>
      InsertOperation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InsertOperation(txt: $text, st: $startIndex, mrk: $marks, ts: $textSize, tc: $textColor, bc: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InsertOperation &&
        other.text == text &&
        other.startIndex == startIndex &&
        listEquals(other.marks, marks) &&
        other.textSize == textSize &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        startIndex.hashCode ^
        marks.hashCode ^
        textSize.hashCode ^
        textColor.hashCode ^
        backgroundColor.hashCode;
  }
}
