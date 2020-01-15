import 'package:flutter/material.dart';

class TestInheritedWidget extends InheritedWidget {
  TestInheritedWidget({@required this.counter, Widget child})
      : super(child: child);
  final TestClass counter;

  static TestInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TestInheritedWidget>();
  }

  @override
  bool updateShouldNotify(TestInheritedWidget oldWidget) {
    return oldWidget.counter.value != counter.value;
  }
}

class TestClass {
  String name;
  int value;
  TestClass({this.name, this.value});
}
