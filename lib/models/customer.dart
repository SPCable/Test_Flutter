class Customer {
  int id;
  String name;
  String email;
  String address;
  String phone;
  Customer.withId({this.id, this.name, this.email, this.address, this.phone});
  Customer({this.name, this.email, this.address, this.phone, int id});

  Map<String, dynamic> customerMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['email'] = email;
    mapping['address'] = address;
    mapping['phone'] = phone;
    return mapping;
  }

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer.withId(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        address: map['address'],
        phone: map['phone']);
  }
}
