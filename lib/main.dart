import 'package:custom_pc/domain/parts_list_parser.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/size_config.dart';
import 'models/pc_parts.dart';

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
                final partsListUrl = 'https://kakaku.com/search_results/%83O%83%89%83t%83B%83b%83N%83%7B%81%5B%83h/?category=0001%2C0028&act=Suggest';
                final targetUrlProviderController = ref.watch(targetUrlProvider.notifier);
                targetUrlProviderController.update((state) => partsListUrl);
                final bool? selected = await Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => CategoryHomePage(Category.graphicsCard),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                      }),
                );
              },
              child: Text("検索する"),
            ),
          ],
        ),
      ),
    );
  }
}

final targetUrlProvider = StateProvider((ref) {
  return "";
});

final partsListFutureProvider = FutureProvider((ref) async {
  final parser = await PartsListParser.create(ref.watch(targetUrlProvider));
  final fetchedPartsList = parser.partsList;
  return fetchedPartsList;
});

final partsListProvider = StateProvider((ref) {
  return ref.watch(partsListFutureProvider).value;
});

class _PartsListPage extends ConsumerWidget {
  const _PartsListPage(this.partsListUrl);
  final String partsListUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    List<PcParts> partsList = [];
    final partsListProvider = ref.watch(partsListFutureProvider);
    if (partsListProvider.value != null) {
      partsList = partsListProvider.value!;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            padding: EdgeInsets.all(
              SizeConfig.blockSizeHorizontal * 1,
            ),
            itemCount: partsList.length,
            itemBuilder: (BuildContext context, int index) {
              final cell = partsListCell(index);
              cell.stars = cell.describeStars(ref.watch(partsListFutureProvider).value![index]);
              return cell;
            }),
      ),
    );
  }
}
