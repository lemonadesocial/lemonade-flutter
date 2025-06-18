import 'package:app/graphql/lens/schema.graphql.dart';

class LensConstants {
  static Map<Enum$MainContentFocus, String> lensJsonSchemaByPostContent = {
    Enum$MainContentFocus.TEXT_ONLY:
        "https://json-schemas.lens.dev/posts/text-only/3.0.0.json",
    Enum$MainContentFocus.IMAGE:
        "https://json-schemas.lens.dev/posts/image/3.0.0.json",
    Enum$MainContentFocus.EVENT:
        "https://json-schemas.lens.dev/posts/event/3.0.0.json",
  };
}
