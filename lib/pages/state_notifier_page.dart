import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

import 'other_page.dart';

@immutable
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  factory Person.initial() {
    return const Person(name: 'John', age: 30);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Person && other.name == name && other.age == age;
  }

  @override
  int get hashCode {
    return name.hashCode ^ age.hashCode;
  }

  @override
  String toString() => 'Person(name: $name, age: $age)';

  Person copyWith({
    String? name,
    int? age,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}

class PersonStateNotifier extends StateNotifier<Person> {
  PersonStateNotifier() : super(Person.initial());

  void incrementAge() {
    state = state.copyWith(age: state.age + 1);
  }

  void toggleName() {
    state = state.copyWith(name: state.name == 'John' ? 'Doe' : 'John');
  }
}

class StateNotifierPage extends StatefulWidget {
  const StateNotifierPage({Key? key}) : super(key: key);

  @override
  State<StateNotifierPage> createState() => _StateNotifierPageState();
}

class _StateNotifierPageState extends State<StateNotifierPage> {
  final personStateNotifier = PersonStateNotifier();
  late VoidCallback _personListener;

  void personListener(Person state) {
    if (state.age == 33) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('name: ${state.name}\nage: ${state.age}'),
          );
        },
      );
    } else if (state.age == 35) {
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
    _personListener = personStateNotifier.addListener(personListener);
  }

  @override
  void dispose() {
    _personListener();
    personStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier'),
      ),
      body: StateNotifierBuilder<Person>(
        stateNotifier: personStateNotifier,
        builder: ((context, value, child) {
          return Center(
            child: Text(
              'Name: ${value.name}\nAge: ${value.age}',
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'one',
            child: const Icon(Icons.add),
            onPressed: () {
              personStateNotifier.incrementAge();
            },
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'two',
            child: const Icon(Icons.change_history),
            onPressed: () {
              personStateNotifier.toggleName();
            },
          ),
        ],
      ),
    );
  }
}
