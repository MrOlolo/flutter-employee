import 'dart:async';
import 'dart:io';

import 'package:flutter_test_task/entity/child.dart';
import 'package:flutter_test_task/entity/employee.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS employee ("
          "id INTEGER PRIMARY KEY autoincrement,"
          "name TEXT,"
          "surname TEXT,"
          "patronymic TEXT,"
          "dob TEXT,"
          "position TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS child ("
          "id INTEGER PRIMARY KEY autoincrement,"
          "name TEXT,"
          "surname TEXT,"
          "patronymic TEXT,"
          "dob TEXT,"
          "parentId INTEGER,"
          "FOREIGN KEY (parentId) REFERENCES employee(id)"
          ")");
    });
  }

  newEmployee(Employee employee) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into employee (name, surname, patronymic, dob, position)"
        " VALUES (?,?,?,?,?)",
        [
          employee.name,
          employee.surname,
          employee.patronymic,
          employee.dob,
          employee.position
        ]);
    return raw;
  }

  newChild(Child child) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into child (name, surname, patronymic, dob, parentId)"
        " VALUES (?,?,?,?,?)",
        [
          child.name,
          child.surname,
          child.patronymic,
          child.dob,
          child.parentId
        ]);
    return raw;
  }

  getChildrenByParentId(int parentId) async {
    final db = await database;
    var res =
        await db.query("Child", where: "parentId = ?", whereArgs: [parentId]);
    List<Child> list =
        res.isNotEmpty ? res.map((c) => Child.fromJson(c)).toList() : [];
    return list;
  }

  getEmployeesWithChildrenCount() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT employee.id, employee.name, employee.surname, employee.patronymic,"
        "employee.dob, employee.position, count(child.name) as amount "
        "FROM employee "
        "LEFT JOIN child on employee.id = child.parentId "
        "GROUP BY employee.id");
    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    var res = await db.query("employee");
    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Child>> getAllChildren() async {
    final db = await database;
    var res = await db.query("child");
    List<Child> list =
        res.isNotEmpty ? res.map((c) => Child.fromJson(c)).toList() : [];
    return list;
  }
}
