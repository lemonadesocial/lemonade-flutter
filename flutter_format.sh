echo "dart analyze"
dart analyze lib

echo "dart fix"
dart fix --apply

echo "format projects"
find lib -name "*.dart" ! -name "*.g.dart" ! -name "*.gr.dart" ! -name "*.freezed.dart" ! -path '*/generated/*'  | tr '\n' ' ' | xargs dart format -l "80"
