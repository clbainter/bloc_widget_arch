import 'package:bloc_widget_arch/bloc_widget_arch.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

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

class TestBaseArchBloc extends BaseArchBloc<TestState> {
  TestBaseArchBloc()
      : super(
          TestState(
            testString: 'testString',
            testStartupString: 'testStartupString',
          ),
        );

  @override
  void registerEvents() {
    super.registerEvents();
    eventBus.on().listen((event) {
      print('event happened');
    });
    listen<TestEvent>((event) async {
      updateState(
        state.copyWith(
          testString: event.testEventString,
        ),
      );
    });
  }

  @override
  void executeStartupEvents() {
    print('inside execute startup');
    eventBus.on<TestEvent>().listen((event) {
      print('this works');
    });
    listen<TestStartupEvent>((event) async {
      print('receive test startup');
      updateState(
        state.copyWith(
          testStartupString: event.testStartupEventString,
        ),
      );
    });
  }

  @override
  EventBus get eventBus => testEventBus;
}

class TestState {
  final String testString;
  final String testStartupString;

  TestState({
    required this.testString,
    required this.testStartupString,
  });
}

extension TestCopyWithExtension on TestState {
  TestState copyWith({
    String? testString,
    String? testStartupString,
  }) {
    return TestState(
      testString: testString ?? this.testString,
      testStartupString: testStartupString ?? this.testStartupString,
    );
  }
}

class TestEvent {
  String testEventString;

  TestEvent(this.testEventString);
}

class TestStartupEvent {
  String testStartupEventString;

  TestStartupEvent(this.testStartupEventString);
}

class TestEventBus extends EventBus {}

TestEventBus get testEventBus => TestEventBus();
