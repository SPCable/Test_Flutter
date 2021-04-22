import 'dart:core';
import 'package:todo_application/models/order.dart';
import 'package:todo_application/repositories/repostitory.dart';

class OrderService {
  Repository _repository;
  List<Order> orders = [];
  OrderService() {
    _repository = Repository();
  }

  Future<List<Map<String, dynamic>>> getOrderMapList() async {
    final List<Map<String, dynamic>> result =
        await _repository.readData('OrderList');
    return result;
  }

  Future<List<Order>> getOrderList() async {
    final List<Map<String, dynamic>> orderMapList = await getOrderMapList();
    final List<Order> orderList = [];
    orderMapList.forEach((element) {
      orderList.add(Order.fromJson(element));
    });
    return orderList;
  }

  Future<void> addItemList(Order order) async {
    return await _repository.insertData('OrderList', order.orderMap());
  }

  Future<void> readList() async {
    return await _repository.readData('OrderList');
  }

  Future<void> deleteList() async {
    return await _repository.deleteData('OrderList');
  }

  Future<void> updateList(int id, Order order) async {
    return await _repository.updateData('OrderList', id, order.orderMap());
  }

  Future<void> getOne(int id) async {
    return await _repository.readOneData('OrderList', id);
  }

  Future<void> deleteItem(int id) async {
    return await _repository.deleteOneData('OrderList', id);
  }
}
