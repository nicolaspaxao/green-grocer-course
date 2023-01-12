import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool? isReadOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final GlobalKey<FormFieldState>? formFieldKey;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.isReadOnly = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.keyboardType,
    this.formFieldKey,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        initialValue: widget.initialValue,
        readOnly: widget.isReadOnly!,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          focusColor: Colors.green,
          prefixIcon: Icon(widget.icon),
        ),
      ),
    );
  }
}
