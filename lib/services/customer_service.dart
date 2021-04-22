import 'dart:core';
import 'package:todo_application/models/customer.dart';
import 'package:todo_application/repositories/repostitory.dart';

class CustomerService {
  Repository _repository;
  List<Customer> customers = [];
  CustomerService() {
    _repository = Repository();
  }

  Future<List<Map<String, dynamic>>> getCustomerMapList() async {
    final List<Map<String, dynamic>> result =
        await _repository.readData('Customer');
    return result;
  }

  Future<List<Customer>> getList() async {
    final List<Map<String, dynamic>> customerMapList =
        await getCustomerMapList();
    final List<Customer> customerList = [];
    customerMapList.forEach((element) {
      customerList.add(Customer.fromJson(element));
    });
    return customerList;
  }

  Future<void> addItemList(Customer customer) async {
    return await _repository.insertData('Customer', customer.customerMap());
  }

  Future<void> readList() async {
    return await _repository.readData('Customer');
  }

  Future<void> deleteList() async {
    return await _repository.deleteData('Customer');
  }

  Future<void> updateList(int id, Customer customer) async {
    return await _repository.updateData('Customer', id, customer.customerMap());
  }

  Future<void> getOne(int id) async {
    return await _repository.readOneData('Customer', id);
  }
}
