import 'package:flutter/material.dart';
import 'package:todo_application/screens/order_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userTextFormField = TextEditingController();
  TextEditingController _passTextFormField = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Center(
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Đăng nhập',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.person),
                              labelText: "Tài khoản",
                              labelStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32))),
                          controller: _userTextFormField,
                          validator: (input) => input.trim().isEmpty
                              ? "Không được để trống"
                              : null,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.lock),
                              labelText: "Mật khẩu",
                              labelStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32))),
                          controller: _passTextFormField,
                          validator: (input) => input.trim().isEmpty
                              ? "Không được để trống"
                              : null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            if (_userTextFormField.text == 'admin' &&
                                _passTextFormField.text == 'admin') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ));
                            }
                          }
                        },
                        child: Text("Đăng nhập ")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
