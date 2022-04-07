import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Spike:
/// Create a minimal widget implementation that directly handles text input.
///
/// This spike implements:
///  - A widget that implements `TextInputClient` and opens a connection to
///    the underlying platform. This approach seems to be specifically tailored
///    to Android and iOS, where various adjustments are made to content
///    by the platform.
///  - A widget that listens to `RawKeyboard` and processes every keystroke.
///
/// Conclusion:
/// I think we should try an initial implementation using `RawKeyboard` instead
/// of `TextInputClient`. We don't need mobile affordances for desktop and web,
/// and that's most of what `TextInputClient` provides.

class RawKeyboardExample extends StatefulWidget {
  @override
  _RawKeyboardExampleState createState() => _RawKeyboardExampleState();
}

class _RawKeyboardExampleState extends State<RawKeyboardExample> {
  late TextEditingController _editingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_onKeyPressed);
    _focusNode.dispose();
    _editingController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      RawKeyboard.instance.addListener(_onKeyPressed);
    } else {
      RawKeyboard.instance.removeListener(_onKeyPressed);
    }
  }

  void _onKeyPressed(RawKeyEvent keyEvent) {
    if (keyEvent is! RawKeyUpEvent) {
      return;
    }

    print('Key pressed: $keyEvent');

    if (_isCharacterKey(keyEvent.logicalKey)) {
      _editingController.value = TextEditingValue(
        text: _editingController.text + keyEvent.logicalKey.keyLabel,
      );
    } else if (keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      _editingController.value = TextEditingValue(
        text: '${_editingController.text}\n',
      );
    } else if (keyEvent.logicalKey == LogicalKeyboardKey.backspace) {
      // print(' - its backspace');
      final currentText = _editingController.text;

      if (currentText.isEmpty) {
        print('Text is empty. Nothing to delete: "$currentText"');
        return;
      }

      _editingController.value = TextEditingValue(
        text: currentText.substring(0, currentText.length - 1),
        // selection: _editingController.selection.copyWith(
        //   extentOffset: _editingController.selection.extentOffset - 1,
        // ),
      );
      print('Did backspace: "${_editingController.value.text}"');
    }
  }

  bool _isCharacterKey(LogicalKeyboardKey key) {
    // keyLabel for a character should be: 'a', 'b',...,'A','B',...
    if (key.keyLabel.length != 1) {
      return false;
    }
    return 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890.,/;\'[]\\`~!@#\$%^&*()_+<>?:"{}|'
        .contains(key.keyLabel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: AnimatedBuilder(
        animation: FocusManager.instance,
        builder: (context, child) {
          return Focus(
            focusNode: _focusNode,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _focusNode.hasFocus ? Colors.blue : Colors.grey,
                  width: 1,
                ),
              ),
              child: child,
            ),
          );
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: AnimatedBuilder(
            animation: _editingController,
            builder: (context, child) {
              return Text(
                _editingController.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.4,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
