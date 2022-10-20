import 'dart:io';

import 'package:data_order_thriftshop/models/transaksi_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String databaseName = "kelola_duit.db";
  final int databaseVersion = 3;

  // Atribut di Model Transaksi
  final String namaTabel = 'transaksi';
  final String id = 'id';
  final String type = 'type';
  final String total = 'total';
  final String totalHarga = 'totalHarga';
  final String name = 'name';
  final String barang = 'barang';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    print('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("_onCreate");
    await db.execute(
        'CREATE TABLE ${namaTabel} ($id INTEGER PRIMARY KEY, $name TEXT NULL, $barang TEXT NULL, $type INTEGER, $total INTEGER, $totalHarga INTEGER, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<TransaksiModel>> getAll() async {
    final data = await _database!.query(namaTabel);
    List<TransaksiModel> result =
        data.map((e) => TransaksiModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(namaTabel, row);
    return query;
  }

  Future<int> totalOrder() async {
    final query = await _database!
        .rawQuery("SELECT SUM(total) as total FROM ${namaTabel}");
    return int.parse(query.first['total'].toString());
  }

  Future<int> totalDuit() async {
    final query = await _database!
        .rawQuery("SELECT SUM(totalHarga) as totalHarga FROM ${namaTabel}");
    return int.parse(query.first['totalHarga'].toString());
  }

  Future<int> hapus(idTransaksi) async {
    final query = await _database!
        .delete(namaTabel, where: '$id = ?', whereArgs: [idTransaksi]);
    return query;
  }

  Future<int> update(int idTransaksi, Map<String, dynamic> row) async {
    final query = await _database!
        .update(namaTabel, row, where: '$id = ?', whereArgs: [idTransaksi]);
    return query;
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
