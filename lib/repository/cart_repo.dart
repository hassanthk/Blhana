import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/models/cartItems_model.dart';
import '/models/products_model.dart';

class CartRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<CartItem>> getCartItems() async {
    final user = _auth.currentUser;
    if (user == null) return [];
    final snapshot =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();

    if (snapshot.docs.where((doc) => doc.id != 'init').isEmpty) {
      return [];
    }
    return snapshot.docs
        .where((doc) => doc.id != 'init')
        .map(
          (doc) => CartItem(
            product: ProductsModel(
              title: doc['title'],
              price: doc['price'],
              image:
                  'assets/images/${doc['category']}/${doc['title'].toString().toLowerCase()}.jpg',
              category: doc['category'],
            ),
            quantity: doc['quantity'],
          ),
        )
        .toList();
  }

  Future<void> addToCart(ProductsModel product, int quantity) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final cartRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product.title);

    final doc = await cartRef.get();

    if (doc.exists) {
      await cartRef.update({'quantity': doc['quantity'] + quantity});
    } else {
      await cartRef.set({
        'title': product.title,
        'price': product.price,
        'category': product.category,
        'quantity': quantity,
      });
    }
  }

  Future<void> removeFromCart(ProductsModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product.title)
        .delete();
  }

  Future<void> increaseQuantity(ProductsModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product.title);
    await docRef.update({'quantity': FieldValue.increment(1)});
  }

  Future<void> decreaseQuantity(ProductsModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product.title);
    final doc = await docRef.get();
    if (doc.exists && doc['quantity'] > 1) {
      await docRef.update({'quantity': FieldValue.increment(-1)});
    } else {
      await docRef.delete();
    }
  }

  Future<void> clearCart() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final snapshot =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<double> getTotalPrice() async {
    final user = _auth.currentUser;
    if (user == null) return 0.0;
    final snapshot =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();

    double total = 0;
    if (snapshot.docs.where((doc) => doc.id != 'init').isEmpty) {
      return total;
    }
    for (var doc in snapshot.docs) {
      if (doc.id == 'init') continue;
      total += doc['price'] * doc['quantity'];
    }
    return total;
  }

  Future<int> getTotalQuantity() async {
    final user = _auth.currentUser;
    if (user == null) return 0;
    final snapshot =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();

    int totalQuantity = 0;
    if (snapshot.docs.where((doc) => doc.id != 'init').isEmpty) {
      return totalQuantity;
    }
    for (var doc in snapshot.docs) {
      if (doc.id == 'init') continue;
      totalQuantity += (doc['quantity'] as num).toInt();
    }
    return totalQuantity;
  }
}
