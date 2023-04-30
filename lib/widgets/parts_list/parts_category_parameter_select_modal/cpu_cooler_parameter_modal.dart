import 'package:custom_pc/domain/cpu_cooler_start_parser.dart';
import 'package:custom_pc/domain/url_builder.dart';
import 'package:custom_pc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/search_parameters/cpu_cooler_search_parameter.dart';

class CpuCoolerParameterModal extends ConsumerStatefulWidget {
  const CpuCoolerParameterModal({super.key});

  final _subColor = const Color(0xFFEDECF2);
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CpuCoolerParameterModal();
}

class _CpuCoolerParameterModal extends ConsumerState<CpuCoolerParameterModal> {
  @override
  Widget build(BuildContext context) {
    final params = ref.watch(searchParameterProvider)! as CpuCoolerSearchParameter;

    // 条件選択時の処理
    void addParameter(CpuCoolerSearchParameter params) {
      final url = UrlBuilder.createURLWithParameters(CpuCoolerSearchParser.standardPage, params.selectedParameters());
      ref.read(targetUrlProvider.notifier).update((state) => url);
    }

    // 条件クリア時の処理
    void clearParameter() {
      ref.read(searchParameterProvider.notifier).update((state) => params.clearSelectedParameter());
      ref.read(targetUrlProvider.notifier).update((state) => CpuCoolerSearchParser.standardPage);
    }

    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: widget._mainColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: <Widget>[
                Text(
                  'メーカー',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'intel\nソケット',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'AMD\nソケット',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'タイプ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: widget._mainColor,
            ),
            child: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget._subColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListView(
                      children: [
                        for (int i = 0; i < params.makers.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Checkbox(
                                value: params.makers[i].isSelect,
                                activeColor: widget._mainColor,
                                onChanged: (bool? value) {
                                  params.makers[i].isSelect = value!;
                                  ref.read(searchParameterProvider.notifier).update((state) => params);
                                  addParameter(params);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                params.makers[i].key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget._subColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListView(
                      children: [
                        for (int i = 0; i < params.intelSockets.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Checkbox(
                                value: params.intelSockets[i].isSelect,
                                activeColor: widget._mainColor,
                                onChanged: (bool? value) {
                                  params.intelSockets[i].isSelect = value!;
                                  ref.read(searchParameterProvider.notifier).update((state) => params);
                                  addParameter(params);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                params.intelSockets[i].key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget._subColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListView(
                      children: [
                        for (int i = 0; i < params.amdSockets.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Checkbox(
                                value: params.amdSockets[i].isSelect,
                                activeColor: widget._mainColor,
                                onChanged: (bool? value) {
                                  params.amdSockets[i].isSelect = value!;
                                  ref.read(searchParameterProvider.notifier).update((state) => params);
                                  addParameter(params);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                params.amdSockets[i].key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget._subColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListView(
                      children: [
                        for (int i = 0; i < params.type.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Checkbox(
                                value: params.type[i].isSelect,
                                activeColor: widget._mainColor,
                                onChanged: (bool? value) {
                                  params.type[i].isSelect = value!;
                                  ref.read(searchParameterProvider.notifier).update((state) => params);
                                  addParameter(params);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                params.type[i].key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 65,
            decoration: BoxDecoration(color: widget._mainColor),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        primary: widget._subColor,
                        onPrimary: widget._mainColor,
                      ),
                      onPressed: () {
                        clearParameter();
                      },
                      child: Text(
                        '条件をクリア',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget._mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        primary: widget._subColor,
                        onPrimary: widget._mainColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '戻る',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget._mainColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
