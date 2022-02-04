import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'support_text_field.dart';
export 'support_text_field.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final Function(String txt)? onChange;
  final String? format;
  final bool isForm;
  final String? label;
  final formType type;
  final bool showSuffix;
  final Function(bool val)? onSuffix;
  final bool outLabel;
  final bool? obscureText;
  final TextEditingController controller;
  final String? hint;
  final dynamic icon;
  final bool enabled;
  final bool hideCount;
  final String? Function(String txt)? outValidate;
  final bool isRequired;
  final dynamic defaultValue;
  final Function()? onSubmitted;
  int? maxLength;
  double margin;
  Function(String v)? onEndChanged;
  final double? labelSize;
  final int minLines;
  final int? maxLines;
  final bool? isDense;
  final bool border;
  final bool background;
  final FocusNode? focus;
  final Color? color;

  CustomTextField(
      {Key? key, this.label,
      required this.controller,
      this.border = false,
      this.format,
      this.onSubmitted,
      this.type = formType.any,
      this.onChange,
      this.onEndChanged,
      this.onSuffix,
      this.showSuffix = false,
      this.outLabel = true,
      this.background = false,
      this.focus,
      this.hint,
      this.icon,
      this.maxLength,
      this.color,
      this.isDense,
      this.maxLines,
      this.enabled = true,
      this.obscureText = false,
      this.hideCount = true,
      this.outValidate,
      this.isRequired = true,
      this.defaultValue,
      this.margin = 10,
      this.minLines = 1,
      this.isForm = false,
      this.labelSize}) : super(key: key);

  CustomTextField.form({Key? key,
      this.label,
      this.border = false,
      required this.controller,
      this.onSubmitted,
      this.format,
      this.type = formType.any,
      this.onSuffix,
      this.onChange,
      this.showSuffix = false,
      this.outLabel = true,
      this.background = false,
      this.color,
      this.focus,
      this.isDense,
      this.maxLines,
      this.maxLength,
      this.hint,
      this.icon,
      this.enabled = true,
      this.obscureText = false,
      this.hideCount = true,
      this.outValidate,
      this.defaultValue,
      this.isRequired = true,
      this.margin = 10,
      this.minLines = 1,
      this.isForm = true,
      this.labelSize}) : super(key: key);

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(this.obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  _CustomTextFieldState(this.passVisible);

  int lastEditTimeStamp = 0;
  bool? passVisible;

  bool? obscureText;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatter;
  int? maxLength;
  int? maxLines;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? counterText;
  TextStyle? counterStyle;
  Function? onSubmitted;

  Color? get color => widget.color;


  _init() {
    obscureText = TextFieldSupport.PASS_TYPE_LIST.contains(widget.type)
        ? passVisible
        : false;

    keyboardType ??= TextFieldSupport.getInputType(
        type: widget.type);

    inputFormatter ??= TextFieldSupport.getInputFormatter(
        format: widget.format,
        type: widget.type);

    maxLength ??= (widget.maxLength
        ?? TextFieldSupport.getMaxLength(type: widget.type));

    maxLines ??= TextFieldSupport.getMaxLine(type: widget.type);

    hintText ??= widget.hint ?? '';

    prefixIcon ??= TextFieldSupport.getPrefix(
        icon: widget.icon,
        color: color);

    suffixIcon = widget.showSuffix
        ? TextFieldSupport.getSuffix(
            type: widget.type,
            obscureText: obscureText!,
            onSuffix: (b) async{
              if (TextFieldSupport.PASS_TYPE_LIST.contains(widget.type)) {
                setState(() {
                  passVisible = b;
                });
              }

              if(widget.enabled){
                if (widget.onSuffix != null) {
                  widget.onSuffix!(b);

                }

                if(widget.onEndChanged != null) {
                  widget.onEndChanged!(widget.controller.text);

                }
              }
            },
            onChange: widget.onChange,
            defaultV: widget.defaultValue,
            controller: widget.controller)
        : null;

    counterText ??= widget.hideCount ? '' : null;

    counterStyle ??= widget.hideCount
        ? const TextStyle(fontSize: 0) : null;

    onSubmitted ??= (){
      if(widget.onSubmitted != null) {
        widget.onSubmitted!();

      }
    };
  }

  String? outValidate(String v) => widget.outValidate != null
        ? widget.outValidate!(v) : null;

  Widget getWidget() {
    final decoration = InputDecoration(
        floatingLabelBehavior: widget.outLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        hintText: hintText,
        hintStyle: TextStyle(
            color: color,
            fontSize: 12),
        labelText: widget.label,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color),
        fillColor: widget.background
            ? Colors.white
            : null,
        errorMaxLines: 4,
        errorStyle: const TextStyle(
            overflow: TextOverflow.clip),
        suffixIcon: suffixIcon,
        border: widget.border
            ? OutlineInputBorder(
                borderSide: BorderSide(color: color ?? Colors.black87),
                borderRadius: BorderRadius.circular(18))
            : null,
        focusedBorder: widget.border
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: color ?? Colors.black87))
          : UnderlineInputBorder(
              borderSide: BorderSide(color: color ?? Colors.black87)),
        contentPadding: EdgeInsets.only(
            bottom: widget.border
                ? 5 : 0,
            right: widget.border
                ? 15 : 5,
            left: widget.border
                ? 15 : 5,
            top: 0),
        isDense: widget.isDense,
        counterText: counterText,
        counterStyle: counterStyle);

    if (widget.isForm) {
      return TextFormField(
          // scrollPhysics: NeverScrollableScrollPhysics(),
          textCapitalization: TextCapitalization.sentences,
          controller: widget.controller,
          obscureText: obscureText!,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          readOnly: !widget.enabled,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? widget.minLines,
          decoration: decoration,
          autofocus: false,
          focusNode: widget.focus,
          style: TextStyle(color: color),
          onChanged: (v) {
            if (widget.onEndChanged != null) {
              lastEditTimeStamp = DateTime.now().millisecondsSinceEpoch;
              Future.delayed(const Duration(milliseconds: 500)).then((_) {
                if ((lastEditTimeStamp + 400) <= DateTime.now().millisecondsSinceEpoch) {
                  widget.onEndChanged!(v);

                }
              });
            }

            if(widget.onChange != null) {
              widget.onChange!(v);

            }
          },
          validator: (text) {
            if (!widget.isRequired && (text == null || text.isEmpty)) {
              text = 'Não informado';

            }

            if (text == null || text.isEmpty) {
              return 'Não informado';
            } else if (widget.type == formType.password) {
              return TextValidate.passwordField(text) ?? outValidate(text);
            } else if (widget.type == formType.phone) {
              return TextValidate.phoneField(text) ?? outValidate(text);
            } else if (widget.type == formType.cellPhone) {
              return TextValidate.cellPhoneField(text) ?? outValidate(text);
            } else if (widget.type == formType.email) {
              return TextValidate.emailField(text) ?? outValidate(text);
            }

            return outValidate(text);
          },
          onFieldSubmitted: (term) => onSubmitted!());

    } else {
      final _controller = ScrollController();

      return TextField(
          textCapitalization: TextCapitalization.sentences,
          onEditingComplete: () => onSubmitted!(),
          textInputAction: TextInputAction.next,
          inputFormatters: inputFormatter,
          scrollController: _controller,
          controller: widget.controller,
          keyboardType: keyboardType,
          readOnly: !widget.enabled,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? widget.minLines,
          obscureText: obscureText!,
          decoration: decoration,
          maxLength: maxLength,
          focusNode: widget.focus,
          autofocus: false,
          style: TextStyle(
              color: color),
          onChanged: (v) {
            if (widget.onEndChanged != null) {
              lastEditTimeStamp = DateTime.now().millisecondsSinceEpoch;
              Future.delayed(const Duration(milliseconds: 500)).then((_) {
                if ((lastEditTimeStamp + 400) <= DateTime.now().millisecondsSinceEpoch) {
                  widget.onEndChanged!(v);
                }

              });
            }

            if(widget.onChange != null) {
              widget.onChange!(v);

            }
          });
    }
  }

  @override
  void initState() {
    super.initState();
    if(TextFieldSupport.PASS_TYPE_LIST.contains(widget.type)) {
      passVisible = true;

    }
  }

  @override
  Widget build(BuildContext context) {
    _init();

    return Container(
        margin: EdgeInsets.only(
          bottom: widget.margin),
        child: getWidget());
  }
}
