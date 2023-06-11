import 'package:custom_pc/models/parts_shop.dart';

// class PcPartsOld {
//   // データ取得状況
//   FilledDataProgress dataFiled = FilledDataProgress.filledForList;

//   // パーツ一覧画面表示に必要なデータ
//   final String maker;
//   final bool isNew;
//   final String title;
//   final int? star;
//   final String? evaluation;
//   final String price;
//   final String ranked;
//   final String image;
//   final String detailUrl;

//   // パーツ詳細画面表示に必要なデータ
//   List<PartsShop>? shops;
//   Map<String, String?>? specs;
//   List<String>? fullScaleImages;

//   PcPartsOld(
//     this.maker,
//     this.isNew,
//     this.title,
//     this.star,
//     this.evaluation,
//     this.price,
//     this.ranked,
//     this.image,
//     this.detailUrl,
//   );

//   void updateProgress() {
//     if (fullScaleImages != null) {
//       dataFiled = FilledDataProgress.filledForDetail;
//     }
//   }
// }

// enum FilledDataProgress {
//   filledForList,
//   filledForDetail,
// }

// enum PartsCategory {
//   cpu('CPU', 'CPU','cpu'),
//   cpuCooler('CPUクーラー', 'CPUクーラー','2C0030'),
//   memory('メモリー', 'メモリ','2C0033'),
//   motherBoard('マザーボード', 'マザボ','2C0036'),
//   graphicsCard('グラフィックボード・ビデオカード', 'グラボ','2C0028'),
//   ssd('SSD', 'SSD','2C0070'),
//   pcCase('PCケース', 'ケース','2C0032'),
//   powerUnit('電源ユニット', '電源','2C0035'),
//   caseFan('ケースファン', 'ケースファン','2C0089');

//   final String categoryName;
//   final String categoryShortName;
//   final String categoryParameter;
//   const PartsCategory(this.categoryName, this.categoryShortName, this.categoryParameter);
// }
