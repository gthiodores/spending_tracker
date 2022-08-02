import 'package:flutter/material.dart';
import 'package:material_3_testing/routes.dart';

class SpendingListRoute extends StatelessWidget {
  const SpendingListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, routeSetting),
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: const Center(child: Text('TBD')),
    );
  }
}
