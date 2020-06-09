import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/bloc/core.bloc.dart';
import 'package:flutter_test_task/entity/child.dart';
import 'package:flutter_test_task/entity/employee.dart';
import 'package:flutter_test_task/page/create_person.page.dart';
import 'package:flutter_test_task/page/widget/child_tile.dart';
import 'package:flutter_test_task/page/widget/loading_container.dart';

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  CoreBloc bloc;

  void initBloc() {
    bloc = BlocProvider.of<CoreBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool horizontalOrientation = width > height;
    var body = (employee) => <Widget>[
          Container(
            height: horizontalOrientation ? height : 230,
            width: horizontalOrientation ? width / 2.4 : width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 24,
                ),
                Center(
                  child: Icon(
                    employee.childrenAmount == 0
                        ? Icons.person
                        : Icons.supervisor_account,
                    size: horizontalOrientation ? 70 : 100,
                  ),
                ),
                Text(
                  employee.position,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  "${employee.surname} "
                  "${employee.name} "
                  "${employee?.patronymic ?? ''}",
                  style: TextStyle(fontSize: 18),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 10,
                ),
                Text(
                  employee.dob,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                if (!horizontalOrientation)
                  Divider(
                    height: 30,
                    thickness: 1,
                  )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Дети',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: openAddChildPage,
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Child>>(
                      stream: bloc.employeeChildren.stream,
                      builder: (context, snapshot) {
                        List<Child> children = snapshot?.data ?? [];
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (_, index) => ChildTile(
                                  child: children[index],
                                ),
                            separatorBuilder: (_, __) => Container(
                                  height: 10,
                                ),
                            itemCount: children.length);
                      }),
                ),
              ],
            ),
          )
        ];
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<Employee>(
              stream: bloc.currentEmployee.stream,
              builder: (context, snapshot) {
                Employee employee = snapshot?.data ?? null;
                if (employee == null) {
                  return Center(
                    child: LoadingContainer(),
                  );
                }
                if (horizontalOrientation) {
                  return Row(
                    children: body(employee),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: body(employee),
                );
              }),
        ));
  }

  openAddChildPage() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (_) => CreatePersonPage(
              parentId: bloc.currentEmployee.value.id,
              createEmployee: false,
            )));
  }
}
