// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimpleCourse _$SimpleCourseFromJson(Map<String, dynamic> json) {
  return _SimpleCourse.fromJson(json);
}

/// @nodoc
mixin _$SimpleCourse {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimpleCourseCopyWith<SimpleCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleCourseCopyWith<$Res> {
  factory $SimpleCourseCopyWith(
          SimpleCourse value, $Res Function(SimpleCourse) then) =
      _$SimpleCourseCopyWithImpl<$Res, SimpleCourse>;
  @useResult
  $Res call({int id, String title, String image});
}

/// @nodoc
class _$SimpleCourseCopyWithImpl<$Res, $Val extends SimpleCourse>
    implements $SimpleCourseCopyWith<$Res> {
  _$SimpleCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimpleCourseCopyWith<$Res>
    implements $SimpleCourseCopyWith<$Res> {
  factory _$$_SimpleCourseCopyWith(
          _$_SimpleCourse value, $Res Function(_$_SimpleCourse) then) =
      __$$_SimpleCourseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, String image});
}

/// @nodoc
class __$$_SimpleCourseCopyWithImpl<$Res>
    extends _$SimpleCourseCopyWithImpl<$Res, _$_SimpleCourse>
    implements _$$_SimpleCourseCopyWith<$Res> {
  __$$_SimpleCourseCopyWithImpl(
      _$_SimpleCourse _value, $Res Function(_$_SimpleCourse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_$_SimpleCourse(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$_SimpleCourse implements _SimpleCourse {
  _$_SimpleCourse({required this.id, required this.title, required this.image});

  factory _$_SimpleCourse.fromJson(Map<String, dynamic> json) =>
      _$$_SimpleCourseFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String image;

  @override
  String toString() {
    return 'SimpleCourse(id: $id, title: $title, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimpleCourse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimpleCourseCopyWith<_$_SimpleCourse> get copyWith =>
      __$$_SimpleCourseCopyWithImpl<_$_SimpleCourse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimpleCourseToJson(
      this,
    );
  }
}

abstract class _SimpleCourse implements SimpleCourse {
  factory _SimpleCourse(
      {required final int id,
      required final String title,
      required final String image}) = _$_SimpleCourse;

  factory _SimpleCourse.fromJson(Map<String, dynamic> json) =
      _$_SimpleCourse.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_SimpleCourseCopyWith<_$_SimpleCourse> get copyWith =>
      throw _privateConstructorUsedError;
}
