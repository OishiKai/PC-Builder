// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pc_parts_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$PcPartsListNotifierHash() =>
    r'40b64361cafcde48c1c20efc68f8aa1bea6036e7';

/// See also [PcPartsListNotifier].
final pcPartsListNotifierProvider =
    AsyncNotifierProvider<PcPartsListNotifier, List<PcParts>>(
  PcPartsListNotifier.new,
  name: r'pcPartsListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$PcPartsListNotifierHash,
);
typedef PcPartsListNotifierRef = AsyncNotifierProviderRef<List<PcParts>>;

abstract class _$PcPartsListNotifier extends AsyncNotifier<List<PcParts>> {
  @override
  FutureOr<List<PcParts>> build();
}
