import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';
import 'package:material_3_testing/presentation/bloc/preference/preference_bloc.dart';

class OnboardingSecond extends StatelessWidget {
  const OnboardingSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceBloc, PreferenceState>(
      builder: (context, state) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 4),
              Text(
                'Personalize your app',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Here are some settings to get you started!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Dark mode'),
                subtitle: const Text('Enable dark mode'),
                trailing: Switch(
                  value: state.darkMode,
                  onChanged: (darkMode) => context
                      .read<PreferenceBloc>()
                      .add(PreferenceDarkModeChanged(darkMode)),
                ),
              ),
              ListTile(
                title: const Text('Display currency'),
                subtitle: const Text('The currency used for your spending'),
                trailing: DropdownButton<CurrencyEnum>(
                  items: CurrencyEnum.values
                      .map<DropdownMenuItem<CurrencyEnum>>(
                        (e) => DropdownMenuItem<CurrencyEnum>(
                          value: e,
                          child: Text(e.symbol),
                        ),
                      )
                      .toList(),
                  onChanged: (currency) => context
                      .read<PreferenceBloc>()
                      .add(PreferencePreferredCurrencyChanged(
                        currency ?? CurrencyEnum.idr,
                      )),
                  value: state.preferredCurrency,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
