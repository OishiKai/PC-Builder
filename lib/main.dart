import 'package:custom_pc/domain/cpu_cooler_start_parser.dart';
import 'package:custom_pc/domain/parts_search_list_parser.dart';
import 'package:custom_pc/models/category_home_data.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/pages/parts_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/cpu_search_start_parser.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
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
              onPressed: () async {
                const partsListUrl = CpuSearchParameterParser.standardPage;
                final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
                targetUrlProviderController.update((state) => partsListUrl);
                final parameter = await CpuSearchParameterParser.fetchSearchParameter();
                ref.read(searchParameterProvider.notifier).state = parameter;

                final bool? selected = await Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                      }),
                );
              },
              child: Text("CPUを検索する"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                const partsListUrl = CpuCoolerSearchParameterParser.standardPage;
                final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
                targetUrlProviderController.update((state) => partsListUrl);
                final parameter = await CpuCoolerSearchParameterParser.fetchSearchParameter();
                ref.read(searchParameterProvider.notifier).state = parameter;

                final bool? selected = await Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                      }),
                );
              },
              child: Text("CPUクーラーを検索する"),
            ),
          ],
        ),
      ),
    );
  }
}

final searchParameterProvider = StateProvider<CategorySearchParameter?>((ref) {
  return null;
});

final categoryHomeDataProvider = StateProvider<CategoryHomeData>((ref) {
  return CategoryHomeData();
});

final targetUrlProvider = StateProvider((ref) {
  return "";
});

final partsListFutureProvider = FutureProvider((ref) async {
  final parser = await PartsSearchListParser.create(ref.watch(targetUrlProvider));
  final fetchedPartsList = parser.partsList;
  return fetchedPartsList;
});

final partsListProvider = StateProvider((ref) {
  return ref.watch(partsListFutureProvider).value;
});
