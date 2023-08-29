# Bloc Widget Architecture
An architecture that introduces a powerful and organized approach to 
building flutter applications. This package provides an assortment 
of abstract classes and utilities that seamlessly integrate with the 
BLoC pattern, enabling you to create clear and maintainable code.

## Features

- **BaseArchBloc:** An abstract class at the core of the Bloc Widget Architecture. It serves as a blueprint for structuring widgets that effectively interact with BLoCs. Extend this class to create widgets that respond to BLoC events and efficiently update the UI based on state changes.

- **StatefulBlocWidget:** A class designed for crafting stateful widgets that interact with BLoCs. By inheriting from this class, you can effortlessly pair your BLoC with a widget while keeping your codebase modular and clean.

- **StatelessBlocWidget:** Designed for the creation of stateless widgets that work harmoniously with BLoCs. Subclassing this abstract class simplifies the process of integrating BLoCs into widgets and ensures that your UI remains responsive and up-to-date.

![Bloc Widget Architecture Demo](https://user-images.githubusercontent.com/39815310/264117964-70c4edda-da3b-48bf-851a-3d488e35d08b.gif)

## Usage
### BaseArchBloc
```dart
class ScreenBloc extends BaseArchBloc<ScreenState> {
   ScreenBloc()
           : super(
      ScreenState(
         someInt: 0,
      ),
   );

   @override
   EventBus get eventBus => Modular.get<EventBus>();

   @override
   void registerEvents() {
      super.registerEvents();
      listen<SomeEvent>((event) {
         updateState(
            state.copyWith(
               someInt: state.someInt + 1,
            ),
         );
      });
   }
}

class ScreenState {
   final int someInt;

   ScreenState({required this.someInt});
}

extension ScreenStateCopyWith on ScreenState {
   ScreenState copyWith({
      int? someInt,
   }) {
      return ScreenState(
         someInt: someInt ?? this.someInt,
      );
   }
}

class SomeEvent {}
```

### StatefulBlocWidget
```dart
class ScreenStatefulBlocWidget extends StatefulBlocWidget {
  const ScreenStatefulBlocWidget({super.key, required this.someString});
  
  final String someString;

  @override
  State<StatefulBlocWidget> createState() => ScreenStatefulBlocWidgetState();
}

class ScreenStatefulBlocWidgetState
    extends StatefulBlocWidgetState<ScreenBloc, ScreenState> {
  ScreenStatefulBlocWidget get customWidget => widget as ScreenStatefulBlocWidget;

  @override
  ScreenBloc get bloc => Modular.get<ScreenBloc>();
  
  // Set up state objects, controllers, etc.

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('BlocWidgetArch'),
       ),
       body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Center(
                child: Text(
                   customWidget.someString,
                   style: TextStyle(fontSize: 18.0),
                ),
             ),
             Center(
                child: Text(
                   bloc.state.someInt.toString(),
                   style: TextStyle(fontSize: 16.0),
                ),
             ),
             SizedBox(
                height: 24.0,
             ),
             ElevatedButton(
                onPressed: () {
                   bloc.eventBus.fire(SomeEvent());
                },
                child: Text('press me'),
             ),
          ],
       ),
    );
  }
}
```

### StatelessBlocWidget
```dart
class Screen extends StatelessBlocWidget<ScreenBloc, ScreenState> {
  const Screen({super.key});

  @override
  get bloc => Modular.get<ScreenBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlocWidgetArch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              bloc.state.someInt.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            onPressed: () {
              bloc.eventBus.fire(SomeEvent());
            },
            child: Text('press me'),
          ),
        ],
      ),
    );
  }
}
```

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Additional information
This package was developed with modularity and scalability in mind.
It works great with flutter_modular (it was originally developed in a project utilizing it).



## License

This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.


**Author:** [Cody L. Bainter]