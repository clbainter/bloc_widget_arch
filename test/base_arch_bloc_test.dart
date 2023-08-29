import 'package:flutter_test/flutter_test.dart';
import 'test_helpers.dart';

void main() {
  group('BaseArchBloc', () {
    test('registerEvents should register UpdateEvent', () {
      final bloc = TestBaseArchBloc();
      // Check that the initial state is correct
      final originalState = bloc.state;
      expect(
        originalState.testString,
        'testString',
      );

      final newState = bloc.state.copyWith(
        testString: 'updatedString',
      );
      bloc.updateState(newState);

      expectLater(
        bloc.stream,
        emitsInOrder(
          [newState],
        ),
      );
    });
  });

  test('listen<TestEvent> should add the event to eventListeners', () {
    final bloc = TestBaseArchBloc();
    expect(
      bloc.eventListeners.containsKey(TestEvent),
      isTrue,
    );
  });

  test('executeStartupEvents is called', () {
    final bloc = TestBaseArchBloc();
    expect(
      bloc.eventListeners.containsKey(TestStartupEvent),
      isTrue,
    );
  });

  test('close cancels listeners', () {
    final bloc = TestBaseArchBloc();
    final eventBus = bloc.eventBus;
    bloc.close();
    // expect(eventBus, null);
    print('did it close');
    bloc.eventListeners.forEach((key, value) {
      print('${value}');
    });
  });
}
