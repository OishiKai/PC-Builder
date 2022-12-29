import 'package:custom_pc/models/pc_parts.dart';

class PcPartsDetail extends PcParts{
  PcPartsDetail(PcParts parent) : super(parent.maker, parent.isNew, parent.title, parent.star, parent.evaluation, parent.price, parent.ranked, parent.image, parent.detailUrl);
}