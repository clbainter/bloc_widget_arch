import 'package:bloc_widget_arch/bloc_widget_arch.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Screen(),
    );
  }
}

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<EventBus>((i) => EventBus()),
    Bind.lazySingleton<ScreenBloc>((i) => ScreenBloc()),
  ];
}

class Screen extends StatelessBlocWidget<ScreenBloc, ScreenState> {
  const Screen({super.key});

  @override
  get bloc => Modular.get<ScreenBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlocWidgetArch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              bloc.state.someInt.toString(),
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            onPressed: () {
              bloc.eventBus.fire(SomeEvent());
            },
            child: const Text('press me'),
          ),
        ],
      ),
    );
  }
}

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
