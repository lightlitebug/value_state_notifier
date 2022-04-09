import 'package:flutter/material.dart';

import 'other_page.dart';

class PrimitiveValueNotifierPage extends StatefulWidget {
  const PrimitiveValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<PrimitiveValueNotifierPage> createState() =>
      _PrimitiveValueNotifierPageState();
}

class _PrimitiveValueNotifierPageState
    extends State<PrimitiveValueNotifierPage> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

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
        title: const Text('Value Notifier'),
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
            child: const Icon(Icons.add),
            onPressed: () {
              _counter.value++;
            },
          ),
        ],
      ),
    );
  }
}
