import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:app/graphql/backend/file/mutation/create_file_uploads.graphql.dart';
import 'package:app/graphql/backend/file/mutation/confirm_uploads.graphql.dart';

class FileUploadService {
  final GraphQLClient _client;

  FileUploadService(this._client);

  Future<void> uploadFile(XFile? file) async {
    // Step 1: Trigger createFileUpload mutation to get presignedUrl
    List<Mutation$CreateFileUploads$createFileUploads> listCreateFileUploads =
        await _getPresignedUrl(file);

    for (var i = 0; i < listCreateFileUploads.length; i++) {
      Mutation$CreateFileUploads$createFileUploads element =
          listCreateFileUploads[i];

      print(">>>>>>>");
      print(element.url);

      // Step 2: Upload file to S3 using presignedUrl
      bool s3UploadSuccess = await _uploadToS3(file, element.presignedUrl);

      if (s3UploadSuccess) {
        // Step 3: Trigger confirmUpload mutation
        await _confirmUpload(element.id ?? '');

        print(">>>>>>> upload image success");
        print(element.url);
      }
    }
  }

  Future<List<Mutation$CreateFileUploads$createFileUploads>> _getPresignedUrl(
    XFile? file,
  ) async {
    final result = await _client.mutate$CreateFileUploads(
      Options$Mutation$CreateFileUploads(
        variables: Variables$Mutation$CreateFileUploads(
          uploadInfos: [
            Input$FileUploadInfo($extension: "png"),
          ],
          directory: 'user',
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    return result.parsedData?.createFileUploads ?? [];
  }

  Future<bool> _uploadToS3(XFile? file, String presignedUrl) async {
    print("......._uploadToS3");
    print("presignedUrl :  $presignedUrl");

    // Upload file to S3 using presignedUrl
    try {
      final response = await http.put(
        Uri.parse(presignedUrl),
        body: await file?.readAsBytes(),
      );
      print(".......response.statusCode");
      print(response.statusCode);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _confirmUpload(String fileId) async {
    print("......._confirmUpload");
    final result = await _client.mutate$ConfirmFileUploads(
      Options$Mutation$ConfirmFileUploads(
        variables: Variables$Mutation$ConfirmFileUploads(ids: []),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    print(".......result.parsedData?.confirmFileUploads");
    print(result.parsedData?.confirmFileUploads);
    return result.parsedData?.confirmFileUploads ?? false;
  }
}
