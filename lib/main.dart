import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/data/model/spending.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';
import 'package:material_3_testing/presentation/bloc/preference/preference_bloc.dart';
import 'package:material_3_testing/presentation/route/onboarding/onboarding_route.dart';
import 'package:material_3_testing/presentation/route/setting/setting_route.dart';
import 'package:material_3_testing/presentation/route/spending_list/spending_list_route.dart';
import 'package:material_3_testing/presentation/theme/colors.dart';
import 'package:material_3_testing/presentation/widget/error/error_page.dart';
import 'package:material_3_testing/routes.dart';
import 'package:material_3_testing/service_locator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyEnumAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(SpendingAdapter());
  initLocatorAppModule();
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreferenceBloc(
        locator.get(),
        locator.get(),
        locator.get(),
        locator.get(),
        locator.get(),
      )..add(PreferenceInit()),
      child: BlocBuilder<PreferenceBloc, PreferenceState>(
        builder: (context, state) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: const OnboardingRoute(),
          onGenerateRoute: (setting) {
            switch (setting.name) {
              case routeOnboarding:
                return MaterialPageRoute(
                  builder: (_) => const OnboardingRoute(),
                );
              case routeLogin:
                return MaterialPageRoute(builder: (_) => const ErrorPage());
              case routeList:
                return MaterialPageRoute(
                  builder: (_) => const SpendingListRoute(),
                );
              case routeSetting:
                return MaterialPageRoute(builder: (_) => const SettingRoute());
              default:
                return MaterialPageRoute(builder: (_) => const ErrorPage());
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
