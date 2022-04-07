import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'insert_operation.dart';
import 'operation.dart';

class TextBlock {
  /// Creates a editable text or paragraph block.
  /// Currently not editable.

  TextBlock({required this.id, this.ops}) {
    if (ops != null) {
      generateRichTextBlock();
    }
  }

  /// This is the block id. Used to track the block.
  /// The value can't be changed.
  /// Every block is assigned one at the time of creation
  final String id;

  /// This is list of operations that has to be performed on an
  /// empty text block. The result of appling all the [ops] will show
  /// the current state of the block.
  /// [Operation] is just a abstract wrapper for the operations.
  /// Look at the child [InsertOperation], [DeleteOperation].
  List<Operation>? ops;

  /// This stores the current number of [ops] performed on the text block.
  /// Mostly acts as the indicator to track is all the [ops] has been
  /// applied to the [richTextBlock].
  int _lastOpsReadIndex = -1;

  /// Contains a list of [TextSpan] that will be used by flutter to
  /// generate a text block.
  List<TextSpan> richTextBlock = [];

  /// Utility method used to check if all the [ops] has been applied
  /// to the [richTextBlock].
  bool isAllOpsApplied() => ops!.length > _lastOpsReadIndex + 1;

  /// Used to make [richTextBlock] from the list of [ops].
  /// Only generates [TextSpan] from child dont bother optimizing it.
  /// Good candidate to be PRIVATE.
  void generateRichTextBlock() {
    while (ops!.length > _lastOpsReadIndex + 1) {
      if (ops![_lastOpsReadIndex + 1] is InsertOperation) {
        final InsertOperation io =
            ops![_lastOpsReadIndex + 1] as InsertOperation;

        final TextStyle ioTextStyle = _generateTextStyle(io);

        if (io.startIndex == null) {
          if (richTextBlock.isNotEmpty &&
              richTextBlock.last.style == ioTextStyle) {
            _appendTextToTextSpanIndex(
              textSpanIndex: richTextBlock.length - 1,
              text: io.text,
              textPositionIndex:
                  richTextBlock[richTextBlock.length - 1].text!.length,
            );
          } else {
            _addTextSpanToList(
              index: richTextBlock.length,
              textSpan: TextSpan(text: io.text, style: ioTextStyle),
            );
          }
        } else {
          final getTextSpanIndex =
              _getTextSpanIndex(startIndex: io.startIndex!);
          final int richTextBlockIndex = getTextSpanIndex[0];
          final int textPosition = getTextSpanIndex[1];

          if (richTextBlock.isNotEmpty &&
              richTextBlock[richTextBlockIndex].style == ioTextStyle) {
            _appendTextToTextSpanIndex(
              textSpanIndex: richTextBlockIndex,
              text: io.text,
              textPositionIndex: textPosition,
            );
          } else if (richTextBlock.isNotEmpty &&
              richTextBlock[richTextBlockIndex + 1].style == ioTextStyle) {
            _appendTextToTextSpanIndex(
              textSpanIndex: richTextBlockIndex + 1,
              text: io.text,
              textPositionIndex: textPosition,
            );
          } else {
            _addTextSpanToList(
              index: richTextBlockIndex + 1,
              textSpan: TextSpan(text: io.text, style: ioTextStyle),
            );
          }
        }

        // richTextBlock.add(TextSpan(text: io.text));
        _lastOpsReadIndex += 1;

        print(richTextBlock.toString());
      }
    }
  }

  List<int> _getTextSpanIndex({required int startIndex}) {
    int textSpanIndex = 0, accumulatedTextLength = 0;
    late int textPosition;
    for (int i = 0; i < richTextBlock.length; i++) {
      textSpanIndex = i;
      final int textLength = richTextBlock[i].text!.length;
      accumulatedTextLength = accumulatedTextLength + textLength;
      if (startIndex <= accumulatedTextLength) {
        final int extraLength = accumulatedTextLength - startIndex;
        textPosition = textLength - extraLength;
        break;
      }
    }
    return [textSpanIndex, textPosition];
  }

  void _appendTextToTextSpanIndex({
    required int textSpanIndex,
    required int textPositionIndex,
    required String text,
  }) {
    final String originalText = richTextBlock[textSpanIndex].text!;
    final newText = originalText.substring(0, textPositionIndex) +
        text +
        originalText.substring(textPositionIndex);
    final textStyle = richTextBlock[textSpanIndex].style;
    richTextBlock[textSpanIndex] = TextSpan(text: newText, style: textStyle);
  }

  void _addTextSpanToList({required int index, required TextSpan textSpan}) {
    richTextBlock.insert(index, textSpan);
  }

  TextStyle _generateTextStyle(InsertOperation io) {
    TextStyle textStyle = const TextStyle();
    if (io.marks == null) {
      return textStyle;
    }
    for (final item in io.marks!) {
      switch (item) {
        case 'b':
          textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
          break;
        default:
          throw RangeError("Mark doesnt exits '$item'");
      }
    }
    return textStyle;
  }

  /// Adds more new [Operation]'s to [ops]. Also updates the [richTextBlock].
  /// Call this function every time you need to add to the [ops] list.
  void addMoreOpsAndGenerateTextBlock({required List<Operation> newOps}) {
    ops!.addAll(newOps);
    generateRichTextBlock();
  }

  @override
  String toString() => 'TextReader(id: $id, ops: $ops)';
}
