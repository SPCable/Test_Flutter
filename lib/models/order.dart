class Order {
  int id;
  int idCustomer;
  int idProduct;
  Order.withId({this.id, this.idCustomer, this.idProduct});
  Order({this.idCustomer, this.idProduct});

  Map<String, dynamic> orderMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['idCustomer'] = idCustomer;
    mapping['idProduct'] = idProduct;
    return mapping;
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order.withId(
      id: map['id'],
      idCustomer: map['idCustomer'],
      idProduct: map['idProduct'],
    );
  }
}
