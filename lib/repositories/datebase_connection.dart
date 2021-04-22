import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'Database4');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE Customer(id integer primary key AUTOINCREMENT, name Text, email TEXT, address TEXT, phone TEXT )");
    await database.execute(
        "CREATE TABLE Product(id integer primary key AUTOINCREMENT, name Text, price TEXT)");
    await database.execute(
        "CREATE TABLE OrderList(id integer primary key AUTOINCREMENT, idCustomer integer, idProduct integer)");
  }
}
