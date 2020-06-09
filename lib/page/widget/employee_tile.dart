import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/entity/employee.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  final Function onTap;

  const EmployeeTile({Key key, this.employee, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 1,
              ),
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Icon(
                employee.childrenAmount == 0
                    ? Icons.person
                    : Icons.supervisor_account,
                size: 50,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    employee.position,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(
                    employee.surname +
                            ' ' +
                            employee.name +
                            ' ' +
                            employee?.patronymic ??
                        '',
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    height: 3,
                  ),
                  Text(
                    employee.dob,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Container(
                    height: 3,
                  ),
                  if (employee.childrenAmount > 0)
                    Text(
                      'Дети: ${employee.childrenAmount}',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
