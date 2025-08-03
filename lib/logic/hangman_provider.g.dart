// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hangman_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hangmanHash() => r'aaa30dfadbeff4f580c44696b04a6cc05a24a6ef';

/// See also [Hangman].
@ProviderFor(Hangman)
final hangmanProvider =
    AutoDisposeNotifierProvider<Hangman, HangmanState>.internal(
      Hangman.new,
      name: r'hangmanProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$hangmanHash,
      dependencies: <ProviderOrFamily>[hangmanGameProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        hangmanGameProvider,
        ...?hangmanGameProvider.allTransitiveDependencies,
      },
    );

typedef _$Hangman = AutoDisposeNotifier<HangmanState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
