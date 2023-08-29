import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helpers.dart';

void main() {
  group('BaseWidgetArchitecture Tests', () {
    testWidgets('StatelessBlocWidget - update state events', (tester) async {
      final bloc = TestBaseArchBloc();
      final widget = MaterialApp(
        home: TestStatelessBlocWidget(
          bloc,
          eventBus: bloc.eventBus,
        ),
      );
      await tester.pumpWidget(widget);
      print('${bloc.state.testString}');
      bloc.eventListeners.forEach((key, value) {
        print('listener: $value');
      });

      expect(find.text('testString'), findsOneWidget);
      expect(find.text('testStartupString'), findsOneWidget);
      expect(find.text('Button1'), findsOneWidget);
      expect(find.text('Button2'), findsOneWidget);

      expectLater(
        bloc.stream,
        emitsInOrder(
          [],
        ),
      );

      await tester.tap(find.text('Button1'));
      await tester.pumpAndSettle();
      print('${bloc.state.testString}');

      // expect(find.text('testString'), findsNothing);
      // expect(find.text('updatedText1'), findsOneWidget);
    });
  });
}
