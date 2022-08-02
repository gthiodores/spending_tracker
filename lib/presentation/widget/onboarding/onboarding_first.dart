import 'package:flutter/material.dart';

class OnboardingFirst extends StatelessWidget {
  final VoidCallback? onGetStarted;

  const OnboardingFirst({Key? key, this.onGetStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Seems like this is your first time \n using this app on your phone.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onGetStarted,
            child: const Text('Get Started!'),
          ),
        ],
      ),
    );
  }
}
