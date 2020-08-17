import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/bloc/core.bloc.dart';
import 'package:flutter_test_task/entity/employee.dart';
import 'package:flutter_test_task/page/employee.page.dart';
import 'package:flutter_test_task/page/widget/employee_tile.dart';

import 'create_person.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoreBloc bloc;

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('WorkerList')),
      body: StreamBuilder<List<Employee>>(
          stream: bloc.employees.stream,
          builder: (context, snapshot) {
            List<Employee> employees = snapshot?.data ?? [];
            return ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (_, __) => Container(
                      height: 10,
                    ),
                itemCount: employees.length,
                itemBuilder: (_, index) => EmployeeTile(
                      employee: employees[index],
                      onTap: () => openEmployeePage(employees[index]),
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addEmployee,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void addEmployee() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (_) => CreatePersonPage(
              createEmployee: true,
            )));
  }

  void openEmployeePage(Employee emp) async {
    bloc.openEmployee(emp.id);
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => EmployeePage()));
    bloc.resetEmployee();
  }

  void initBloc() {
    bloc = BlocProvider.of<CoreBloc>(context);
  }
}
