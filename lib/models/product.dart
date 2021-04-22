class Product {
  int id;
  String name;
  String price;
  Product.withId({this.id, this.name, this.price});
  Product({this.name, this.price});

  Map<String, dynamic> toMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['price'] = price;

    return mapping;
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product.withId(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }
}
