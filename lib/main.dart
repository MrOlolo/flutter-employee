import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/bloc/core.bloc.dart';

import 'application.dart';

void main() {
  runApp(BlocProvider<CoreBloc>(
      creator: (_, __) => CoreBloc(), child: Application()));
}
