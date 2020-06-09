import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter_test_task/database/db_provider.dart';
import 'package:flutter_test_task/entity/child.dart';
import 'package:flutter_test_task/entity/employee.dart';
import 'package:rxdart/rxdart.dart';

class CoreBloc extends Bloc {
  int _currentEmployeeId;

  BehaviorSubject<List<Employee>> employees = BehaviorSubject();
  BehaviorSubject<Employee> currentEmployee = BehaviorSubject();
  BehaviorSubject<List<Child>> employeeChildren = BehaviorSubject();

  CoreBloc() {
    _currentEmployeeId = 0;
    updateEmployees();
  }

  @override
  void dispose() {
    employees?.close();
    employeeChildren?.close();
    currentEmployee?.close();
  }

  void updateEmployeeChildren() async {
    if (_currentEmployeeId != 0) {
      employeeChildren
          .add(await DBProvider.db.getChildrenByParentId(_currentEmployeeId));
    }
  }

  void updateEmployees() async {
    employees.add(await DBProvider.db.getEmployeesWithChildrenCount());
  }

  void updateCurrentEmployee() {
    if (_currentEmployeeId != 0) {
      currentEmployee.add(employees.value
          .singleWhere((element) => element.id == _currentEmployeeId));
    }
  }

  addEmployee(Employee employee) async {
    await DBProvider.db.newEmployee(employee);
    updateEmployees();
  }

  addChild(Child child) async {
    await DBProvider.db.newChild(child);
    updateEmployeeChildren();
    updateEmployees();
    updateCurrentEmployee();
  }

  openEmployee(int employeeId) {
    _currentEmployeeId = employeeId;
    updateCurrentEmployee();
    updateEmployeeChildren();
  }

  resetEmployee() {
    _currentEmployeeId = 0;
  }
}
