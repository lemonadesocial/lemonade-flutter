import 'dart:convert';

import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:http/http.dart' as http;

class GuildUtils {
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

  static Future<GuildRole> getRoleDetail(num roleId) async {
    final endpoint = '$guildApiEndpoint/v1/guild/${roleId.toInt()}';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return GuildRole.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  static String getFullImageUrl(String input) {
    const String baseUrl = 'https://guild.xyz/';

    // If input starts with 'https://' it's already a full URL
    if (input.startsWith('https://')) {
      return input;
    }

    // If input starts with '/', it's a path, so concatenate with baseUrl
    if (input.startsWith('/')) {
      return '$baseUrl$input';
    }

    return input;
  }
}
