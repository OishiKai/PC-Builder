// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../custom_repository.dart';

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

String _$CustomRepositoryNotifierHash() => r'0017cae427c142baea1cc900d9df93f1bd3b2750';

/// See also [CustomRepositoryNotifier].
final customRepositoryNotifierProvider = AutoDisposeAsyncNotifierProvider<CustomRepositoryNotifier, List<Custom>>(
  CustomRepositoryNotifier.new,
  name: r'customRepositoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$CustomRepositoryNotifierHash,
);
typedef CustomRepositoryNotifierRef = AutoDisposeAsyncNotifierProviderRef<List<Custom>>;

abstract class _$CustomRepositoryNotifier extends AutoDisposeAsyncNotifier<List<Custom>> {
  @override
  FutureOr<List<Custom>> build();
}
