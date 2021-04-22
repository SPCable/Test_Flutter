import 'package:flutter/material.dart';
import 'package:todo_application/models/customer.dart';
import 'package:todo_application/models/order.dart';
import 'package:todo_application/models/product.dart';
import 'package:todo_application/services/customer_service.dart';
import 'package:todo_application/services/order_service.dart';
import 'package:todo_application/services/product_service.dart';

class OrderDetail extends StatefulWidget {
  final VoidCallback callback;
  final int id;

  OrderDetail({Key key, @required this.callback, @required this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderDetailState(callback, id);
}

class _OrderDetailState extends State<OrderDetail> {
  final VoidCallback callback;
  final int id;
  final _key = GlobalKey<FormState>();

  TextEditingController _nameTextFormField = TextEditingController();
  TextEditingController _emailTextFormField = TextEditingController();
  TextEditingController _phoneTextFormField = TextEditingController();
  TextEditingController _addressTextFormField = TextEditingController();
  TextEditingController _nameProduct = TextEditingController();
  TextEditingController _priceProduct = TextEditingController();

  OrderService _orderService = OrderService();
  CustomerService _customerService = CustomerService();
  ProductService _productService = ProductService();

  List<Customer> customers = [];
  List<Product> products = [];
  List<Order> orders = [];

  Order order = new Order();

  _OrderDetailState(this.callback, this.id);

  _fetchData() async {
    customers = await _customerService.getList();
    products = await _productService.getList();
    orders = await _orderService.getOrderList();

    orders.forEach((o) {
      if (id == o.id) {
        customers.forEach((element) {
          if (element.id == o.idCustomer) {
            _nameTextFormField.text = element.name;
            _phoneTextFormField.text = element.phone;
            _emailTextFormField.text = element.email;
            _addressTextFormField.text = element.address;
          }
        });

        products.forEach((element) {
          if (element.id == o.idProduct) {
            _nameProduct.text = element.name;
            _priceProduct.text = element.price;
          }
        });
      }
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Chi tiết đơn hàng'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Thông tin khách hàng',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        labelText: "Họ và tên",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _nameTextFormField,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone),
                        labelText: "Số điện thoại",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _phoneTextFormField,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _emailTextFormField,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),      
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.house),
                        labelText: "Địa chỉ",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _addressTextFormField,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Thông tin sản phẩm',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelText: "Tên sản phẩm",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _nameProduct,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelText: "Giá",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                    controller: _priceProduct,
                    validator: (input) =>
                        input.trim().isEmpty ? "Không được để trống" : null,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print(id);
                          _orderService.deleteItem(id);
                          callback();
                          Navigator.pop(context);
                        },
                        child: Text("Xóa"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
