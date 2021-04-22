import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_application/models/customer.dart';
import 'package:todo_application/models/order.dart';
import 'package:todo_application/models/product.dart';
import 'package:todo_application/services/customer_service.dart';
import 'package:todo_application/services/order_service.dart';
import 'package:todo_application/services/product_service.dart';

class AddInvoice extends StatefulWidget {
  final VoidCallback callback;

  AddInvoice({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPageState(callback);
}

final _key = GlobalKey<FormState>();

class _AddPageState extends State<AddInvoice> {
  final VoidCallback callback;

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

  Order order = new Order();
  bool isLoading = false;

  _AddPageState(this.callback);

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    customers = await _customerService.getList();
    products = await _productService.getList();

    setState(() {
      isLoading = false;
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
          title: Text('Tạo đơn hàng mới'),
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
                      Expanded(
                          child: ElevatedButton(
                        child: Text("Thêm khách hàng"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return (isLoading)
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Scaffold(
                                      body: ListView.builder(
                                        itemCount: customers.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () {
                                              _nameTextFormField.text =
                                                  customers[index].name;
                                              _phoneTextFormField.text =
                                                  customers[index].phone;
                                              _emailTextFormField.text =
                                                  customers[index].email;
                                              _addressTextFormField.text =
                                                  customers[index].address;

                                              order.idCustomer =
                                                  customers[index].id;

                                              Navigator.pop(context);
                                            },
                                            title: Text(customers[index].name),
                                          );
                                        },
                                      ),
                                    );
                            },
                          );
                        },
                      )),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _fetchData();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Scaffold(
                                  body: ListView.builder(
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          _nameProduct.text =
                                              products[index].name;
                                          _priceProduct.text =
                                              products[index].price;

                                          order.idProduct = products[index].id;

                                          Navigator.pop(context);
                                        },
                                        title: Text(products[index].name),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text("Thêm sản phẩm"),
                        ),
                      ),
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
                  ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        bool flag;
                        customers.forEach((element) {
                          if (element.phone == _phoneTextFormField.text) {
                            flag = true;
                          }
                        });

                        if (flag == true) {
                          _orderService.addItemList(order);
                        } else {
                          Customer customer = new Customer.withId(
                              id: Random().nextInt(1000),
                              name: _nameTextFormField.text,
                              address: _addressTextFormField.text,
                              email: _emailTextFormField.text,
                              phone: _phoneTextFormField.text);
                          _customerService.addItemList(customer);
                          order.idCustomer = customer.id;
                          _orderService.addItemList(order);
                        }

                        callback();
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Tạo"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
