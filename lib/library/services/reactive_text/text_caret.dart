import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TextCaret {
  const TextCaret({
    required this.color,
    this.width = 1.0,
    this.borderRadius = BorderRadius.zero,
  });

  final Color color;
  final double width;
  final BorderRadius borderRadius;

  Widget build({
    required BuildContext context,
    required RenderParagraph renderParagraph,
    required TextPosition position,
    required double lineHeight,
    required bool isTextEmpty,
    required bool showCaret,
  }) {
    return _BlinkingCaret(
      renderParagraph: renderParagraph,
      color: color,
      width: width,
      borderRadius: borderRadius,
      textPosition: position,
      lineHeight: lineHeight,
      isTextEmpty: isTextEmpty,
      showCaret: showCaret,
    );
  }
}

class _BlinkingCaret extends StatefulWidget {
  const _BlinkingCaret({
    Key? key,
    required this.renderParagraph,
    required this.color,
    required this.width,
    required this.borderRadius,
    required this.textPosition,
    required this.lineHeight,
    required this.isTextEmpty,
    required this.showCaret,
  }) : super(key: key);

  final RenderParagraph renderParagraph;
  final Color color;
  final double width;
  final BorderRadius borderRadius;
  final TextPosition textPosition;
  final double lineHeight;
  final bool isTextEmpty;
  final bool showCaret;

  @override
  _BlinkingCaretState createState() => _BlinkingCaretState();
}

class _BlinkingCaretState extends State<_BlinkingCaret>
    with SingleTickerProviderStateMixin {
  // Controls the blinking caret animation.
  late _CaretBlinkController _caretBlinkController;

  @override
  void initState() {
    super.initState();

    _caretBlinkController = _CaretBlinkController(
      tickerProvider: this,
    );
    _caretBlinkController.caretPosition = widget.textPosition;
  }

  @override
  void didUpdateWidget(_BlinkingCaret oldWidget) {
    super.didUpdateWidget(oldWidget);

    _caretBlinkController.caretPosition = widget.textPosition;
  }

  @override
  void dispose() {
    _caretBlinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CursorPainter(
        blinkController: _caretBlinkController,
        paragraph: widget.renderParagraph,
        width: widget.width,
        borderRadius: widget.borderRadius,
        caretTextPosition: widget.textPosition.offset,
        lineHeight: widget.lineHeight,
        caretColor: widget.color,
        isTextEmpty: widget.isTextEmpty,
        showCaret: widget.showCaret,
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  _CursorPainter({
    required this.blinkController,
    required this.paragraph,
    required this.width,
    required this.borderRadius,
    required this.caretTextPosition,
    required this.lineHeight,
    required this.caretColor,
    required this.isTextEmpty,
    required this.showCaret,
  })  : caretPaint = Paint()..color = caretColor,
        super(repaint: blinkController);

  final _CaretBlinkController blinkController;
  final RenderParagraph paragraph;
  final int caretTextPosition;
  final double width;
  final BorderRadius borderRadius;
  // TODO: this should probably also come from the TextPainter (#46).
  final double lineHeight;
  final bool isTextEmpty;
  final bool showCaret;
  final Color caretColor;
  final Paint caretPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (!showCaret) {
      return;
    }

    if (caretTextPosition < 0) {
      return;
    }

    caretPaint.color = caretColor.withOpacity(blinkController.opacity);

    final caretHeight = paragraph
            .getFullHeightForCaret(TextPosition(offset: caretTextPosition)) ??
        lineHeight;

    final Offset caretOffset = isTextEmpty
        ? Offset(0, (lineHeight - caretHeight) / 2)
        : paragraph.getOffsetForCaret(
            TextPosition(offset: caretTextPosition), Rect.zero);

    if (borderRadius == BorderRadius.zero) {
      canvas.drawRect(
        Rect.fromLTWH(
          caretOffset.dx.roundToDouble(),
          caretOffset.dy.roundToDouble(),
          width,
          caretHeight.roundToDouble(),
        ),
        caretPaint,
      );
    } else {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          caretOffset.dx.roundToDouble(),
          caretOffset.dy.roundToDouble(),
          caretOffset.dx.roundToDouble() + width,
          caretOffset.dy.roundToDouble() + caretHeight.roundToDouble(),
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        ),
        caretPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CursorPainter oldDelegate) {
    return paragraph != oldDelegate.paragraph ||
        caretTextPosition != oldDelegate.caretTextPosition ||
        isTextEmpty != oldDelegate.isTextEmpty ||
        showCaret != oldDelegate.showCaret;
  }
}

class _CaretBlinkController with ChangeNotifier {
  _CaretBlinkController({
    required TickerProvider tickerProvider,
    Duration flashPeriod = const Duration(milliseconds: 500),
  }) : _flashPeriod = flashPeriod;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final Duration _flashPeriod;
  Timer? _timer;
  bool _isVisible = true;
  double get opacity => _isVisible ? 1.0 : 0.0;

  TextPosition? _caretPosition;
  set caretPosition(TextPosition? newPosition) {
    if (newPosition != _caretPosition) {
      _caretPosition = newPosition;

      if (newPosition == null || newPosition.offset < 0) {
        _timer?.cancel();
      } else {
        _timer?.cancel();
        _timer = Timer(_flashPeriod, _onToggleTimer);
      }
    }
  }

  void _onToggleTimer() {
    _isVisible = !_isVisible;
    notifyListeners();

    _timer = Timer(_flashPeriod, _onToggleTimer);
  }
}
