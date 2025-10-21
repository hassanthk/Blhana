import 'package:flutter/material.dart';

class ProductsTile extends StatelessWidget {
  const ProductsTile({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price, required this.Onpressed,
  });
  final VoidCallback? Onpressed;
  final double price;
  final String imgPath;
  final String name;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imgPath,
                width: size.width * 0.4,
                height: size.height * 0.17,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              name,
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: size.width * 0.02),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),

                  Container(
                    width: size.width * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xFF056608),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: size.width * 0.04,
                        icon: Icon(Icons.shopping_bag_outlined),
                        color: Colors.white,
                        onPressed: Onpressed,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
