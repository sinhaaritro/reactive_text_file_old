import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reactive_text_file/library/services/reactive_text/text_caret.dart';

class SimpleSelectableText extends StatefulWidget {
  const SimpleSelectableText({
    Key? key,
    required TextSpan textSpan,
    this.showDebugPaint = false,
    this.textSelection = const TextSelection.collapsed(offset: -1),
    this.textSelectionDecoration = const TextSelectionDecoration(
      selectionColor: Color(0xFFACCEF7),
    ),
    this.highlightWhenEmpty = false,
    this.showCaret = false,
    this.textCaret = const TextCaret(
      color: Colors.black,
    ),
  })  : richText = textSpan,
        super(key: key);

  /// The text to be displayed by this widget
  final TextSpan richText;

  /// [bool] that will paints extra decoration to visualize [Text] boundaries.
  final bool showDebugPaint;

  /// The portion of [richText] to display with the selection.
  final TextSelection textSelection;

  /// The visual decoration to apply to the [textSelection].
  final TextSelectionDecoration textSelectionDecoration;

  /// True to show a thin selection highlight when [richText]
  /// is empty, or false to avoid showing a selection highlight
  /// when [richText] is empty.
  ///
  /// This is useful when multiple [SimpleSelectableText] widgets
  /// are selected and some of the selected [SimpleSelectableText]
  /// widgets are empty.
  final bool highlightWhenEmpty;

  /// True to display a caret in this [SimpleSelectableText] at
  /// the [extent] of [textSelection], or false to avoid
  /// displaying a caret.
  final bool showCaret;

  /// Builds the visual representation of the caret in this
  /// [SimpleSelectableText] widget.
  /// TODO: Turn it to list
  final TextCaret textCaret;

  @override
  _SimpleSelectableTextState createState() => _SimpleSelectableTextState();
}

