import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/file/mutation/create_file_uploads.graphql.dart';
import 'package:app/graphql/backend/file/mutation/confirm_uploads.graphql.dart';
import 'package:mime/mime.dart';

enum FileDirectory {
  event,
  place,
  store,
  storeProduct,
  user,
  stories,
  post;
}

class FileUploadService {
  final GraphQLClient _client;

  FileUploadService(this._client);

  Future<String?> uploadSingleFile(XFile? file, FileDirectory directory) async {
    if (file == null) {
      return null;
    }

    // Step 1: Trigger createFileUpload mutation to get presignedUrl
    List<Mutation$CreateFileUploads$createFileUploads> listCreateFileUploads =
        await _getPresignedUrl(file, directory);

    if (listCreateFileUploads.isNotEmpty) {
      Mutation$CreateFileUploads$createFileUploads firstElement =
          listCreateFileUploads.first;

      // Step 2: Upload file to S3 using presignedUrl
      bool s3UploadSuccess = await _uploadToS3(file, firstElement.presignedUrl);

      if (s3UploadSuccess) {
        // Step 3: Trigger confirmUpload mutation
        await _confirmUpload(firstElement.id ?? '');
        return firstElement.id;
      }
    }

    return null;
  }

  Future<List<Mutation$CreateFileUploads$createFileUploads>> _getPresignedUrl(
    XFile? file,
    FileDirectory directory,
  ) async {
    final mimeType = lookupMimeType(file?.path ?? '');
    final fileExtension = mimeType!.split('/')[1];

    final result = await _client.mutate$CreateFileUploads(
      Options$Mutation$CreateFileUploads(
        variables: Variables$Mutation$CreateFileUploads(
          uploadInfos: [
            Input$FileUploadInfo($extension: fileExtension.toString()),
          ],
          directory: directory.name,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    return result.parsedData?.createFileUploads ?? [];
  }

  Future<bool> _uploadToS3(XFile? file, String presignedUrl) async {
    try {
      final response = await http.put(
        Uri.parse(presignedUrl),
        body: await file?.readAsBytes(),
        headers: {
          'x-amz-tagging': 'pending=true',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _confirmUpload(String fileId) async {
    final result = await _client.mutate$ConfirmFileUploads(
      Options$Mutation$ConfirmFileUploads(
        variables: Variables$Mutation$ConfirmFileUploads(ids: []),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    return result.parsedData?.confirmFileUploads ?? false;
  }
}
