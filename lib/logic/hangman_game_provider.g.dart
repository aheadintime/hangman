// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hangman_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hangmanGameHash() => r'0a2fa427bf7586b8585dc047e95cc5e8a0915d42';

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

abstract class _$HangmanGame
    extends BuildlessAutoDisposeNotifier<HangmanGameState> {
  late final String word;

  HangmanGameState build(String word);
}

/// See also [HangmanGame].
@ProviderFor(HangmanGame)
const hangmanGameProvider = HangmanGameFamily();

/// See also [HangmanGame].
class HangmanGameFamily extends Family<HangmanGameState> {
  /// See also [HangmanGame].
  const HangmanGameFamily();

  /// See also [HangmanGame].
  HangmanGameProvider call(String word) {
    return HangmanGameProvider(word);
  }

  @override
  HangmanGameProvider getProviderOverride(
    covariant HangmanGameProvider provider,
  ) {
    return call(provider.word);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hangmanGameProvider';
}

/// See also [HangmanGame].
class HangmanGameProvider
    extends AutoDisposeNotifierProviderImpl<HangmanGame, HangmanGameState> {
  /// See also [HangmanGame].
  HangmanGameProvider(String word)
    : this._internal(
        () => HangmanGame()..word = word,
        from: hangmanGameProvider,
        name: r'hangmanGameProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$hangmanGameHash,
        dependencies: HangmanGameFamily._dependencies,
        allTransitiveDependencies: HangmanGameFamily._allTransitiveDependencies,
        word: word,
      );

  HangmanGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.word,
  }) : super.internal();

  final String word;

  @override
  HangmanGameState runNotifierBuild(covariant HangmanGame notifier) {
    return notifier.build(word);
  }

  @override
  Override overrideWith(HangmanGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: HangmanGameProvider._internal(
        () => create()..word = word,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        word: word,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HangmanGame, HangmanGameState>
  createElement() {
    return _HangmanGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HangmanGameProvider && other.word == word;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, word.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HangmanGameRef on AutoDisposeNotifierProviderRef<HangmanGameState> {
  /// The parameter `word` of this provider.
  String get word;
}

class _HangmanGameProviderElement
    extends AutoDisposeNotifierProviderElement<HangmanGame, HangmanGameState>
    with HangmanGameRef {
  _HangmanGameProviderElement(super.provider);

  @override
  String get word => (origin as HangmanGameProvider).word;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
