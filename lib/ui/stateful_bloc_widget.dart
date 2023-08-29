import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// An abstract base class for creating stateful widgets that use BLoCs.
///
/// The [StatefulBlocWidget] class provides a consistent structure for creating
/// stateful widgets that are powered by BLoCs (Business Logic Components). It
/// encourages separation of concerns and simplifies the process of integrating
/// BLoCs into widgets.
///
/// Subclasses of [StatefulBlocWidget] are expected to provide a [bloc] instance
/// in their corresponding state class. The [onBuild] method should also be overridden
/// in the state class to return the actual widget content based on the provided
/// [BuildContext].
///
/// Example usage:
/// ```dart
/// class MyStatefulWidget extends StatefulBlocWidget {
///   const MyStatefulWidget({Key? key}) : super(key: key);
///
///   @override
///   State<StatefulBlocWidget> createState() => MyStatefulWidgetState();
/// }
///
/// class MyStatefulWidgetState extends State<MyStatefulWidget> {
///   final MyBloc _bloc = MyBloc();
///
///   @override
///   MyBloc get bloc => _bloc;
///
///   @override
///   Widget onBuild(BuildContext context) {
///     return // Your widget content here
///   }
/// }
/// ```
abstract class StatefulBlocWidget extends StatefulWidget {
  /// Creates a [StatefulBlocWidget] instance with the specified [key].
  const StatefulBlocWidget({super.key});

  @override
  State<StatefulBlocWidget> createState();
}


abstract class StatefulBlocWidgetState<B extends BlocBase<S>, S> extends State<StatefulBlocWidget> {
  B get bloc;

  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<B, S>(
        buildWhen: (S prev, S next) => prev != next,
        builder: (context, _) {
          return BlocProvider.value(
            value: bloc,
            child: onBuild(context),
          );
        },
      ),
    );
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
  }
}