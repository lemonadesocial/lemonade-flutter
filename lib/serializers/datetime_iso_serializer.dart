import 'package:built_value/serializer.dart';

class DateTimeISOSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    assert(
      serialized is String,
      "DateTimeISOSerializer expected 'String' but got ${serialized.runtimeType}",
    );
    return DateTime.parse(serialized as String);
  }

  @override
  Object serialize(
    Serializers serializers,
    DateTime datetime, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      datetime.toIso8601String();

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => "DateTimeISO";
}
