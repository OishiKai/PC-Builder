import 'package:custom_pc/domain/database/datastore_use_case.dart';
import 'package:custom_pc/domain/database/pc_parts_repository.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../models/custom.dart';

class CustomRepository {
  //Custom保存
  static Future<int> insertCustom(Custom custom) async {
    // custom_idを生成
    final customId = const Uuid().v4();
    // 含まれるパーツのidを保持するMap
    Map<PartsCategory, Future<int>> partsIdMap = {};

    custom.align().forEach((category, parts) {
      // 各パーツを保存して、idを保持
      final partsId = PcPartsRepository.insertPcParts(parts, customId);
      partsIdMap[category] = partsId;
    });

    final db = await DataStoreUseCase.database;

    final map = {
      'id': customId,
      'name': custom.name,
      'price': custom.calculateTotalPrice(),
      'cpu_id': await partsIdMap[PartsCategory.cpu],
      'cpu_cooler_id': await partsIdMap[PartsCategory.cpuCooler],
      'memory_id': await partsIdMap[PartsCategory.memory],
      'mother_board_id': await partsIdMap[PartsCategory.motherBoard],
      'graphics_card_id': await partsIdMap[PartsCategory.graphicsCard],
      'ssd_id': await partsIdMap[PartsCategory.ssd],
      'pc_case_id': await partsIdMap[PartsCategory.pcCase],
      'power_unit_id': await partsIdMap[PartsCategory.powerUnit],
      'case_fan_id': await partsIdMap[PartsCategory.caseFan],
      'date': '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
    };
    // カスタム情報を保存
    return db.insert(
      'custom',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Custom取得
  static Future<Map<String, Custom>> getAllCustoms() async {
    final db = await DataStoreUseCase.database;
    final stored = await db.query('custom');
    if (stored.isEmpty) return {};

    final Map<String, Custom> customList = {};
    for (var custom in stored) {
      final id = custom['id'] as String;
      final name = custom['name'] as String;
      final price = custom['price'] as String;
      final date = custom['date'] as String;

      final cpu = await PcPartsRepository.selectPcPartsById(custom['cpu_id'] as int?);
      final cpuCooler = await PcPartsRepository.selectPcPartsById(custom['cpu_cooler_id'] as int?);
      final memory = await PcPartsRepository.selectPcPartsById(custom['memory_id'] as int?);
      final motherBoard = await PcPartsRepository.selectPcPartsById(custom['mother_board_id'] as int?);
      final graphicsCard = await PcPartsRepository.selectPcPartsById(custom['graphics_card_id'] as int?);
      final ssd = await PcPartsRepository.selectPcPartsById(custom['ssd_id'] as int?);
      final pcCase = await PcPartsRepository.selectPcPartsById(custom['pc_case_id'] as int?);
      final powerUnit = await PcPartsRepository.selectPcPartsById(custom['power_unit_id'] as int?);
      final caseFan = await PcPartsRepository.selectPcPartsById(custom['case_fan_id'] as int?);

      customList[id] = Custom(
        name: name,
        totalPrice: price,
        cpu: cpu,
        cpuCooler: cpuCooler,
        memory: memory,
        motherBoard: motherBoard,
        graphicsCard: graphicsCard,
        ssd: ssd,
        pcCase: pcCase,
        powerUnit: powerUnit,
        caseFan: caseFan,
        date: date,
      );
    }
    return customList;
  }
}
