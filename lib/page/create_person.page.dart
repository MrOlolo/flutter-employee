import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/bloc/core.bloc.dart';
import 'package:flutter_test_task/entity/child.dart';
import 'package:flutter_test_task/entity/employee.dart';
import 'package:flutter_test_task/page/widget/custom_text_field.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreatePersonPage extends StatefulWidget {
  final bool createEmployee;
  final parentId;

  const CreatePersonPage({Key key, this.createEmployee = false, this.parentId})
      : super(key: key);

  @override
  _CreatePersonPageState createState() => _CreatePersonPageState();
}

class _CreatePersonPageState extends State<CreatePersonPage> {
  final validateFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController patronymicController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode surnameFocus = FocusNode();
  final FocusNode patronymicFocus = FocusNode();
  final FocusNode positionFocus = FocusNode();

  bool createEmployee;
  int parentId;
  CoreBloc bloc;

  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    createEmployee = widget.createEmployee ?? false;
    parentId = widget.parentId;
    initBloc();
    subscription = KeyboardVisibility.onChange.listen((event) {
      if (!event) {
        nameFocus.unfocus();
        surnameFocus.unfocus();
        positionFocus.unfocus();
        patronymicFocus.unfocus();
      }
    });
  }

  void initBloc() {
    bloc = BlocProvider.of<CoreBloc>(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    patronymicController.dispose();
    surnameController.dispose();
    dateController.dispose();
    positionController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        nameFocus.unfocus();
        surnameFocus.unfocus();
        positionFocus.unfocus();
        patronymicFocus.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Form(
                key: validateFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 24,
                    ),
                    CustomTextField(
                      label: 'Имя',
                      controller: nameController,
                      focusNode: nameFocus,
                      validator: (value) {
                        if (value.length < 2) return 'Некорректные данные';
                        return null;
                      },
                    ),
                    Container(
                      height: 24,
                    ),
                    CustomTextField(
                      label: 'Фамилия',
                      controller: surnameController,
                      focusNode: surnameFocus,
                      validator: (value) {
                        if (value.length < 2) return 'Некорректные данные';
                        return null;
                      },
                    ),
                    Container(
                      height: 24,
                    ),
                    CustomTextField(
                      label: 'Отчество (если есть)',
                      focusNode: patronymicFocus,
                      controller: patronymicController,
                    ),
                    Container(
                      height: 24,
                    ),
                    CustomTextField(
                      label: 'Дата рождения (день, месяц, год)',
                      controller: dateController,
                      datePickMode: true,
                      onTap: () => chooseDate(context),
                    ),
                    Container(
                      height: 24,
                    ),
                    if (createEmployee)
                      CustomTextField(
                        label: 'Должность',
                        controller: positionController,
                        focusNode: positionFocus,
                        validator: (value) {
                          if (value.length < 2) return 'Некорректные данные';
                          return null;
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: savePerson,
            child: Icon(Icons.save),
          ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  void savePerson() async {
    if (validateFormKey.currentState.validate()) {
      if (createEmployee) {
        await bloc.addEmployee(Employee(
            name: nameController.text,
            surname: surnameController.text,
            patronymic: patronymicController.text,
            position: positionController.text,
            dob: dateController.text));
      } else {
        await bloc.addChild(Child(
            name: nameController.text,
            surname: surnameController.text,
            patronymic: patronymicController.text,
            dob: dateController.text,
            parentId: parentId));
      }
      Navigator.of(context).pop();
    }
  }

  chooseDate(BuildContext context) async {
    var age = 0;
    if (createEmployee) age = 14;
    var now = DateTime.now();
    DateTime temp = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - age, now.month, now.day),
      firstDate: DateTime(now.year - 100, now.month, now.day),
      lastDate: DateTime(now.year - age, now.month, now.day),
    );
    if (temp != null) {
      await initializeDateFormatting("ru_Ru", null);
      dateController.text = DateFormat.yMd('ru').format(temp);
    }
  }
}
