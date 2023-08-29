import 'package:bloc_widget_arch/bloc_widget_arch.dart';
import 'package:flutter/material.dart';

import '../test_helpers.dart';

class TestStatefulBlocWidget extends StatefulBlocWidget {
  const TestStatefulBlocWidget(this._bloc, {super.key});

  final TestBaseArchBloc _bloc;

  @override
  State<StatefulBlocWidget> createState() => TestStatefulBlocWidgetState();
}

class TestStatefulBlocWidgetState
    extends StatefulBlocWidgetState<TestBaseArchBloc, TestState> {
  TestStatefulBlocWidget get customWidget => widget as TestStatefulBlocWidget;

  @override
  TestBaseArchBloc get bloc => customWidget._bloc;

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(bloc.state.testString),
          ),
          Center(
            child: Text(bloc.state.testStartupString),
          ),
        ],
      ),
    );
  }
}
