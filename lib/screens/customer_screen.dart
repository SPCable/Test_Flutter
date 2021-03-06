import 'package:flutter/material.dart';
import 'package:todo_application/models/customer.dart';
import 'package:todo_application/services/customer_service.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

final _key = GlobalKey<FormState>();
TextEditingController _nameTextFormField = TextEditingController();
TextEditingController _phoneTextFormField = TextEditingController();
TextEditingController _emailTextFormField = TextEditingController();
TextEditingController _addressTextFormField = TextEditingController();

class _CustomerScreenState extends State<CustomerScreen> {
  CustomerService customerService = CustomerService();
  List<Customer> customerList = [];
  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    customerList = await customerService.getList();

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
                                  Customer customer = new Customer(
                                      name: _nameTextFormField.text,
                                      address: _addressTextFormField.text,
                                      email: _emailTextFormField.text,
                                      phone: _phoneTextFormField.text);

                                  customerService.addItemList(customer);
                                  _fetchData();
                                  Navigator.pop(context);
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text("Th??m "))
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
                                    'Th??ng tin kh??ch h??ng',
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
                                      suffixIcon: Icon(Icons.person),
                                      labelText: "H??? v?? t??n",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _nameTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Kh??ng ???????c ????? tr???ng"
                                      : null,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.phone),
                                      labelText: "S??? ??i???n tho???i",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _phoneTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Kh??ng ???????c ????? tr???ng"
                                      : null,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.email),
                                      labelText: "Email",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _emailTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Kh??ng ???????c ????? tr???ng"
                                      : null,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.house),
                                      labelText: "?????a ch???",
                                      labelStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32))),
                                  controller: _addressTextFormField,
                                  validator: (input) => input.trim().isEmpty
                                      ? "Kh??ng ???????c ????? tr???ng"
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
              label: Text('Th??m kh??ch h??ng'))
        ],
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: Icon(Icons.person),
                    onTap: () {},
                    title: Text(customerList[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(customerList[index].email),
                        Text(customerList[index].phone),
                      ],
                    ),
                  );
                },
              ));
  }
}
