import 'dart:core';
import 'package:todo_application/models/product.dart';
import 'package:todo_application/repositories/repostitory.dart';

class ProductService {
  Repository _repository;
  List<Product> products = [];
  ProductService() {
    _repository = Repository();
  }

  Future<List<Map<String, dynamic>>> getMapList() async {
    final List<Map<String, dynamic>> result =
        await _repository.readData('Product');
    return result;
  }

  Future<List<Product>> getList() async {
    final List<Map<String, dynamic>> mapList = await getMapList();
    final List<Product> list = [];
    mapList.forEach((element) {
      list.add(Product.fromJson(element));
    });
    return list;
  }

  Future<void> addItemList(Product product) async {
    return await _repository.insertData('Product', product.toMap());
  }

  Future<void> readList() async {
    return await _repository.readData('Product');
  }

  Future<void> deleteList() async {
    return await _repository.deleteData('Product');
  }

  Future<void> updateList(int id, Product product) async {
    return await _repository.updateData('Product', id, product.toMap());
  }

  Future<Product> getOne(int id) async {
    return await _repository.readOneData('Product', id);
  }
}
