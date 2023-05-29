import 'package:custom_pc/domain/compatibility_analyzer.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  final num = 1;

  final PcParts cpu = PcParts(
    'インテル', 
    false, 
    'Core i7 13700K', 
    4,
    'evaluation',
    'price',
    'ranked', 
    'image', 
    'detailUrl');

  cpu.specs = {
    'ソケット形状': 'LGA1200',
  };

  final motherboad = PcParts(
    'ASUS', 
    false, 
    'ROG STRIX Z590-E GAMING WIFI', 
    4,
    'evaluation',
    'price',
    'ranked', 
    'image', 
    'detailUrl');
  
  motherboad.specs = {
    'CPUソケット': 'LGA1200',
  };

  test('test', () {
    final compatibility = CompatibilityAnalyzer.analyzeCpuAndMotherBoard(cpu: cpu, motherBoard: motherboad);
    expect(compatibility.isCompatible['ソケット形状'], isTrue);
  });
}