import 'dart:convert';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

@LazySingleton()
class LensGroveService {
  final String _baseUrl = 'https://api.grove.storage';

  Future<Map<String, String>?> uploadFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      final linkNewUrl = Uri.parse('$_baseUrl/link/new');
      final linkNewResponse = await http.post(linkNewUrl);

      if (linkNewResponse.statusCode != 200) {
        return null;
      }

      final linkNewData = jsonDecode(linkNewResponse.body) as List;
      if (linkNewData.isEmpty || linkNewData[0] is! Map) {
        return null;
      }
      final storageInfo = linkNewData[0] as Map<String, dynamic>;
      final storageKey = storageInfo['storage_key'] as String?;
      final initialGatewayUrl = storageInfo['gateway_url'] as String?;
      final initialUri = storageInfo['uri'] as String?;

      if (storageKey == null || storageKey.isEmpty) {
        return null;
      }

      final acl = {
        "template": "immutable",
        "chain_id": AppConfig.lensChainId,
      };
      final aclJson = jsonEncode(acl);

      final uploadUrl = Uri.parse('$_baseUrl/$storageKey');
      final request = http.MultipartRequest('POST', uploadUrl);

      final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';
      final multipartFile = await http.MultipartFile.fromPath(
        storageKey,
        filePath,
        filename: p.basename(filePath),
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);

      final aclMultipartFile = http.MultipartFile.fromString(
        'lens-acl.json',
        aclJson,
        filename: 'lens-acl.json',
        contentType: MediaType.parse('application/json'),
      );
      request.files.add(aclMultipartFile);

      final streamedResponse = await request.send();
      final uploadResponse = await http.Response.fromStream(streamedResponse);

      if (uploadResponse.statusCode != 201 &&
          uploadResponse.statusCode != 202) {
        return null;
      }

      final uploadData = jsonDecode(uploadResponse.body) as List;
      if (uploadData.isEmpty || uploadData[0] is! Map) {
        return null;
      }
      final uploadResult = uploadData[0] as Map<String, dynamic>;
      final finalGatewayUrl = uploadResult['gateway_url'] as String?;
      final finalUri = uploadResult['uri'] as String?;

      return {
        'gateway_url': finalGatewayUrl ?? initialGatewayUrl ?? '',
        'uri': finalUri ?? initialUri ?? '',
      };
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, String>?> uploadJson(
    Map<String, dynamic> jsonData,
  ) async {
    try {
      final uploadUrl =
          Uri.parse('$_baseUrl?chain_id=${AppConfig.lensChainId}');

      final jsonString = jsonEncode(jsonData);

      final response = await http.post(
        uploadUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      if (response.statusCode != 201 && response.statusCode != 202) {
        return null;
      }

      final result = jsonDecode(response.body) as List<dynamic>;
      final uploadData = result.firstOrNull as Map<String, dynamic>?;
      final finalStorageKey = uploadData?['storage_key'] as String?;
      final finalGatewayUrl = uploadData?['gateway_url'] as String?;
      final finalUri = uploadData?['uri'] as String?;
      final statusUrl = uploadData?['status_url'] as String?;

      if (finalGatewayUrl == null || finalUri == null) {
        return null;
      }

      return {
        'gateway_url': finalGatewayUrl,
        'uri': finalUri,
        'storage_key': finalStorageKey ?? '',
        'status_url': statusUrl ?? '',
      };
    } catch (e) {
      return null;
    }
  }
}
