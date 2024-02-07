// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CourseLink _$CourseLinkFromJson(Map<String, dynamic> json) {
  return _CourseLink.fromJson(json);
}

/// @nodoc
mixin _$CourseLink {
  int get id => throw _privateConstructorUsedError;
  List<Course>? get course => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseLinkCopyWith<CourseLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseLinkCopyWith<$Res> {
  factory $CourseLinkCopyWith(
          CourseLink value, $Res Function(CourseLink) then) =
      _$CourseLinkCopyWithImpl<$Res, CourseLink>;
  @useResult
  $Res call({int id, List<Course>? course});
}

/// @nodoc
class _$CourseLinkCopyWithImpl<$Res, $Val extends CourseLink>
    implements $CourseLinkCopyWith<$Res> {
  _$CourseLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? course = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      course: freezed == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as List<Course>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CourseLinkCopyWith<$Res>
    implements $CourseLinkCopyWith<$Res> {
  factory _$$_CourseLinkCopyWith(
          _$_CourseLink value, $Res Function(_$_CourseLink) then) =
      __$$_CourseLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, List<Course>? course});
}

/// @nodoc
class __$$_CourseLinkCopyWithImpl<$Res>
    extends _$CourseLinkCopyWithImpl<$Res, _$_CourseLink>
    implements _$$_CourseLinkCopyWith<$Res> {
  __$$_CourseLinkCopyWithImpl(
      _$_CourseLink _value, $Res Function(_$_CourseLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? course = freezed,
  }) {
    return _then(_$_CourseLink(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      course: freezed == course
          ? _value._course
          : course // ignore: cast_nullable_to_non_nullable
              as List<Course>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CourseLink implements _CourseLink {
  _$_CourseLink({required this.id, final List<Course>? course})
      : _course = course;

  factory _$_CourseLink.fromJson(Map<String, dynamic> json) =>
      _$$_CourseLinkFromJson(json);

  @override
  final int id;
  final List<Course>? _course;
  @override
  List<Course>? get course {
    final value = _course;
    if (value == null) return null;
    if (_course is EqualUnmodifiableListView) return _course;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CourseLink(id: $id, course: $course)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourseLink &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._course, _course));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_course));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CourseLinkCopyWith<_$_CourseLink> get copyWith =>
      __$$_CourseLinkCopyWithImpl<_$_CourseLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseLinkToJson(
      this,
    );
  }
}

abstract class _CourseLink implements CourseLink {
  factory _CourseLink({required final int id, final List<Course>? course}) =
      _$_CourseLink;

  factory _CourseLink.fromJson(Map<String, dynamic> json) =
      _$_CourseLink.fromJson;

  @override
  int get id;
  @override
  List<Course>? get course;
  @override
  @JsonKey(ignore: true)
  _$$_CourseLinkCopyWith<_$_CourseLink> get copyWith =>
      throw _privateConstructorUsedError;
}
