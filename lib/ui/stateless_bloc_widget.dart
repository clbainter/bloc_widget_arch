import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// An abstract base class for creating stateless widgets that use BLoCs.
///
/// The [StatelessBlocWidget] class provides a consistent structure for creating
/// stateless widgets that are powered by BLoCs (Business Logic Components). It
/// encourages separation of concerns and simplifies the process of integrating
/// BLoCs into widgets.
///
/// Subclasses of [StatelessBlocWidget] are expected to provide a [bloc] instance,
/// which represents the BLoC associated with the widget. The [onBuild] method
/// should also be overridden to return the actual widget content based on the
/// provided [BuildContext].
///
/// Example usage:
/// ```dart
/// class MyStatelessWidget extends StatelessBlocWidget<MyBloc, MyState> {
///   const MyStatelessWidget({Key? key, required MyBloc bloc}) : super(key: key, bloc: bloc);
///
///   @override
///   MyBloc get bloc => Modular.get<MyBloc>();
///
///   @override
///   Widget onBuild(BuildContext context) {
///     return // Your widget content here
///   }
/// }
/// ```
abstract class StatelessBlocWidget<B extends BlocBase<S>, S> extends StatelessWidget {
  /// Creates a [StatelessBlocWidget] instance with the specified [key].
  ///
  /// Subclasses should provide the [bloc] instance that represents the associated BLoC.
  const StatelessBlocWidget({super.key});

  /// The BLoC instance associated with this widget.
  B get bloc;

  /// Builds the widget content using the provided [BuildContext].
  ///
  /// Subclasses should override this method to return the widget content based on
  /// the current state and any other contextual information.
  Widget onBuild(BuildContext context);

  @override
  @mustCallSuper
  StatelessElement createElement() {
    return super.createElement();
  }

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
}
