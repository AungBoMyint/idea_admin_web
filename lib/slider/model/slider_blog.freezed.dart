// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider_blog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SliderBlog _$SliderBlogFromJson(Map<String, dynamic> json) {
  return _SliderBlog.fromJson(json);
}

/// @nodoc
mixin _$SliderBlog {
  int get id => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SliderBlogCopyWith<SliderBlog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderBlogCopyWith<$Res> {
  factory $SliderBlogCopyWith(
          SliderBlog value, $Res Function(SliderBlog) then) =
      _$SliderBlogCopyWithImpl<$Res, SliderBlog>;
  @useResult
  $Res call({int id, String body, String image});
}

/// @nodoc
class _$SliderBlogCopyWithImpl<$Res, $Val extends SliderBlog>
    implements $SliderBlogCopyWith<$Res> {
  _$SliderBlogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? body = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SliderBlogCopyWith<$Res>
    implements $SliderBlogCopyWith<$Res> {
  factory _$$_SliderBlogCopyWith(
          _$_SliderBlog value, $Res Function(_$_SliderBlog) then) =
      __$$_SliderBlogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String body, String image});
}

/// @nodoc
class __$$_SliderBlogCopyWithImpl<$Res>
    extends _$SliderBlogCopyWithImpl<$Res, _$_SliderBlog>
    implements _$$_SliderBlogCopyWith<$Res> {
  __$$_SliderBlogCopyWithImpl(
      _$_SliderBlog _value, $Res Function(_$_SliderBlog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? body = null,
    Object? image = null,
  }) {
    return _then(_$_SliderBlog(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SliderBlog implements _SliderBlog {
  _$_SliderBlog({required this.id, required this.body, required this.image});

  factory _$_SliderBlog.fromJson(Map<String, dynamic> json) =>
      _$$_SliderBlogFromJson(json);

  @override
  final int id;
  @override
  final String body;
  @override
  final String image;

  @override
  String toString() {
    return 'SliderBlog(id: $id, body: $body, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SliderBlog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, body, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SliderBlogCopyWith<_$_SliderBlog> get copyWith =>
      __$$_SliderBlogCopyWithImpl<_$_SliderBlog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SliderBlogToJson(
      this,
    );
  }
}

abstract class _SliderBlog implements SliderBlog {
  factory _SliderBlog(
      {required final int id,
      required final String body,
      required final String image}) = _$_SliderBlog;

  factory _SliderBlog.fromJson(Map<String, dynamic> json) =
      _$_SliderBlog.fromJson;

  @override
  int get id;
  @override
  String get body;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_SliderBlogCopyWith<_$_SliderBlog> get copyWith =>
      throw _privateConstructorUsedError;
}
