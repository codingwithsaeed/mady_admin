import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const String id = 'MAIN_PAGE';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مادی ادمین'),
      ),
      body: const Center(
        child: Text('Main Page'),
      ),
    );
  }
}
