import 'package:custom_pc/domain/parts_list_parser.dart';
import 'package:custom_pc/domain/parts_search_list_parser.dart';
import 'package:custom_pc/domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import 'package:custom_pc/models/category_home_data.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/pc_parts_old.dart';
import 'package:custom_pc/pages/create_custom_page.dart';
import 'package:custom_pc/rebased/domain/parts_list_parser.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/rebased/pages/parts_list_page.dart';
import 'package:custom_pc/providers/pc_parts_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';

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
                child: const Text('見積もりを作成する')),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => PListPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                        }),
                  );
                },
                child: const Text('PLIST')),

          ],
        ),
      ),
    );
  }
}

// final searchParameterProvider = StateProvider<CategorySearchParameter?>((ref) {
//   return null;
// });

final categoryHomeDataProvider = StateProvider<CategoryHomeData>((ref) {
  return CategoryHomeData();
});

final targetUrlProvider = StateProvider((ref) {
  return "";
});

// final partsListFutureProvider = FutureProvider((ref) async {
//   final parser = await PartsSearchListParser.create(ref.watch(targetUrlProvider));
//   final fetchedPartsList = parser.partsList;
//   return fetchedPartsList;
// });

// final partsListProvider = StateProvider((ref) {
//   return ref.watch(partsListFutureProvider).value;
// });

final searchingCategoryProvider = StateProvider<PartsCategory>((ref) {
  return PartsCategory.cpu;
});
