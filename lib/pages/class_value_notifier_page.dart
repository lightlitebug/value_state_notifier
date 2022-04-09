import 'package:flutter/material.dart';

import 'other_page.dart';

class Person {
  String name;
  int age;

  Person({
    required this.name,
    required this.age,
  });

  factory Person.initial() {
    return Person(name: 'John', age: 10);
  }
}

class PersonValueNotifier extends ValueNotifier<Person> {
  PersonValueNotifier() : super(Person.initial());

  void incrementAge() {
    value.age++;
    print(value.age);
    notifyListeners();
  }
}

class ClassValueNotifierPage extends StatefulWidget {
  const ClassValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ClassValueNotifierPage> createState() => _ClassValueNotifierPageState();
}

class _ClassValueNotifierPageState extends State<ClassValueNotifierPage> {
  final personNotifier = PersonValueNotifier();

  void _personListener() {
    if (personNotifier.value.age == 13) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('age: ${personNotifier.value.age}'),
          );
        },
      );
    } else if (personNotifier.value.age == 15) {
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
              personNotifier.value.age++;
              print(personNotifier.value.age);
            },
          ),
        ],
      ),
    );
  }
}
