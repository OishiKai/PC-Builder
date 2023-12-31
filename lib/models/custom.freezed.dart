// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Custom {
  String? get id => throw _privateConstructorUsedError; // Custom名
  String? get name => throw _privateConstructorUsedError; // 総額
  String? get totalPrice => throw _privateConstructorUsedError; // 各パーツ
  PcParts? get cpu => throw _privateConstructorUsedError;
  PcParts? get cpuCooler => throw _privateConstructorUsedError;
  PcParts? get memory => throw _privateConstructorUsedError;
  PcParts? get motherBoard => throw _privateConstructorUsedError;
  PcParts? get graphicsCard => throw _privateConstructorUsedError;
  PcParts? get ssd => throw _privateConstructorUsedError;
  PcParts? get pcCase => throw _privateConstructorUsedError;
  PcParts? get powerUnit => throw _privateConstructorUsedError;
  PcParts? get caseFan => throw _privateConstructorUsedError; // 保存日
  String? get date => throw _privateConstructorUsedError; // 互換性のリスト
  List<PartsCompatibility>? get compatibilities => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomCopyWith<Custom> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomCopyWith<$Res> {
  factory $CustomCopyWith(Custom value, $Res Function(Custom) then) = _$CustomCopyWithImpl<$Res, Custom>;
  @useResult
  $Res call({String? id, String? name, String? totalPrice, PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan, String? date, List<PartsCompatibility>? compatibilities});

  $PcPartsCopyWith<$Res>? get cpu;
  $PcPartsCopyWith<$Res>? get cpuCooler;
  $PcPartsCopyWith<$Res>? get memory;
  $PcPartsCopyWith<$Res>? get motherBoard;
  $PcPartsCopyWith<$Res>? get graphicsCard;
  $PcPartsCopyWith<$Res>? get ssd;
  $PcPartsCopyWith<$Res>? get pcCase;
  $PcPartsCopyWith<$Res>? get powerUnit;
  $PcPartsCopyWith<$Res>? get caseFan;
}

