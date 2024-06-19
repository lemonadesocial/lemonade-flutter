import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AirstackGQLProviderWidget extends StatefulWidget {
  final Widget child;
  const AirstackGQLProviderWidget({
    super.key,
    required this.child,
  });

  @override
  State<AirstackGQLProviderWidget> createState() =>
      _AirstackGQLProviderWidgetState();
}

class _AirstackGQLProviderWidgetState extends State<AirstackGQLProviderWidget> {
  late final ValueNotifier<GraphQLClient> airstackClient;

  @override
  void initState() {
    super.initState();
    airstackClient = ValueNotifier(getIt<AirstackGQL>().client);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: airstackClient,
      child: widget.child,
    );
  }
}
