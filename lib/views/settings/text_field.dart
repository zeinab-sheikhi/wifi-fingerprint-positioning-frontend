import 'package:access_point/utils/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
// ignore: import_of_legacy_library_into_null_safe
import 'package:regexed_validator/regexed_validator.dart';

// ignore: must_be_immutable
class SettingsTextField extends StatefulWidget {

  String sharedPrefKey;
  String defaultValue;
  String errorText;
  String labelText;
  Color textColor;
  Color cursorColor;
  Color enableColor;
  Color disableColor;
  Color focusedColor;
  Color errorColor;
  double contentPadding;
  bool isIP;

  SettingsTextField({
    required this.sharedPrefKey,
    required this.defaultValue,
    required this.errorText,
    required this.labelText,
    required this.textColor,
    required this.cursorColor,
    required this.enableColor,
    required this.disableColor,
    required this.focusedColor,
    required this.errorColor,
    required this.contentPadding,
    required this.isIP
});

  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {

  String _sharedPrefValue = '';
  late TextEditingController _controller;
  bool isValid = true;

  @override
  void initState() {
    _loadSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _customTextField(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _customTextField(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: widget.cursorColor,
      keyboardType: TextInputType.numberWithOptions(
            decimal: true,
            signed: false
        ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: widget.contentPadding),
        disabledBorder: _coloredBorder(widget.disableColor),
        enabledBorder: _coloredBorder(widget.enableColor),
        errorBorder: _coloredBorder(widget.errorColor),
        errorText: isValid? null : widget.errorText,
        errorStyle: _textStyle(widget.errorColor),
        focusedBorder: _coloredBorder(widget.focusedColor),
        focusedErrorBorder: _coloredBorder(widget.errorColor),
        hintStyle: _textStyle(colors.grey),
        hintText: widget.defaultValue,
        labelStyle: _textStyle(widget.enableColor),
        labelText: widget.labelText,
      ),
      style: _textStyle(widget.textColor),
      inputFormatters: widget.isIP? null : <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onEditingComplete: () {
          setState(() {
            _saveSharedPref(_controller.text);
          });
        FocusScope.of(context).unfocus();
      },

    );
  }

  InputBorder _coloredBorder(Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: color
    )
    );
  }

  TextStyle _textStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 16,
    );
  }

  _loadSharedPref() async {
    String result = PreferenceUtils.getString(widget.sharedPrefKey, widget.defaultValue);
    setState(() {
      _sharedPrefValue = result;
      _controller = TextEditingController(text: result);
    });
  }

  _saveSharedPref(String value) async {
    PreferenceUtils.setString(widget.sharedPrefKey, value);
  }


  _checkInputText(String inputValue) {
    if(widget.isIP) {
      if (inputValue.isEmpty || validator.ip(inputValue)) {
        setValidator(true);
      } else {
        setValidator(false);
      }
    } else {
      if (inputValue.isEmpty ) {
        setValidator(true);
      } else {
        setValidator(false);
      }
    }
  }

  void setValidator(valid){
    setState(() {
      isValid = valid;
    });
  }
}
