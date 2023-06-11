import 'package:custom_pc/rebased/domain/parts_list_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/pc_parts.dart';

part 'pc_parts_list.g.dart';

@Riverpod(keepAlive: true)
class PcPartsListNotifier extends _$PcPartsListNotifier {
  @override
  Future<List<PcParts>> build() {
    final standardPartsList = PartsListParser.fetch('https://kakaku.com/pc/cpu/itemlist.aspx');
    return standardPartsList;
  }

  // 検索対象のURLを変更する
  void replaceSearchUrl(String listUrl) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return PartsListParser.fetch(listUrl);
    });
  }

  // 詳細ページ情報を追加する
  void updateState(List<PcParts> partsList) {
    state = AsyncValue.data(partsList);
  }
}