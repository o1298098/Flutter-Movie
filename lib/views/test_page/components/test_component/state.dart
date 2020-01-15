import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/test_page/state.dart';

class TestState implements Cloneable<TestState> {
  int value;
  @override
  TestState clone() {
    return TestState();
  }
}

class TestConnector extends ConnOp<TestPageState, TestState> {
  @override
  TestState get(TestPageState state) {
    TestState substate = new TestState();

    return substate;
  }

  @override
  void set(TestPageState state, TestState subState) {}
}
