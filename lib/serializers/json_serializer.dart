// ignore: implementation_imports
import "package:gql_code_builder/src/serializers/json_serializer.dart";

class JSONSerializer extends JsonSerializer<Map<String, dynamic>> {
  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) => json;

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> object) => object;
}

// import 'dart:convert';

// import 'package:built_value/serializer.dart';

// class JSONSerializer implements PrimitiveSerializer<Map<String, dynamic>> {
//   @override
//   Map<String, dynamic> deserialize(
//     Serializers serializers,
//     Object serialized, {
//     FullType specifiedType = FullType.unspecified,
//   }) {
//     assert(
//       serialized is String,
//       "JSONSerializer expected 'String' but got ${serialized.runtimeType}",
//     );
//     return jsonDecode(serialized as String);
//   }

//   @override
//   Object serialize(
//     Serializers serializers,
//     Map<String, dynamic> json, {
//     FullType specifiedType = FullType.unspecified,
//   }) =>
//       jsonEncode(json);

//   @override
//   Iterable<Type> get types => [Map<String, dynamic>];

//   @override
//   String get wireName => "JSON";
// }
