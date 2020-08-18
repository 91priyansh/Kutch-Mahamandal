import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kutchmahamandalbhav/models/product.dart';

class Report {
  final Timestamp timestamp;
  final List<Product> products;

  Report({this.products, this.timestamp});

  static Report fromJson(Map<String, dynamic> reportJson) {
    List list = reportJson['products'];
    return Report(
        products: list
            .map((e) => Product(name: e['product'], price: e['price']))
            .toList(),
        timestamp: reportJson['timestamp']);
  }
}
