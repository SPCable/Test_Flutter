import 'package:flutter/material.dart';
import 'package:todo_application/models/product.dart';
import 'package:todo_application/services/product_service.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

TextEditingController _nameTextFormField = TextEditingController();
TextEditingController _priceTextFormField = TextEditingController();
final _key = GlobalKey<FormState>();

class _ProductScreenState extends State<ProductScreen> {
  ProductService productService = ProductService();
  List<Product> productList = [];
  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    productList = await productService.getList();

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
        persistentFooterButtons: [
          ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        actions: [
                          ElevatedButton.icon(
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  Product product = new Product(
                                    name: _nameTextFormField.text,
                                    price: _priceTextFormField.text,
                                  );

                                  productService.addItemList(product);
                                  _fetchData();
                                  Navigator.pop(context);
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text("Thêm "))
                        ],
                        content: SingleChildScrollView(
                            child: ListBody(children: <Widget>[
                          Form(
                            key: _key,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Thông tin sản phẩm',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.add_shopping_cart),
                                      labelText: "Tên sản phẩm",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _nameTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Không được để trống"
                                      : null,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.monetization_on),
                                      labelText: "Giá",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _priceTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Không được để trống"
                                      : null,
                                ),
                              ],
                            ),
                          )
                        
                        ])));
                  },
                );
              },
              icon: Icon(Icons.add),
              label: Text('Thêm sản phẩm'))
        ],
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(productList[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(productList[index].price),
                      ],
                    ),
                  );
                },
              ));
  }
}
