import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';
import './app_outlined_input_field.dart';

class AppOutlinedOtpField extends StatefulWidget {
  const AppOutlinedOtpField({
    super.key,
    required this.otpLength,
    required this.onOtpTextCompleted,
  });

  final int otpLength;
  final Function(String) onOtpTextCompleted;

  @override
  State<AppOutlinedOtpField> createState() => _AppOutlinedOtpFieldState();
}

class _AppOutlinedOtpFieldState extends State<AppOutlinedOtpField>
    with WidgetsBindingObserver {
  final List<TextEditingController> _textEditingControllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    _focusNodes.clear();
    _textEditingControllers.clear();
    for (int i = 0; i < widget.otpLength; i++) {
      _textEditingControllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onAppResumed();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].unfocus();
    }
    for (int i = 0; i < _textEditingControllers.length; i++) {
      _textEditingControllers[i].dispose();
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      for (int i = 0; i < _focusNodes.length; i++) {
        _focusNodes[i].dispose();
      }
    });
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  TextEditingController _fieldController(int index) {
    if (widget.otpLength <= index) {
      return _textEditingControllers[0];
    }
    return _textEditingControllers[index];
  }

  FocusNode _fieldFocusNode(int index) {
    if (widget.otpLength <= index) {
      return _focusNodes[0];
    }
    return _focusNodes[index];
  }

  void _onAppResumed() {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      _requestFocusOnAppResumed();
    });
  }

  void _requestFocusOnAppResumed() {
    for (int i = 0; i < widget.otpLength; i++) {
      if (_textEditingControllers[i].text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNodes[i]);
        break;
      }
    }
  }

  void _changeFocusToPreviousNodeWhenTapBackspace() {
    try {
      final index = _focusNodes.indexWhere((element) => element.hasFocus);
      if (index > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        });
      }
    } catch (_) {}
  }

  Future<void> _handleClipboardData() async {
    if (AppConfig.isOtpPrefilledWithClipBoard) {
      final ClipboardData? clipBoardData =
          await Clipboard.getData(Clipboard.kTextPlain);
      if (clipBoardData != null &&
          clipBoardData.text != null &&
          clipBoardData.text?.trim().length == widget.otpLength &&
          int.tryParse(clipBoardData.text!) != null &&
          _textEditingControllers[0].text == clipBoardData.text![0]) {
        for (int i = 1; i < _textEditingControllers.length; i++) {
          _textEditingControllers[i].text = clipBoardData.text![i];
        }
        _focusOnLastField();
      }
    }
  }

  void _focusOnLastField() {
    FocusScope.of(context).requestFocus(_focusNodes[widget.otpLength - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (value) {
        if (value is KeyDownEvent &&
            value.logicalKey == LogicalKeyboardKey.backspace) {
          _changeFocusToPreviousNodeWhenTapBackspace();
        }
      },
      child: _otpFieldWidget(),
    );
  }

  Widget _otpFieldWidget() {
    const maxChars = 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.otpLength,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FocusTraversalOrder(
              order: NumericFocusOrder(index.toDouble()),
              child: AppOutlinedInputField(
                width: AppDimens.dimensOtpInputFieldSize.w,
                height: AppDimens.dimensOtpInputFieldSize.w,
                textInputType: TextInputType.number,
                textInputAction: (index != widget.otpLength - 1)
                    ? TextInputAction.next
                    : TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxChars: maxChars,
                textAlign: TextAlign.center,
                textStyle: AppTextStyle.textSize24SemiBold,
                controller: _fieldController(index),
                focusNode: _fieldFocusNode(index),
                autofocus: index == 0,
                isDense: false,
                contentPadding: EdgeInsets.zero,
                onFieldSubmitted: (value) {
                  if ((index != widget.otpLength - 1)) {
                    FocusScope.of(context).requestFocus(
                      _fieldFocusNode(index + 1),
                    );
                  }
                },
                onTextChanged: (value) async {
                  if (value.isEmpty) {
                    if (index > 0) {
                      FocusScope.of(context)
                          .requestFocus(_fieldFocusNode(index - 1));
                    }
                  } else if (value.length == maxChars) {
                    if (index < widget.otpLength - 1) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        FocusScope.of(context)
                            .requestFocus(_fieldFocusNode(index + 1));
                      });
                    }
                  }

                  if (index == 0) {
                    await _handleClipboardData();
                  }

                  String otp =
                      _textEditingControllers.map((e) => e.text).join();
                  widget.onOtpTextCompleted(otp);

                  // If all fields are filled, remove focus
                  if (otp.length == widget.otpLength) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            ),
            if (index != widget.otpLength - 1)
              SizedBox(
                width: AppDimens.dimens15.w,
              ),
          ],
        ),
      ),
    );
  }
}
