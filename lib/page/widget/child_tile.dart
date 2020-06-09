import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/entity/child.dart';

class ChildTile extends StatelessWidget {
  final Child child;

  const ChildTile({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          child.surname + ' ' + child.name + ' ' + child?.patronymic ?? '',
          style: TextStyle(fontSize: 15),
        ),
        subtitle: Text(child.dob),
      ),
    );
  }
}
