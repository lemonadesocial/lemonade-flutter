import 'dart:io';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

extension MatrixFileExtension on MatrixFile {
  Future<String> getDownloadPathAndroid() async {
    final directory = await getDownloadDirectoryAndroid();
    return '${directory.path}/$name';
  }

  Future<Directory> getDownloadDirectoryAndroid() async {
    final defaultDownloadDirectory = Directory('/storage/emulated/0/Download');
    if (await defaultDownloadDirectory.exists()) {
      return defaultDownloadDirectory;
    }
    return await getApplicationDocumentsDirectory();
  }

  MatrixFile get detectFileType {
    if (msgType == MessageTypes.Image) {
      return MatrixImageFile(bytes: bytes, name: name);
    }
    if (msgType == MessageTypes.Video) {
      return MatrixVideoFile(bytes: bytes, name: name);
    }
    if (msgType == MessageTypes.Audio) {
      return MatrixAudioFile(bytes: bytes, name: name);
    }
    return this;
  }
}
