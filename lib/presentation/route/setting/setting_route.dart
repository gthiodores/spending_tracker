import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';
import 'package:material_3_testing/presentation/bloc/preference/preference_bloc.dart';

class SettingRoute extends StatelessWidget {
  const SettingRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<PreferenceBloc, PreferenceState>(
        builder: (context, state) => CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: ListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark mode'),
                trailing: Switch(
                  value: state.darkMode,
                  onChanged: (darkMode) => context
                      .read<PreferenceBloc>()
                      .add(PreferenceDarkModeChanged(darkMode)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                title: const Text('Preferred currency'),
                subtitle: const Text('The default currency to use'),
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
            ),
          ],
        ),
      ),
    );
  }
}
