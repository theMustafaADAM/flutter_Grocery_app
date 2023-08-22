// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';
import 'package:flutter_ecommerce_app/model/product.dart';

class LocalProductService {
  late Box<Product> _popularProductBox;

  Future<void> init() async {
    _popularProductBox = await Hive.openBox<Product>('PopularProducts');
  }

  Future<void> assignAllPopularProducts(List<Product> popularProductListFromJson, {required List<Product> popularProducts}) async {
    await _popularProductBox.clear();
    await _popularProductBox.addAll(popularProducts);
  }

  List<Product> getPopularProducts() => _popularProductBox.values.toList();
}