class _SimpleSelectableTextState extends State<SimpleSelectableText> {
  /// [GlobalKey] that provides access to the [RenderParagraph] associated
  /// with the text that this [SimpleSelectableText] widget displays.
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _updateTextLength();
  }

  @override
  void didUpdateWidget(SimpleSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.richText != oldWidget.richText) {
      _updateTextLength();
    }
  }

  /// The current length of the [Text] displayed by this widget. The value
  /// is cached because computing the length of rich text may have
  /// non-trivial performance implications.
  late int _cachedTextLength;
  int get _textLength => _cachedTextLength;
  void _updateTextLength() {
    _cachedTextLength = widget.richText.toPlainText().length;
  }

  RenderParagraph? get _renderParagraph => _textKey.currentContext != null
      ? _textKey.currentContext!.findRenderObject()! as RenderParagraph
      : null;

  List<Rect> _computeTextRectangles(RenderParagraph renderParagraph) {
    return renderParagraph
        .getBoxesForSelection(TextSelection(
          baseOffset: 0,
          extentOffset: widget.richText.toPlainText().length,
        ))
        .map((box) => box.toRect())
        .toList();
  }

  double get _lineHeight {
    final fontSize = widget.richText.style?.fontSize;
    final lineHeight = widget.richText.style?.height;
    if (fontSize != null && lineHeight != null) {
      return fontSize * lineHeight;
    } else {
      return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_renderParagraph == null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {
          // Force another frame so that we can use the renderParagraph.
        });
      });
    }

    return Stack(
      children: [
        if (widget.showDebugPaint) _buildDebugPaint(),
        _buildTextSelection(),
        // _FillWidthIfConstrained(
        //   child: ,
        // ),
        _buildText(),
        // _FillWidthIfConstrained(
        //   child:
        // ),
        _buildTextCaret(),
      ],
    );
  }

  Widget _buildDebugPaint() {
    if (_renderParagraph == null) return const SizedBox();

    if (_renderParagraph!.hasSize &&
        (kDebugMode && _renderParagraph!.debugNeedsLayout)) {
      // Schedule another frame so we can compute the debug paint.
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
      return const SizedBox();
    }

    return Positioned.fill(
      child: CustomPaint(
        painter: _DebugTextPainter(
          textRectangles: _computeTextRectangles(_renderParagraph!),
        ),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildTextSelection() {
    if (_renderParagraph == null) return const SizedBox();

    return widget.textSelectionDecoration.build(
      context: context,
      renderParagraph: _renderParagraph!,
      selection: widget.textSelection,
      isTextEmpty: _textLength == 0,
      highlightWhenEmpty: widget.highlightWhenEmpty,
      emptyLineHeight: _lineHeight,
    );
  }

  Widget _buildText() {
    return RichText(
      key: _textKey,
      text: widget.richText,
    );
  }

  Widget _buildTextCaret() {
    if (_renderParagraph == null) {
      return const SizedBox();
    }

    return RepaintBoundary(
      child: widget.textCaret.build(
        context: context,
        renderParagraph: _renderParagraph!,
        position: widget.textSelection.extent,
        lineHeight: _lineHeight,
        isTextEmpty: _textLength == 0,
        showCaret: widget.showCaret,
      ),
    );
  }
}

class _DebugTextPainter extends CustomPainter {
  _DebugTextPainter({
    required this.textRectangles,
  });

  final List<Rect> textRectangles;
  final Paint leftBoundaryPaint = Paint()..color = const Color(0xFFCCCCCC);
  final Paint textBoxesPaint = Paint()
    ..color = const Color(0xFFCCCCCC)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    for (final rect in textRectangles) {
      canvas.drawRect(
        rect,
        textBoxesPaint,
      );
    }

    // Paint left boundary.
    // canvas.drawRect(
    //   Rect.fromLTWH(-6, 0, 2, size.height),
    //   leftBoundaryPaint,
    // );
  }

  @override
  bool shouldRepaint(_DebugTextPainter oldDelegate) {
    return textRectangles != oldDelegate.textRectangles;
  }
}

class TextSelectionDecoration {
  const TextSelectionDecoration({
    required this.selectionColor,
  });

  final Color selectionColor;

  Widget build({
    required BuildContext context,
    required RenderParagraph renderParagraph,
    required TextSelection selection,
    required bool isTextEmpty,
    required bool highlightWhenEmpty,
    required double emptyLineHeight,
  }) {
    return CustomPaint(
      painter: _TextSelectionPainter(
        renderParagraph: renderParagraph,
        selection: selection,
        selectionColor: selectionColor,
        isTextEmpty: isTextEmpty,
        highlightWhenEmpty: highlightWhenEmpty,
        emptySelectionHeight: emptyLineHeight,
      ),
    );
  }
}

class _TextSelectionPainter extends CustomPainter {
  _TextSelectionPainter({
    required this.isTextEmpty,
    required this.renderParagraph,
    required this.selection,
    required this.emptySelectionHeight,
    required this.selectionColor,
    this.highlightWhenEmpty = false,
  }) : selectionPaint = Paint()..color = selectionColor;

  final bool isTextEmpty;
  final RenderParagraph renderParagraph;
  final TextSelection selection;
  final double emptySelectionHeight;
  // When true, an empty, collapsed selection will be highlighted
  // for the purpose of showing a highlighted empty line.
  final bool highlightWhenEmpty;
  final Color selectionColor;
  final Paint selectionPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (isTextEmpty &&
        highlightWhenEmpty &&
        selection.isCollapsed &&
        selection.extentOffset == 0) {
      //&& highlightWhenEmpty) {
      // This is an empty paragraph, which is selected. Paint a small selection.
      canvas.drawRect(
        const Rect.fromLTWH(0, 0, 5, 20),
        selectionPaint,
      );
    }

    final selectionBoxes = renderParagraph.getBoxesForSelection(selection);

    for (final box in selectionBoxes) {
      final rawRect = box.toRect();
      final rect = Rect.fromLTWH(
          rawRect.left, rawRect.top - 2, rawRect.width, rawRect.height + 4);

      canvas.drawRect(
        // Note: If the rect has no width then we've selected an empty line. Give
        //       that line a slight width for visibility.
        rect.width > 0
            ? rect
            : Rect.fromLTWH(rect.left, rect.top, 5, rect.height),
        selectionPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_TextSelectionPainter oldDelegate) {
    return renderParagraph != oldDelegate.renderParagraph ||
        selection != oldDelegate.selection;
  }
}

/// Forces [child] to take up all available width when the
/// incoming width constraint is bounded, otherwise the [child]
/// is sized by its intrinsic width.
///
/// If there is an existing widget that does this, get rid of this
/// widget and use the standard widget.
class _FillWidthIfConstrained extends SingleChildRenderObjectWidget {
  const _FillWidthIfConstrained({
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderFillWidthIfConstrained();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    renderObject.markNeedsLayout();
  }
}

class _RenderFillWidthIfConstrained extends RenderProxyBox {
  @override
  void performLayout() {
    size = computeDryLayout(constraints);

    if (child != null) {
      child!.layout(BoxConstraints.tight(size));
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return Size.zero;
    }

    Size size = child!.computeDryLayout(constraints);

    // If the available width is bounded and the child did not
    // take all available width, force the child to be as wide
    // as the available width.
    if (constraints.hasBoundedWidth && size.width < constraints.maxWidth) {
      size = Size(constraints.maxWidth, size.height);
    }

    return size;
  }
}
