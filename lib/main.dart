import 'package:flutter/material.dart';

import 'pages/class_value_notifier_page.dart';
import 'pages/extending_primitive_value_notifier_page.dart';
import 'pages/immutable_value_notifier_page.dart';
import 'pages/primitive_value_notifier_page.dart';
import 'pages/state_notifier_page.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifiers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifiers'),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              CustomButton(
                text: 'Primitive Value Notifier',
                page: PrimitiveValueNotifierPage(),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                text: 'Extending Primitive Value Notifier',
                page: ExtendingPrimitiveValueNotifierPage(),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                text: 'Class Value Notifier',
                page: ClassValueNotifierPage(),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                text: 'Immutable Value Notifier',
                page: ImmutableValueNotifierPage(),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                text: 'State Notifier',
                page: StateNotifierPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
