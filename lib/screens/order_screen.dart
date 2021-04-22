import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/models/customer.dart';
import 'package:todo_application/models/order.dart';
import 'package:todo_application/models/product.dart';
import 'package:todo_application/screens/add%20invoice_screen.dart';
import 'package:todo_application/screens/customer_screen.dart';
import 'package:todo_application/screens/order_detail.dart';
import 'package:todo_application/screens/product_screen.dart';
import 'package:todo_application/services/customer_service.dart';
import 'package:todo_application/services/order_service.dart';
import 'package:todo_application/services/product_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Order> orders = [];
  List<Product> products = [];
  List<Customer> customers = [];
  bool value = false;
  bool isLoading = false;
  final title = "Danh sách đơn hàng";
  final title1 = "Danh sách khách hàng";
  final title2 = "Danh sách sản phẩm";

  var orderService = OrderService();
  var customerService = CustomerService();
  var productService = ProductService();

  void deleteData() async {
    orderService.deleteList();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    orders = await orderService.getOrderList();
    customers = await customerService.getList();
    products = await productService.getList();

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
        title: (_currentIndex == 2)
            ? Text(title1)
            : (_currentIndex == 1)  
                ? Text(title2)
                : Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: (_currentIndex == 2)
            ? CustomerScreen()
            : (_currentIndex == 1)
                ? ProductScreen()
                : (isLoading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scaffold(
                        body: (isLoading)
                            ? Center(child: CircularProgressIndicator())
                            : (orders.length == 0)
                                ? Center(
                                    child: Text("Chưa có hóa đơn"),
                                  )
                                : ListView.builder(
                                    itemCount: orders.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetail(
                                                  callback: () {
                                                    _fetchData();
                                                  },
                                                  id: orders[index].id,
                                                ),
                                              ));
                                        },
                                        title: Text("Đơn hàng mã: " +
                                            orders[index].id.toString()),
                                        subtitle: getInfo(orders[index].id),
                                      );
                                    },
                                  ),
                        floatingActionButton: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddInvoice(
                                      callback: () {
                                        _fetchData();
                                      },
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.add),
                            label: Text("Tạo hóa đơn")),
                      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Đơn hàng"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_sharp), label: "Sản phẩm"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Khách hàng"),
        ],
      ),
    );
  }

  Widget getInfo(int id) {
    String name, namePro;
    orders.forEach((order) {
      if (id == order.id) {
        customers.forEach((customer) {
          if (order.idCustomer == customer.id) {
            name = customer.name;
            products.forEach((product) {
              if (order.idProduct == product.id) {
                namePro = product.name;
              }
            });
          }
        });
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text(name), Text(namePro)],
    );
  }
}
