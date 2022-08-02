import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:material_3_testing/presentation/widget/onboarding/onboarding_first.dart';
import 'package:material_3_testing/presentation/widget/onboarding/onboarding_indicator.dart';
import 'package:material_3_testing/presentation/widget/onboarding/onboarding_second.dart';
import 'package:material_3_testing/presentation/widget/onboarding/onboarding_third.dart';
import 'package:material_3_testing/routes.dart';
import 'package:material_3_testing/service_locator.dart';

class OnboardingRoute extends StatefulWidget {
  const OnboardingRoute({Key? key}) : super(key: key);

  @override
  State<OnboardingRoute> createState() => _OnboardingRouteState();
}

class _OnboardingRouteState extends State<OnboardingRoute> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            OnboardingBloc(locator.get(), locator.get())..add(OnboardingInit()),
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state.onboardingCompleted) {
              Navigator.pushReplacementNamed(context, routeList);
            }
          },
          builder: (context, state) => Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return OnboardingFirst(
                      onGetStarted: () => pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                      ),
                    );
                  }

                  if (index == 1) return const OnboardingSecond();

                  return OnboardingThird(
                    onDone: () => context
                        .read<OnboardingBloc>()
                        .add(OnboardingDoneEvent()),
                  );
                },
                itemCount: 3,
                onPageChanged: (index) => context
                    .read<OnboardingBloc>()
                    .add(OnboardingPageChange(index)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      3,
                      (index) => OnboardingIndicator(
                        isFocused: state.currentPage == index,
                        onIndicatorTapped: () => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
