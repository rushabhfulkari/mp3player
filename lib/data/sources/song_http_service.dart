import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mp3player/core/configs/constants/app_urls.dart';
import 'package:mp3player/data/models/song.dart';
import 'package:mp3player/domain/entities/song.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

abstract class SongHttpService {
  Future<Either> getSong();
}

class SongHttpServiceImpl extends SongHttpService {
  @override
  Future<Either> getSong() async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/audioFileName');
      var request = await http.get(
        Uri.parse(AppURLs.audioFileLink),
      );
      var bytes = request.bodyBytes;
      await file.writeAsBytes(bytes);

      SongModel songModel = SongModel(audioFilePath: file.path);
      SongEntity songEntity = songModel.toEntity();

      return Right(songEntity);
    } catch (e) {
      return const Left('An error occurred, Please try again');
    }
  }
}
