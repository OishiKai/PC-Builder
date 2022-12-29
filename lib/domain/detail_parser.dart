

import 'package:custom_pc/domain/base_parser.dart';
import 'package:html/dom.dart';
import 'package:custom_pc/models/pc_parts.dart';
class DetailParser extends BaseParser {
  PcParts targetParts;
  Document? document;

  DetailParser._(this.targetParts);
}
