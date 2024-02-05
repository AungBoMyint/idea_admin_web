// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SliderListResponse _$SliderListResponseFromJson(Map<String, dynamic> json) {
  return _SliderListResponse.fromJson(json);
}

/// @nodoc
mixin _$SliderListResponse {
  int? get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<Slider>? get results => throw _privateConstructorUsedError;
  ResponseError? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SliderListResponseCopyWith<SliderListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderListResponseCopyWith<$Res> {
  factory $SliderListResponseCopyWith(
          SliderListResponse value, $Res Function(SliderListResponse) then) =
      _$SliderListResponseCopyWithImpl<$Res, SliderListResponse>;
  @useResult
  $Res call(
      {int? count,
      String? next,
      String? previous,
      List<Slider>? results,
      ResponseError? error});

  $ResponseErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$SliderListResponseCopyWithImpl<$Res, $Val extends SliderListResponse>
    implements $SliderListResponseCopyWith<$Res> {
  _$SliderListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Slider>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ResponseError?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResponseErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ResponseErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SliderListResponseCopyWith<$Res>
    implements $SliderListResponseCopyWith<$Res> {
  factory _$$_SliderListResponseCopyWith(_$_SliderListResponse value,
          $Res Function(_$_SliderListResponse) then) =
      __$$_SliderListResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? count,
      String? next,
      String? previous,
      List<Slider>? results,
      ResponseError? error});

  @override
  $ResponseErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$_SliderListResponseCopyWithImpl<$Res>
    extends _$SliderListResponseCopyWithImpl<$Res, _$_SliderListResponse>
    implements _$$_SliderListResponseCopyWith<$Res> {
  __$$_SliderListResponseCopyWithImpl(
      _$_SliderListResponse _value, $Res Function(_$_SliderListResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_SliderListResponse(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Slider>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ResponseError?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SliderListResponse implements _SliderListResponse {
  _$_SliderListResponse(
      {this.count,
      this.next,
      this.previous,
      final List<Slider>? results,
      this.error})
      : _results = results;

  factory _$_SliderListResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SliderListResponseFromJson(json);

  @override
  final int? count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<Slider>? _results;
  @override
  List<Slider>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ResponseError? error;

  @override
  String toString() {
    return 'SliderListResponse(count: $count, next: $next, previous: $previous, results: $results, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SliderListResponse &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count, next, previous,
      const DeepCollectionEquality().hash(_results), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SliderListResponseCopyWith<_$_SliderListResponse> get copyWith =>
      __$$_SliderListResponseCopyWithImpl<_$_SliderListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SliderListResponseToJson(
      this,
    );
  }
}

abstract class _SliderListResponse implements SliderListResponse {
  factory _SliderListResponse(
      {final int? count,
      final String? next,
      final String? previous,
      final List<Slider>? results,
      final ResponseError? error}) = _$_SliderListResponse;

  factory _SliderListResponse.fromJson(Map<String, dynamic> json) =
      _$_SliderListResponse.fromJson;

  @override
  int? get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<Slider>? get results;
  @override
  ResponseError? get error;
  @override
  @JsonKey(ignore: true)
  _$$_SliderListResponseCopyWith<_$_SliderListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
