import 'package:custom_pc/v2/providers/router.dart';
import 'package:custom_pc/v2/providers/theme.dart' as th;
import 'package:custom_pc/v2/share_preferences_instance.dart';
import 'package:custom_pc/v2/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initialize();
  SystemChrome.setPreferredOrientations([
    // 縦向きのみ
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StoredCustomListPage(),
//     );
//   }
// }

// v2
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders = <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  };

  ThemeData createTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'NotoSansJP',
      pageTransitionsTheme: const PageTransitionsTheme(builders: _defaultBuilders),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(th.themeProvider);
    ThemeData themeData;
    switch (theme) {
      case ThemeMode.light:
        themeData = createTheme(lightColorScheme);
        break;
      case ThemeMode.dark:
        themeData = createTheme(darkColorScheme);
        break;
      case ThemeMode.system:
        MediaQuery.platformBrightnessOf(context) == Brightness.dark ? themeData = createTheme(darkColorScheme) : themeData = createTheme(lightColorScheme);
        break;
    }

    return MaterialApp.router(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
