// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'youtube_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

YoutubeLink _$YoutubeLinkFromJson(Map<String, dynamic> json) {
  return _YoutubeLink.fromJson(json);
}

/// @nodoc
mixin _$YoutubeLink {
  int get id => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YoutubeLinkCopyWith<YoutubeLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeLinkCopyWith<$Res> {
  factory $YoutubeLinkCopyWith(
          YoutubeLink value, $Res Function(YoutubeLink) then) =
      _$YoutubeLinkCopyWithImpl<$Res, YoutubeLink>;
  @useResult
  $Res call({int id, String link});
}

/// @nodoc
class _$YoutubeLinkCopyWithImpl<$Res, $Val extends YoutubeLink>
    implements $YoutubeLinkCopyWith<$Res> {
  _$YoutubeLinkCopyWithImpl(this._value, this._then);

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
abstract class _$$_YoutubeLinkCopyWith<$Res>
    implements $YoutubeLinkCopyWith<$Res> {
  factory _$$_YoutubeLinkCopyWith(
          _$_YoutubeLink value, $Res Function(_$_YoutubeLink) then) =
      __$$_YoutubeLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String link});
}

/// @nodoc
class __$$_YoutubeLinkCopyWithImpl<$Res>
    extends _$YoutubeLinkCopyWithImpl<$Res, _$_YoutubeLink>
    implements _$$_YoutubeLinkCopyWith<$Res> {
  __$$_YoutubeLinkCopyWithImpl(
      _$_YoutubeLink _value, $Res Function(_$_YoutubeLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? link = null,
  }) {
    return _then(_$_YoutubeLink(
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
class _$_YoutubeLink implements _YoutubeLink {
  _$_YoutubeLink({required this.id, required this.link});

  factory _$_YoutubeLink.fromJson(Map<String, dynamic> json) =>
      _$$_YoutubeLinkFromJson(json);

  @override
  final int id;
  @override
  final String link;

  @override
  String toString() {
    return 'YoutubeLink(id: $id, link: $link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_YoutubeLink &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_YoutubeLinkCopyWith<_$_YoutubeLink> get copyWith =>
      __$$_YoutubeLinkCopyWithImpl<_$_YoutubeLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_YoutubeLinkToJson(
      this,
    );
  }
}

abstract class _YoutubeLink implements YoutubeLink {
  factory _YoutubeLink({required final int id, required final String link}) =
      _$_YoutubeLink;

  factory _YoutubeLink.fromJson(Map<String, dynamic> json) =
      _$_YoutubeLink.fromJson;

  @override
  int get id;
  @override
  String get link;
  @override
  @JsonKey(ignore: true)
  _$$_YoutubeLinkCopyWith<_$_YoutubeLink> get copyWith =>
      throw _privateConstructorUsedError;
}
