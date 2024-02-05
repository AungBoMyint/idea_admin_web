// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messenger_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessengerLink _$MessengerLinkFromJson(Map<String, dynamic> json) {
  return _MessengerLink.fromJson(json);
}

/// @nodoc
mixin _$MessengerLink {
  String get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessengerLinkCopyWith<MessengerLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessengerLinkCopyWith<$Res> {
  factory $MessengerLinkCopyWith(
          MessengerLink value, $Res Function(MessengerLink) then) =
      _$MessengerLinkCopyWithImpl<$Res, MessengerLink>;
  @useResult
  $Res call({String link});
}

/// @nodoc
class _$MessengerLinkCopyWithImpl<$Res, $Val extends MessengerLink>
    implements $MessengerLinkCopyWith<$Res> {
  _$MessengerLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessengerLinkCopyWith<$Res>
    implements $MessengerLinkCopyWith<$Res> {
  factory _$$_MessengerLinkCopyWith(
          _$_MessengerLink value, $Res Function(_$_MessengerLink) then) =
      __$$_MessengerLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link});
}

/// @nodoc
class __$$_MessengerLinkCopyWithImpl<$Res>
    extends _$MessengerLinkCopyWithImpl<$Res, _$_MessengerLink>
    implements _$$_MessengerLinkCopyWith<$Res> {
  __$$_MessengerLinkCopyWithImpl(
      _$_MessengerLink _value, $Res Function(_$_MessengerLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$_MessengerLink(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessengerLink implements _MessengerLink {
  _$_MessengerLink({required this.link});

  factory _$_MessengerLink.fromJson(Map<String, dynamic> json) =>
      _$$_MessengerLinkFromJson(json);

  @override
  final String link;

  @override
  String toString() {
    return 'MessengerLink(link: $link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessengerLink &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessengerLinkCopyWith<_$_MessengerLink> get copyWith =>
      __$$_MessengerLinkCopyWithImpl<_$_MessengerLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessengerLinkToJson(
      this,
    );
  }
}

abstract class _MessengerLink implements MessengerLink {
  factory _MessengerLink({required final String link}) = _$_MessengerLink;

  factory _MessengerLink.fromJson(Map<String, dynamic> json) =
      _$_MessengerLink.fromJson;

  @override
  String get link;
  @override
  @JsonKey(ignore: true)
  _$$_MessengerLinkCopyWith<_$_MessengerLink> get copyWith =>
      throw _privateConstructorUsedError;
}
