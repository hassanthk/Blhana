import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.quantity,
    required this.deleteItem,
    required this.decreseItem,
    required this.increseItem,
  });
  final String img;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback? deleteItem;
  final VoidCallback? decreseItem;
  final VoidCallback? increseItem;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.008,
        vertical: size.height * 0.006,
      ),
      child: Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(width: size.width * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
                vertical: 4.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  '$img',
                  width: size.width * 0.25,
                  height: size.height * 0.1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '$price',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: size.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: increseItem,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: size.width * 0.05,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: decreseItem,
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: IconButton(
                onPressed: deleteItem,
                icon: Icon(
                  Icons.delete_outline,
                  size: size.width * 0.06,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
