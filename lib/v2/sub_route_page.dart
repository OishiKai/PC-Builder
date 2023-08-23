import 'package:flutter/material.dart';

class SubRoutePage extends StatelessWidget {
  const SubRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sub Route Page')),
      body: const Center(
        child: Text('Sub Route Page'),
      ),
    );
  }
}
