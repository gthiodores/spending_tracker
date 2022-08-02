import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final VoidCallback? onIndicatorTapped;
  final bool isFocused;

  const OnboardingIndicator({
    Key? key,
    this.onIndicatorTapped,
    required this.isFocused,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onIndicatorTapped,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isFocused ? 20 : 16,
          height: isFocused ? 20 : 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withAlpha(120),
          ),
        ),
      ),
    );
  }
}