/// @nodoc
class _$CustomCopyWithImpl<$Res, $Val extends Custom> implements $CustomCopyWith<$Res> {
  _$CustomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? totalPrice = freezed,
    Object? cpu = freezed,
    Object? cpuCooler = freezed,
    Object? memory = freezed,
    Object? motherBoard = freezed,
    Object? graphicsCard = freezed,
    Object? ssd = freezed,
    Object? pcCase = freezed,
    Object? powerUnit = freezed,
    Object? caseFan = freezed,
    Object? date = freezed,
    Object? compatibilities = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      cpu: freezed == cpu
          ? _value.cpu
          : cpu // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      cpuCooler: freezed == cpuCooler
          ? _value.cpuCooler
          : cpuCooler // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      memory: freezed == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      motherBoard: freezed == motherBoard
          ? _value.motherBoard
          : motherBoard // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      graphicsCard: freezed == graphicsCard
          ? _value.graphicsCard
          : graphicsCard // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      ssd: freezed == ssd
          ? _value.ssd
          : ssd // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      pcCase: freezed == pcCase
          ? _value.pcCase
          : pcCase // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      powerUnit: freezed == powerUnit
          ? _value.powerUnit
          : powerUnit // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      caseFan: freezed == caseFan
          ? _value.caseFan
          : caseFan // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      compatibilities: freezed == compatibilities
          ? _value.compatibilities
          : compatibilities // ignore: cast_nullable_to_non_nullable
              as List<PartsCompatibility>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get cpu {
    if (_value.cpu == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.cpu!, (value) {
      return _then(_value.copyWith(cpu: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get cpuCooler {
    if (_value.cpuCooler == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.cpuCooler!, (value) {
      return _then(_value.copyWith(cpuCooler: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get memory {
    if (_value.memory == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.memory!, (value) {
      return _then(_value.copyWith(memory: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get motherBoard {
    if (_value.motherBoard == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.motherBoard!, (value) {
      return _then(_value.copyWith(motherBoard: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get graphicsCard {
    if (_value.graphicsCard == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.graphicsCard!, (value) {
      return _then(_value.copyWith(graphicsCard: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get ssd {
    if (_value.ssd == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.ssd!, (value) {
      return _then(_value.copyWith(ssd: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get pcCase {
    if (_value.pcCase == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.pcCase!, (value) {
      return _then(_value.copyWith(pcCase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get powerUnit {
    if (_value.powerUnit == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.powerUnit!, (value) {
      return _then(_value.copyWith(powerUnit: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PcPartsCopyWith<$Res>? get caseFan {
    if (_value.caseFan == null) {
      return null;
    }

    return $PcPartsCopyWith<$Res>(_value.caseFan!, (value) {
      return _then(_value.copyWith(caseFan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CustomCopyWith<$Res> implements $CustomCopyWith<$Res> {
  factory _$$_CustomCopyWith(_$_Custom value, $Res Function(_$_Custom) then) = __$$_CustomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, String? totalPrice, PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan, String? date, List<PartsCompatibility>? compatibilities});

  @override
  $PcPartsCopyWith<$Res>? get cpu;
  @override
  $PcPartsCopyWith<$Res>? get cpuCooler;
  @override
  $PcPartsCopyWith<$Res>? get memory;
  @override
  $PcPartsCopyWith<$Res>? get motherBoard;
  @override
  $PcPartsCopyWith<$Res>? get graphicsCard;
  @override
  $PcPartsCopyWith<$Res>? get ssd;
  @override
  $PcPartsCopyWith<$Res>? get pcCase;
  @override
  $PcPartsCopyWith<$Res>? get powerUnit;
  @override
  $PcPartsCopyWith<$Res>? get caseFan;
}

/// @nodoc
class __$$_CustomCopyWithImpl<$Res> extends _$CustomCopyWithImpl<$Res, _$_Custom> implements _$$_CustomCopyWith<$Res> {
  __$$_CustomCopyWithImpl(_$_Custom _value, $Res Function(_$_Custom) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? totalPrice = freezed,
    Object? cpu = freezed,
    Object? cpuCooler = freezed,
    Object? memory = freezed,
    Object? motherBoard = freezed,
    Object? graphicsCard = freezed,
    Object? ssd = freezed,
    Object? pcCase = freezed,
    Object? powerUnit = freezed,
    Object? caseFan = freezed,
    Object? date = freezed,
    Object? compatibilities = freezed,
  }) {
    return _then(_$_Custom(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      cpu: freezed == cpu
          ? _value.cpu
          : cpu // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      cpuCooler: freezed == cpuCooler
          ? _value.cpuCooler
          : cpuCooler // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      memory: freezed == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      motherBoard: freezed == motherBoard
          ? _value.motherBoard
          : motherBoard // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      graphicsCard: freezed == graphicsCard
          ? _value.graphicsCard
          : graphicsCard // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      ssd: freezed == ssd
          ? _value.ssd
          : ssd // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      pcCase: freezed == pcCase
          ? _value.pcCase
          : pcCase // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      powerUnit: freezed == powerUnit
          ? _value.powerUnit
          : powerUnit // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      caseFan: freezed == caseFan
          ? _value.caseFan
          : caseFan // ignore: cast_nullable_to_non_nullable
              as PcParts?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      compatibilities: freezed == compatibilities
          ? _value._compatibilities
          : compatibilities // ignore: cast_nullable_to_non_nullable
              as List<PartsCompatibility>?,
    ));
  }
}

/// @nodoc

class _$_Custom implements _Custom {
  const _$_Custom({this.id, this.name, this.totalPrice, this.cpu, this.cpuCooler, this.memory, this.motherBoard, this.graphicsCard, this.ssd, this.pcCase, this.powerUnit, this.caseFan, this.date, final List<PartsCompatibility>? compatibilities}) : _compatibilities = compatibilities;

  @override
  final String? id;
// Custom名
  @override
  final String? name;
// 総額
  @override
  final String? totalPrice;
// 各パーツ
  @override
  final PcParts? cpu;
  @override
  final PcParts? cpuCooler;
  @override
  final PcParts? memory;
  @override
  final PcParts? motherBoard;
  @override
  final PcParts? graphicsCard;
  @override
  final PcParts? ssd;
  @override
  final PcParts? pcCase;
  @override
  final PcParts? powerUnit;
  @override
  final PcParts? caseFan;
// 保存日
  @override
  final String? date;
// 互換性のリスト
  final List<PartsCompatibility>? _compatibilities;
// 互換性のリスト
  @override
  List<PartsCompatibility>? get compatibilities {
    final value = _compatibilities;
    if (value == null) return null;
    if (_compatibilities is EqualUnmodifiableListView) return _compatibilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Custom(id: $id, name: $name, totalPrice: $totalPrice, cpu: $cpu, cpuCooler: $cpuCooler, memory: $memory, motherBoard: $motherBoard, graphicsCard: $graphicsCard, ssd: $ssd, pcCase: $pcCase, powerUnit: $powerUnit, caseFan: $caseFan, date: $date, compatibilities: $compatibilities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Custom && (identical(other.id, id) || other.id == id) && (identical(other.name, name) || other.name == name) && (identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice) && (identical(other.cpu, cpu) || other.cpu == cpu) && (identical(other.cpuCooler, cpuCooler) || other.cpuCooler == cpuCooler) && (identical(other.memory, memory) || other.memory == memory) && (identical(other.motherBoard, motherBoard) || other.motherBoard == motherBoard) && (identical(other.graphicsCard, graphicsCard) || other.graphicsCard == graphicsCard) && (identical(other.ssd, ssd) || other.ssd == ssd) && (identical(other.pcCase, pcCase) || other.pcCase == pcCase) && (identical(other.powerUnit, powerUnit) || other.powerUnit == powerUnit) && (identical(other.caseFan, caseFan) || other.caseFan == caseFan) && (identical(other.date, date) || other.date == date) && const DeepCollectionEquality().equals(other._compatibilities, _compatibilities));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, totalPrice, cpu, cpuCooler, memory, motherBoard, graphicsCard, ssd, pcCase, powerUnit, caseFan, date, const DeepCollectionEquality().hash(_compatibilities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomCopyWith<_$_Custom> get copyWith => __$$_CustomCopyWithImpl<_$_Custom>(this, _$identity);

  @override
  Map<PartsCategory, PcParts> align() {
    Map<PartsCategory, PcParts> alignedParts = {};

    if (cpu != null) {
      alignedParts[PartsCategory.cpu] = cpu!;
    }

    if (cpuCooler != null) {
      alignedParts[PartsCategory.cpuCooler] = cpuCooler!;
    }

    if (memory != null) {
      alignedParts[PartsCategory.memory] = memory!;
    }

    if (motherBoard != null) {
      alignedParts[PartsCategory.motherboard] = motherBoard!;
    }

    if (graphicsCard != null) {
      alignedParts[PartsCategory.graphicsCard] = graphicsCard!;
    }

    if (ssd != null) {
      alignedParts[PartsCategory.ssd] = ssd!;
    }

    if (pcCase != null) {
      alignedParts[PartsCategory.pcCase] = pcCase!;
    }

    if (powerUnit != null) {
      alignedParts[PartsCategory.powerUnit] = powerUnit!;
    }

    if (caseFan != null) {
      alignedParts[PartsCategory.caseFan] = caseFan!;
    }

    return alignedParts;
  }

  @override
  int calculateTotalPrice() {
    int totalPrice = 0;

    if (cpu != null) {
      totalPrice += parsePrice(cpu!.price);
    }
    if (cpuCooler != null) {
      totalPrice += parsePrice(cpuCooler!.price);
    }
    if (memory != null) {
      totalPrice += parsePrice(memory!.price);
    }
    if (motherBoard != null) {
      totalPrice += parsePrice(motherBoard!.price);
    }
    if (graphicsCard != null) {
      totalPrice += parsePrice(graphicsCard!.price);
    }
    if (ssd != null) {
      totalPrice += parsePrice(ssd!.price);
    }
    if (pcCase != null) {
      totalPrice += parsePrice(pcCase!.price);
    }
    if (powerUnit != null) {
      totalPrice += parsePrice(powerUnit!.price);
    }
    if (caseFan != null) {
      totalPrice += parsePrice(caseFan!.price);
    }

    return totalPrice;
  }

  @override
  String formatPrice() {
    final String stringValue = calculateTotalPrice().toString();
    final StringBuffer buffer = StringBuffer();

    buffer.write('¥');

    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }

    return buffer.toString();
  }

  @override
  PcParts? get(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return cpu;
      case PartsCategory.cpuCooler:
        return cpuCooler;
      case PartsCategory.memory:
        return memory;
      case PartsCategory.motherboard:
        return motherBoard;
      case PartsCategory.graphicsCard:
        return graphicsCard;
      case PartsCategory.ssd:
        return ssd;
      case PartsCategory.pcCase:
        return pcCase;
      case PartsCategory.powerUnit:
        return powerUnit;
      case PartsCategory.caseFan:
        return caseFan;
    }
  }

  @override
  String getMainPartsImage() {
    final alignedParts = align();
    // 最も高い価格のパーツを取得
    final parts = alignedParts.values.reduce((a, b) => parsePrice(a.price) > parsePrice(b.price) ? a : b);
    return parts.image;
  }

  @override
  bool isEmpty() {
    return cpu == null && cpuCooler == null && memory == null && motherBoard == null && graphicsCard == null && ssd == null && pcCase == null && powerUnit == null && caseFan == null;
  }

  @override
  int parsePrice(String price) {
    final normalizedPrice = price.trim().replaceAll('¥', '').replaceAll(',', '');
    return normalizedPrice.isEmpty ? 0 : int.parse(normalizedPrice);
  }

  @override
  Custom updateCompatibilities() {
    List<PartsCompatibility> comps = [];
    // 互換性チェック
    if (cpu != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuAndMotherBoard(cpu: cpu!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (cpuCooler != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuCoolerAndMotherBoard(cpuCooler: cpuCooler!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (memory != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMemoryAndMotherBoard(memory: memory!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (motherBoard != null && ssd != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMotherBoardAndSsd(motherBoard: motherBoard!, ssd: ssd!);
      comps.add(compatibility);
    }
    return copyWith(compatibilities: comps);
  }
}

abstract class _Custom implements Custom {
  const factory _Custom({final String? id, final String? name, final String? totalPrice, final PcParts? cpu, final PcParts? cpuCooler, final PcParts? memory, final PcParts? motherBoard, final PcParts? graphicsCard, final PcParts? ssd, final PcParts? pcCase, final PcParts? powerUnit, final PcParts? caseFan, final String? date, final List<PartsCompatibility>? compatibilities}) = _$_Custom;

  @override
  String? get id;
  @override // Custom名
  String? get name;
  @override // 総額
  String? get totalPrice;
  @override // 各パーツ
  PcParts? get cpu;
  @override
  PcParts? get cpuCooler;
  @override
  PcParts? get memory;
  @override
  PcParts? get motherBoard;
  @override
  PcParts? get graphicsCard;
  @override
  PcParts? get ssd;
  @override
  PcParts? get pcCase;
  @override
  PcParts? get powerUnit;
  @override
  PcParts? get caseFan;
  @override // 保存日
  String? get date;
  @override // 互換性のリスト
  List<PartsCompatibility>? get compatibilities;
  @override
  @JsonKey(ignore: true)
  _$$_CustomCopyWith<_$_Custom> get copyWith => throw _privateConstructorUsedError;
}
