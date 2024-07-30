import 'dart:convert';

import 'package:app/core/failure.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:matrix/matrix.dart' as matrix;

class EventPassService {
  final String ticketId;
  final Client _client = Client();
  EventPassService({
    required this.ticketId,
  });

  Future<Either<Failure, List<dynamic>>> apple() async {
    try {
      final appOauth = AppOauth();
      final token = await appOauth.getTokenForGql();
      print(token);
      final result = await _client.get(
        Uri.parse(
          "https://backend.staging.lemonade.social/event/pass/google/$ticketId",
        ),
        headers: {"Authorization": 'Bearer $token'},
      );
      print(
          "https://backend.staging.lemonade.social/event/pass/google/$ticketId");
      print(result.statusCode);
      print(result.body.toString());
      if (result.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(result.body);
        print("??????");
        print(json);
        if (json.tryGet('data') != null) {
          print("???json.tryGet('data') as List<dynamic>");
          print(json.tryGet('data') as List<dynamic>);
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
