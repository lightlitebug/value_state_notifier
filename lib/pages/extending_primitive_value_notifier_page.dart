import 'package:flutter/material.dart';

import 'other_page.dart';

class CounterValueNotifier extends ValueNotifier<int> {
  CounterValueNotifier(int value) : super(value);

  void incrementCounterByTen() => value = value + 10;
}

class ExtendingPrimitiveValueNotifierPage extends StatefulWidget {
  const ExtendingPrimitiveValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ExtendingPrimitiveValueNotifierPage> createState() =>
      _ExtendingPrimitiveValueNotifierPageState();
}

class _ExtendingPrimitiveValueNotifierPageState
    extends State<ExtendingPrimitiveValueNotifierPage> {
  final _counter = CounterValueNotifier(0);

  void _counterListener() {
    if (_counter.value == 3) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('counter: ${_counter.value}'),
          );
        },
      );
    } else if (_counter.value == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const OtherPage();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _counter.addListener(_counterListener);
  }

  @override
  void dispose() {
    _counter.removeListener(_counterListener);
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extending Value Notifier'),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _counter,
        builder: (BuildContext context, int value, Widget? child) {
          return Center(
            child: Text(
              'Counter: $value',
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'one',
            child: const Icon(Icons.add),
            onPressed: () {
              _counter.value++;
            },
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'two',
            child: const Icon(Icons.note_add),
            onPressed: () {
              _counter.incrementCounterByTen();
            },
          ),
        ],
      ),
    );
  }
}
