import 'package:custom_pc/domain/parts_search_list_parser.dart';
import 'package:custom_pc/domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import 'package:custom_pc/models/category_home_data.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/create_custom_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    CaseFanSearchParameterParser.fetchSearchParameter();
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
                        pageBuilder: (context, animation, secondaryAnimation) => CreateCustomPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                        }),
                  );
                },
                child: const Text('見積もりを作成する'))
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = CpuSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await CpuSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("CPUを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = CpuCoolerSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await CpuCoolerSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("CPUクーラーを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = MemorySearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await MemorySearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("メモリを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = MotherBoardSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await MotherBoardSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("マザーボードを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = GraphicsCardSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);

            //     final parameter = await GraphicsCardSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("ビデオカードを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = SsdSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await SsdSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;
            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("SSDを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = PcCaseSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await PcCaseSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("PCケースを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = PowerUnitSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await PowerUnitSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("電源ユニットを検索する"),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     const partsListUrl = CaseFanSearchParameterParser.standardPage;
            //     final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
            //     targetUrlProviderController.update((state) => partsListUrl);
            //     final parameter = await CaseFanSearchParameterParser.fetchSearchParameter();
            //     ref.read(searchParameterProvider.notifier).state = parameter;

            //     final bool? selected = await Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) => PartsListPage(),
            //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //             return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            //           }),
            //     );
            //   },
            //   child: Text("ケースファンを検索する"),
            // ),
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

final searchingCategoryProvider = StateProvider<PartsCategory>((ref) {
  return PartsCategory.cpu;
});
