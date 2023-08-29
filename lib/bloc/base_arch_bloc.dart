import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Abstract class for a base architecture BLoC (Business Logic Component).
abstract class BaseArchBloc<S> extends Bloc<UpdateEvent, S> {
  /// Constructor for the [BaseArchBloc] class.
  ///
  /// Initializes the [BaseArchBloc] with [initialState],
  /// registers events, and executes startup events.
  BaseArchBloc(S initialState) : super(initialState) {
    registerEvents();
    executeStartupEvents();
  }

  EventBus get eventBus;

  Map<Type, StreamSubscription<dynamic>> eventListeners = {};


  /// ## registerEvents()
  /// Implement this method to register events and eventHandlers
  @mustCallSuper
  void registerEvents() {
    on<UpdateEvent>((event, emit) {
      emit(event.state);
    });
  }

  /// Listens for events of a specific type and registers a callback function to handle them.
  ///
  /// This method provides a convenient way to subscribe to events of type [T] using the [eventBus].
  ///
  /// The [callback] function is invoked whenever an event of type [T] is received. It takes one
  /// parameter, which is the received event.
  ///
  /// After calling this method, the event subscription is automatically managed, and there is no
  /// need to manually unsubscribe. The event subscription will be canceled when the bloc is closed.
  ///
  /// Example usage:
  /// ```dart
  /// listen<SomeEvent>((event) {
  ///   // Handle SomeEvent
  /// });
  /// ```
  ///
  /// Returns a [StreamSubscription] that represents the active event subscription.
  StreamSubscription<T> listen<T>(Function(T) callback) {
    StreamSubscription<T> subscription = eventBus.on<T>().listen(callback);
    eventListeners[T] = subscription;
    return subscription;
  }


  /// Updates the state of the bloc with a new state instance.
  ///
  /// This method is a convenient way to trigger a state update in the bloc without manually
  /// creating and dispatching an event.
  ///
  /// The [newState] parameter represents the new state that you want to set for the bloc. It's
  /// typically a modified version of the current state, created using a copy method.
  ///
  /// Example usage:
  /// ```dart
  /// updateState(
  ///   state.copyWith(someValue: event.someValue),
  /// );
  /// ```
  ///
  /// This method internally dispatches an [UpdateEvent] with the [newState], causing the bloc
  /// to emit the updated state to its listeners.
  void updateState(S newState) {
    add(UpdateEvent<S>(newState));
  }


  /// ## executeStartupEvents()
  /// Use this function to perform any actions
  /// that should be executed when this bloc
  /// is first created.
  void executeStartupEvents() {}

  /// Closes the bloc instance and performs necessary cleanup operations.
  ///
  /// This method is called when the bloc is no longer needed.
  /// It cancels all active event subscriptions.
  /// Subclasses can override this method to provide additional cleanup logic.
  ///
  /// It's important to call `super.close()` at the end of the overridden method
  /// to ensure proper cleanup. For example:
  ///
  /// ```dart
  /// @override
  /// Future<void> close() {
  ///   // Perform additional cleanup logic
  ///   myCustomResource.dispose();
  ///
  ///   // Call super.close() to complete the bloc's cleanup process
  ///   return super.close();
  /// }
  /// ```
  ///
  /// Returns a [Future] that completes when the cleanup process is finished.
  @override
  Future<void> close() {
    eventListeners.forEach((key, value) {
      value.cancel();
    });
    return super.close();
  }

}

/// A generic event class used to update the state of a BLoC.
///
/// The [UpdateEvent] class provides a convenient way to trigger state updates
/// within a BLoC by encapsulating the new state that should be emitted. While
/// BLoCs can be updated using various event types, using [UpdateEvent] helps
/// maintain a consistent approach to state updates.
///
/// To use [UpdateEvent], simply create an instance of the event and provide
/// the new [state] as a parameter. When dispatched within a BLoC, the [state]
/// contained in the event will be emitted as the new state.
///
/// Example usage:
/// ```dart
/// final updatedState = MyState(/* updated values */);
/// final updateEvent = UpdateEvent(updatedState);
/// myBloc.add(updateEvent);
/// ```
class UpdateEvent<State> {
  /// The new state that should be emitted by the BLoC.
  final State state;

  /// Creates an [UpdateEvent] instance with the specified [state].
  UpdateEvent(this.state);
}
