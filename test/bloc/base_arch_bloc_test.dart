import 'package:flutter_test/flutter_test.dart';
import '../test_helpers.dart';

void main() {
  group('BaseArchBloc', () {
    test('registerEvents should register UpdateEvent', () {
      final bloc = TestBaseArchBloc();
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
}
