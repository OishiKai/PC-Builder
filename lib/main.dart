import 'package:custom_pc/domain/database/custom_repository.dart';
import 'package:custom_pc/pages/create_custom_page.dart';
import 'package:custom_pc/pages/stored_custom_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // 縦向きのみ
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoredCustomListPage(),
    );
  }
}

class RootPage extends ConsumerWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const CreateCustomPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                        }),
                  );
                },
                child: const Text('見積もりを作成する')),
            ElevatedButton(
                onPressed: () async {
                  final storedCustoms = await CustomRepository.getAllCustoms();
                  storedCustoms?.forEach((key, value) {
                    print('$key: ${value.name}');
                  });
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => StoredCustomListPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                        }),
                  );
                },
                child: const Text('保存済みカスタム')),
            // ElevatedButton(
            //     onPressed: () async {
            //       final storedCustoms = await CustomRepository.getAllCustoms();
            //       storedCustoms?.forEach((key, value) {
            //         print('$key: ${value.name}');
            //       });
            //       Navigator.push(
            //         context,
            //         PageRouteBuilder(
            //             pageBuilder: (context, animation, secondaryAnimation) => MyWidget(),
            //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //               return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //             }),
            //       );
            //     },
            //     child: const Text('隠れる')),
          ],
        ),
      ),
    );
  }
}
