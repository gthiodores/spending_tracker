import 'package:flutter/material.dart';

class OnboardingThird extends StatelessWidget {
  final VoidCallback? onDone;

  const OnboardingThird({Key? key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Done setting your preferences?'),
          const SizedBox(height: 4),
          const Text("Let's hop into the app!"),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onDone, child: const Text('Done')),
        ],
      ),
    );
  }
}
