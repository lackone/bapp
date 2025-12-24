import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

//flutter packages pub run build_runner build

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  int? code;
  String? msg;
  T? data;

  Result({this.code, this.msg, this.data});

  factory Result.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$ResultToJson(this, toJsonT);
}
