import 'package:belajar_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocListener<CounterBloc, CounterState>(
                listener: (context, state) {
                  if (state.number < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Number is negative!'),
                      ),
                    );
                  }
                },
                child: BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return Text(
                      state.number.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterDecrement());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterIncrement());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }
}
