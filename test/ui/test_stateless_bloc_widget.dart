import 'package:bloc_widget_arch/bloc_widget_arch.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../test_helpers.dart';

class TestStatelessBlocWidget
    extends StatelessBlocWidget<TestBaseArchBloc, TestState> {
  const TestStatelessBlocWidget(
      this._bloc, {
        super.key,
        required this.eventBus,
      });

  final TestBaseArchBloc _bloc;
  final EventBus eventBus;

  @override
  TestBaseArchBloc get bloc => _bloc;

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
          ElevatedButton(
            onPressed: () {
              eventBus.fire(
                TestEvent('updatedText1'),
              );
            },
            child: const Text('Button1'),
          ),
          ElevatedButton(
            onPressed: () {
              eventBus.fire(
                TestEvent('updatedText2'),
              );
            },
            child: const Text('Button2'),
          ),
        ],
      ),
    );
  }
}