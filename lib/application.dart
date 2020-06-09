import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/non_glow_scroll_behavior.dart';

import 'page/home.page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees&children',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        const BackButtonTextDelegate(),
      ],
      home: ScrollConfiguration(
          behavior: NonGlowScrollBehavior(), child: HomePage()),
    );
  }
}

class BackButtonTextOverride extends DefaultMaterialLocalizations {
  BackButtonTextOverride(Locale locale) : super();

  @override
  String get backButtonTooltip => null;
}

class BackButtonTextDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const BackButtonTextDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture(BackButtonTextOverride(locale));
  }

  @override
  bool shouldReload(BackButtonTextDelegate old) => false;
}
