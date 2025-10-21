import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/products_model.dart';

class ProductsRepo {
  final _firestore = FirebaseFirestore.instance;

  Future<List<ProductsModel>> fetchProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs
        .map((doc) => ProductsModel.fromMap(doc.data()))
        .toList();
  }
}
