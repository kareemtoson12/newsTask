import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String? labelText;
  final Widget? label;
  final String fieldNameForValidation;
  final bool isPassword;
  final bool isWide;

  const AuthTextField({
    super.key,
    this.labelText,
    this.label,
    required this.fieldNameForValidation,
    this.isPassword = false,
    required this.isWide,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  OutlineInputBorder get _enabledBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  OutlineInputBorder get _focusedBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.labelText,
        label: widget.label,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: widget.isWide ? 18 : 12,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.fieldNameForValidation} is required";
        }
        return null;
      },
    );
  }
}
