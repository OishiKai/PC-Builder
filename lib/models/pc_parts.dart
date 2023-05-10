import 'package:custom_pc/models/parts_shop.dart';

class PcParts {
  FilledDataProgress dataFiled = FilledDataProgress.filledForList;

  final String maker;
  final bool isNew;
  final String title;
  final int? star;
  final String? evaluation;
  final String price;
  final String ranked;
  final String image;
  final String detailUrl;

  List<PartsShop>? shops;
  Map<String, String?>? specs;
  List<String>? fullScaleImages;

  PcParts(
    this.maker,
    this.isNew,
    this.title,
    this.star,
    this.evaluation,
    this.price,
    this.ranked,
    this.image,
    this.detailUrl,
  );

  void updateProgress() {
    if (fullScaleImages != null) {
      dataFiled = FilledDataProgress.filledForDetail;
    }
  }
}

enum FilledDataProgress {
  filledForList,
  filledForDetail,
}

enum PartsCategory {
  cpu('CPU', 'cpu'),
  cpuCooler('CPUクーラー', '2C0030'),
  memory('メモリー', '2C0033'),
  motherBoard('マザーボード', '2C0036'),
  graphicsCard('グラフィックボード・ビデオカード', '2C0028'),
  ssd('SSD', '2C0070'),
  pcCase('PCケース', '2C0032'),
  powerUnit('電源ユニット', '2C0035'),
  caseFan('ケースファン', '2C0089');

  final String categoryName;
  final String categoryParameter;
  const PartsCategory(this.categoryName, this.categoryParameter);
}
