import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String title;

  @HiveField(1)
  double sellPrice;

  @HiveField(2)
  final int id;

  @HiveField(3)
  String sku;

  @HiveField(4)
  int qty;

  @HiveField(5)
  double finalPrice;

  @HiveField(6)
  double total;

  @HiveField(7)
  String image;

  int? key;
  Product({
    required this.title,
    required this.sellPrice,
    required this.id,
    required this.sku,
    required this.qty,
    required this.total,
    required this.finalPrice,
    required this.image,
    this.key,
  }) ;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        sku: json['sku'],
        title: json['title'],
        sellPrice: double.parse(json['sell_price']),
        qty: 1,
        total: double.parse(json['final_price']),
        finalPrice: double.parse(json['final_price']),
        image: json['image']
    );
  }
}