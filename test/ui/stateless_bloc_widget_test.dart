import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_stateless_bloc_widget.dart';
import '../test_helpers.dart';

void main() {
  group('StatelessBlocWidget Tests', () {
    testWidgets('StatelessBlocWidget - update state events', (tester) async {
      final bloc = TestBaseArchBloc();
      final widget = MaterialApp(
        home: TestStatelessBlocWidget(
          bloc,
          eventBus: bloc.eventBus,
        ),
      );
      await tester.pumpWidget(widget);

      expect(find.text('testString'), findsOneWidget);
      expect(find.text('testStartupString'), findsOneWidget);
      expect(find.text('Button1'), findsOneWidget);
      expect(find.text('Button2'), findsOneWidget);

      await tester.tap(find.text('Button1'));
      await tester.pumpAndSettle();
    });
  });
}
