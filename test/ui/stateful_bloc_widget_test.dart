import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_stateful_bloc_widget.dart';
import '../test_helpers.dart';

void main() {
  group('StatefulBlocWidget Tests', () {
    testWidgets('StatefulBlocWidget', (tester) async {
      final bloc = TestBaseArchBloc();
      final widget = MaterialApp(
        home: TestStatefulBlocWidget(
          bloc,
        ),
      );
      await tester.pumpWidget(widget);

      expect(find.text('testString'), findsOneWidget);
      expect(find.text('testStartupString'), findsOneWidget);
    });
  });
}
