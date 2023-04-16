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

