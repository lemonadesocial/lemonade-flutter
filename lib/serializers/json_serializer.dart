// ignore: implementation_imports
import "package:gql_code_builder/src/serializers/json_serializer.dart";

class JSONSerializer extends JsonSerializer<Map<String, dynamic>> {
  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) => json;

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> object) => object;
}
