enum PartsCategory {
  cpu('CPU', 'CPU', 'cpu'),
  cpuCooler('CPUクーラー', 'CPUクーラー', 'cpu-cooler'),
  memory('メモリー', 'メモリ', 'pc-memory'),
  motherboard('マザーボード', 'マザーボード', 'motherboard'),
  graphicsCard('グラフィックボード・ビデオカード', 'グラフィックボード', 'videocard'),
  ssd('SSD', 'SSD', 'ssd'),
  pcCase('PCケース', 'ケース', 'pc-case'),
  powerUnit('電源ユニット', '電源', 'power-supply'),
  caseFan('ケースファン', 'ケースファン', 'case-fan');

  final String categoryName;
  final String categoryShortName;
  final String categoryParameter;
  const PartsCategory(this.categoryName, this.categoryShortName, this.categoryParameter);

  String basePartsListUrl() {
    return 'https://kakaku.com/pc/$categoryParameter/itemlist.aspx';
  }

  static PartsCategory fromCategoryName(String categoryName) {
    switch (categoryName) {
      case 'CPU':
        return PartsCategory.cpu;
      case 'CPUクーラー':
        return PartsCategory.cpuCooler;
      case 'メモリー':
        return PartsCategory.memory;
      case 'マザーボード':
        return PartsCategory.motherboard;
      case 'グラフィックボード・ビデオカード':
        return PartsCategory.graphicsCard;
      case 'SSD':
        return PartsCategory.ssd;
      case 'PCケース':
        return PartsCategory.pcCase;
      case '電源ユニット':
        return PartsCategory.powerUnit;
      case 'ケースファン':
        return PartsCategory.caseFan;
      default:
        throw Exception('PartsCategory.fromCategoryName: $categoryName is not found.');
    }
  }

  static PartsCategory fromCategoryParameter(String categoryParameter) {
    switch (categoryParameter) {
      case 'cpu':
        return PartsCategory.cpu;
      case 'cpu-cooler':
        return PartsCategory.cpuCooler;
      case 'pc-memory':
        return PartsCategory.memory;
      case 'motherboard':
        return PartsCategory.motherboard;
      case 'videocard':
        return PartsCategory.graphicsCard;
      case 'ssd':
        return PartsCategory.ssd;
      case 'pc-case':
        return PartsCategory.pcCase;
      case 'power-supply':
        return PartsCategory.powerUnit;
      case 'case-fan':
        return PartsCategory.caseFan;
      default:
        throw Exception('PartsCategory.fromCategoryParameter: $categoryParameter is not found.');
    }
  }
}
