import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController con;
  final double width;

  final bool isPassword;
  final String? Function(String)? validator;

  const MyTextField({
    super.key,
    required this.con,
    required this.width,

    this.isPassword = false,
    this.validator,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.con,
        obscureText: widget.isPassword && _obscure,
        style: const TextStyle(color: Colors.white),
        validator: (val) => widget.validator?.call(val ?? ''),
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.redAccent, width: 3),
          ),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                  : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 3),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
        ),
      ),
    );
  }
}
