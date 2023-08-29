import 'package:bloc_widget_arch/bloc_widget_arch.dart';
import 'package:event_bus/event_bus.dart';

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
    listen<TestStartupEvent>((event) async {
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
