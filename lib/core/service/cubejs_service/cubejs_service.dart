import 'dart:convert';

import 'package:app/core/config.dart';
import 'package:app/core/domain/cubejs/cubejs_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:matrix/matrix.dart' as matrix;

class CubeJsService {
  final String eventId;
  final Client _client = Client();
  CubeJsService({
    required this.eventId,
  });

  Future<Map<String, String>> getHeader() async {
    final result =
        await getIt<CubeJsRepository>().generateCubejsToken(eventId: eventId);
    return {
      'Authorization': result.fold((l) => '', (r) => r),
    };
  }

  Future<Either<Failure, List<dynamic>>> query({
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await getHeader();
      final result = await _client.get(
        Uri.parse("${AppConfig.cubeJsRestUrl}?query=${jsonEncode(body)}"),
        headers: headers,
      );
      if (result.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(result.body);
        if (json.tryGet('data') != null) {
          return Right(json.tryGet('data') as List<dynamic>);
        }
        Left(Failure(message: result.body));
      }

      return Left(Failure(message: result.body));
    } catch (e) {
      return Left(Failure());
    }
  }
}
