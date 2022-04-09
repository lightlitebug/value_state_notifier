import 'package:flutter/material.dart';

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

class PersonValueNotifier extends ValueNotifier<Person> {
  PersonValueNotifier() : super(Person.initial());

  void incrementAge() {
    value = value.copyWith(age: value.age + 1);
  }

  void toggleName() {
    value = value.copyWith(name: value.name == 'John' ? 'Doe' : 'John');
  }
}

class ImmutableValueNotifierPage extends StatefulWidget {
  const ImmutableValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ImmutableValueNotifierPage> createState() =>
      _ImmutableValueNotifierPageState();
}

class _ImmutableValueNotifierPageState
    extends State<ImmutableValueNotifierPage> {
  final personNotifier = PersonValueNotifier();

  void _personListener() {
    if (personNotifier.value.age == 33) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'name: ${personNotifier.value.name}\nage: ${personNotifier.value.age}'),
          );
        },
      );
    } else if (personNotifier.value.age == 35) {
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
    personNotifier.addListener(_personListener);
  }

  @override
  void dispose() {
    personNotifier.removeListener(_personListener);
    personNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value Notifier'),
      ),
      body: ValueListenableBuilder<Person>(
        valueListenable: personNotifier,
        builder: (BuildContext context, Person value, Widget? child) {
          return Center(
            child: Text(
              'Name: ${value.name}\nAge: ${value.age}',
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
              personNotifier.incrementAge();
            },
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'two',
            child: const Icon(Icons.note_add),
            onPressed: () {
              // personNotifier.toggleName();
              personNotifier.value =
                  personNotifier.value.copyWith(name: "Haha");
            },
          ),
        ],
      ),
    );
  }
}
