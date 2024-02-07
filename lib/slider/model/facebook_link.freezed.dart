// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facebook_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FacebookLink _$FacebookLinkFromJson(Map<String, dynamic> json) {
  return _FacebookLink.fromJson(json);
}

/// @nodoc
mixin _$FacebookLink {
  int get id => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FacebookLinkCopyWith<FacebookLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacebookLinkCopyWith<$Res> {
  factory $FacebookLinkCopyWith(
          FacebookLink value, $Res Function(FacebookLink) then) =
      _$FacebookLinkCopyWithImpl<$Res, FacebookLink>;
  @useResult
  $Res call({int id, String link});
}

/// @nodoc
class _$FacebookLinkCopyWithImpl<$Res, $Val extends FacebookLink>
    implements $FacebookLinkCopyWith<$Res> {
  _$FacebookLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FacebookLinkCopyWith<$Res>
    implements $FacebookLinkCopyWith<$Res> {
  factory _$$_FacebookLinkCopyWith(
          _$_FacebookLink value, $Res Function(_$_FacebookLink) then) =
      __$$_FacebookLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String link});
}

/// @nodoc
class __$$_FacebookLinkCopyWithImpl<$Res>
    extends _$FacebookLinkCopyWithImpl<$Res, _$_FacebookLink>
    implements _$$_FacebookLinkCopyWith<$Res> {
  __$$_FacebookLinkCopyWithImpl(
      _$_FacebookLink _value, $Res Function(_$_FacebookLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? link = null,
  }) {
    return _then(_$_FacebookLink(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FacebookLink implements _FacebookLink {
  _$_FacebookLink({required this.id, required this.link});

  factory _$_FacebookLink.fromJson(Map<String, dynamic> json) =>
      _$$_FacebookLinkFromJson(json);

  @override
  final int id;
  @override
  final String link;

  @override
  String toString() {
    return 'FacebookLink(id: $id, link: $link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FacebookLink &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FacebookLinkCopyWith<_$_FacebookLink> get copyWith =>
      __$$_FacebookLinkCopyWithImpl<_$_FacebookLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FacebookLinkToJson(
      this,
    );
  }
}

abstract class _FacebookLink implements FacebookLink {
  factory _FacebookLink({required final int id, required final String link}) =
      _$_FacebookLink;

  factory _FacebookLink.fromJson(Map<String, dynamic> json) =
      _$_FacebookLink.fromJson;

  @override
  int get id;
  @override
  String get link;
  @override
  @JsonKey(ignore: true)
  _$$_FacebookLinkCopyWith<_$_FacebookLink> get copyWith =>
      throw _privateConstructorUsedError;
}
