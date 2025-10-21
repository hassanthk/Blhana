import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final Function ontap;
  final bool is_selected;
  CategoryButton({
    required this.name,
    required this.ontap,
    required this.is_selected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: is_selected ? Color(0xFF056608) : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),

        child: Center(child: Text(name, style: TextStyle(color: Colors.white))),
      ),
    );
  }
}
