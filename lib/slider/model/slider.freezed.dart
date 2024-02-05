// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Slider _$SliderFromJson(Map<String, dynamic> json) {
  return _Slider.fromJson(json);
}

/// @nodoc
mixin _$Slider {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  MessengerLink? get messengerlink => throw _privateConstructorUsedError;
  FacebookLink? get facebooklink => throw _privateConstructorUsedError;
  YoutubeLink? get youtube => throw _privateConstructorUsedError;
  CourseLink? get courselink => throw _privateConstructorUsedError;
  List<SliderBlog>? get blogs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SliderCopyWith<Slider> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderCopyWith<$Res> {
  factory $SliderCopyWith(Slider value, $Res Function(Slider) then) =
      _$SliderCopyWithImpl<$Res, Slider>;
  @useResult
  $Res call(
      {int id,
      String title,
      String image,
      MessengerLink? messengerlink,
      FacebookLink? facebooklink,
      YoutubeLink? youtube,
      CourseLink? courselink,
      List<SliderBlog>? blogs});

  $MessengerLinkCopyWith<$Res>? get messengerlink;
  $FacebookLinkCopyWith<$Res>? get facebooklink;
  $YoutubeLinkCopyWith<$Res>? get youtube;
  $CourseLinkCopyWith<$Res>? get courselink;
}

/// @nodoc
class _$SliderCopyWithImpl<$Res, $Val extends Slider>
    implements $SliderCopyWith<$Res> {
  _$SliderCopyWithImpl(this._value, this._then);

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
    Object? messengerlink = freezed,
    Object? facebooklink = freezed,
    Object? youtube = freezed,
    Object? courselink = freezed,
    Object? blogs = freezed,
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
      messengerlink: freezed == messengerlink
          ? _value.messengerlink
          : messengerlink // ignore: cast_nullable_to_non_nullable
              as MessengerLink?,
      facebooklink: freezed == facebooklink
          ? _value.facebooklink
          : facebooklink // ignore: cast_nullable_to_non_nullable
              as FacebookLink?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as YoutubeLink?,
      courselink: freezed == courselink
          ? _value.courselink
          : courselink // ignore: cast_nullable_to_non_nullable
              as CourseLink?,
      blogs: freezed == blogs
          ? _value.blogs
          : blogs // ignore: cast_nullable_to_non_nullable
              as List<SliderBlog>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessengerLinkCopyWith<$Res>? get messengerlink {
    if (_value.messengerlink == null) {
      return null;
    }

    return $MessengerLinkCopyWith<$Res>(_value.messengerlink!, (value) {
      return _then(_value.copyWith(messengerlink: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FacebookLinkCopyWith<$Res>? get facebooklink {
    if (_value.facebooklink == null) {
      return null;
    }

    return $FacebookLinkCopyWith<$Res>(_value.facebooklink!, (value) {
      return _then(_value.copyWith(facebooklink: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YoutubeLinkCopyWith<$Res>? get youtube {
    if (_value.youtube == null) {
      return null;
    }

    return $YoutubeLinkCopyWith<$Res>(_value.youtube!, (value) {
      return _then(_value.copyWith(youtube: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CourseLinkCopyWith<$Res>? get courselink {
    if (_value.courselink == null) {
      return null;
    }

    return $CourseLinkCopyWith<$Res>(_value.courselink!, (value) {
      return _then(_value.copyWith(courselink: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SliderCopyWith<$Res> implements $SliderCopyWith<$Res> {
  factory _$$_SliderCopyWith(_$_Slider value, $Res Function(_$_Slider) then) =
      __$$_SliderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String image,
      MessengerLink? messengerlink,
      FacebookLink? facebooklink,
      YoutubeLink? youtube,
      CourseLink? courselink,
      List<SliderBlog>? blogs});

  @override
  $MessengerLinkCopyWith<$Res>? get messengerlink;
  @override
  $FacebookLinkCopyWith<$Res>? get facebooklink;
  @override
  $YoutubeLinkCopyWith<$Res>? get youtube;
  @override
  $CourseLinkCopyWith<$Res>? get courselink;
}

/// @nodoc
class __$$_SliderCopyWithImpl<$Res>
    extends _$SliderCopyWithImpl<$Res, _$_Slider>
    implements _$$_SliderCopyWith<$Res> {
  __$$_SliderCopyWithImpl(_$_Slider _value, $Res Function(_$_Slider) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = null,
    Object? messengerlink = freezed,
    Object? facebooklink = freezed,
    Object? youtube = freezed,
    Object? courselink = freezed,
    Object? blogs = freezed,
  }) {
    return _then(_$_Slider(
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
      messengerlink: freezed == messengerlink
          ? _value.messengerlink
          : messengerlink // ignore: cast_nullable_to_non_nullable
              as MessengerLink?,
      facebooklink: freezed == facebooklink
          ? _value.facebooklink
          : facebooklink // ignore: cast_nullable_to_non_nullable
              as FacebookLink?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as YoutubeLink?,
      courselink: freezed == courselink
          ? _value.courselink
          : courselink // ignore: cast_nullable_to_non_nullable
              as CourseLink?,
      blogs: freezed == blogs
          ? _value._blogs
          : blogs // ignore: cast_nullable_to_non_nullable
              as List<SliderBlog>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Slider implements _Slider {
  _$_Slider(
      {required this.id,
      required this.title,
      required this.image,
      this.messengerlink,
      this.facebooklink,
      this.youtube,
      this.courselink,
      final List<SliderBlog>? blogs})
      : _blogs = blogs;

  factory _$_Slider.fromJson(Map<String, dynamic> json) =>
      _$$_SliderFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String image;
  @override
  final MessengerLink? messengerlink;
  @override
  final FacebookLink? facebooklink;
  @override
  final YoutubeLink? youtube;
  @override
  final CourseLink? courselink;
  final List<SliderBlog>? _blogs;
  @override
  List<SliderBlog>? get blogs {
    final value = _blogs;
    if (value == null) return null;
    if (_blogs is EqualUnmodifiableListView) return _blogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Slider(id: $id, title: $title, image: $image, messengerlink: $messengerlink, facebooklink: $facebooklink, youtube: $youtube, courselink: $courselink, blogs: $blogs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Slider &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.messengerlink, messengerlink) ||
                other.messengerlink == messengerlink) &&
            (identical(other.facebooklink, facebooklink) ||
                other.facebooklink == facebooklink) &&
            (identical(other.youtube, youtube) || other.youtube == youtube) &&
            (identical(other.courselink, courselink) ||
                other.courselink == courselink) &&
            const DeepCollectionEquality().equals(other._blogs, _blogs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      messengerlink,
      facebooklink,
      youtube,
      courselink,
      const DeepCollectionEquality().hash(_blogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SliderCopyWith<_$_Slider> get copyWith =>
      __$$_SliderCopyWithImpl<_$_Slider>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SliderToJson(
      this,
    );
  }
}

abstract class _Slider implements Slider {
  factory _Slider(
      {required final int id,
      required final String title,
      required final String image,
      final MessengerLink? messengerlink,
      final FacebookLink? facebooklink,
      final YoutubeLink? youtube,
      final CourseLink? courselink,
      final List<SliderBlog>? blogs}) = _$_Slider;

  factory _Slider.fromJson(Map<String, dynamic> json) = _$_Slider.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get image;
  @override
  MessengerLink? get messengerlink;
  @override
  FacebookLink? get facebooklink;
  @override
  YoutubeLink? get youtube;
  @override
  CourseLink? get courselink;
  @override
  List<SliderBlog>? get blogs;
  @override
  @JsonKey(ignore: true)
  _$$_SliderCopyWith<_$_Slider> get copyWith =>
      throw _privateConstructorUsedError;
}
