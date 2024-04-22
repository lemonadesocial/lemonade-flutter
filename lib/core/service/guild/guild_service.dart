import 'dart:convert';

import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:http/http.dart' as http;

class GuildService {
  static String guildApiEndpoint = 'https://api.guild.xyz';

  static Future<Guild> getGuildDetail(num guildId) async {
    final endpoint = '$guildApiEndpoint/v1/guild/${guildId.toInt()}';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return Guild.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<GuildRolePermission>> checkUserAccessToAGuild(
    num guildId,
    String walletAddress,
  ) async {
    final endpoint =
        '$guildApiEndpoint/v1/guild/access/${guildId.toInt()}/$walletAddress';
    final response = await http.get(Uri.parse(endpoint));
    try {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<GuildRolePermission> result =
          jsonList.map((json) => GuildRolePermission.fromJson(json)).toList();
      return result;
    } catch (e) {
      return [];
    }
  }

  static Future<List<GuildBasic>> getAllGuilds() async {
    final endpoint = '$guildApiEndpoint/v1/guild';
    final response = await http.get(Uri.parse(endpoint));
    try {
      final List jsonList = jsonDecode(response.body);
      final List<GuildBasic> result = jsonList.map((json) {
        return GuildBasic.fromJson(json);
      }).toList();
      return result;
    } catch (e) {
      return [];
    }
  }

  static Future<GuildBasic> createGuild({
    required String name,
    required List<GuildRole> roles,
  }) async {
    final endpoint = '$guildApiEndpoint/v1/guild';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "payload": {
            "name": name,
            "roles": jsonEncode(jsonDecode(roles.toString())),
          },
          "validation": {
            "address": "0x94228f99a09a30c9f7abfd8b1a629448bf6b0625"
          }
        },
      ),
    );
    print(">>>>>>>>>>>>>>> FK");
    print(response);
    print(response.body);
    return GuildBasic.fromJson(
      jsonDecode(response.body),
    );
  }
}
