import 'package:mp3player/domain/entities/song.dart';

class SongModel {
  String? audioFilePath;

  SongModel({
    required this.audioFilePath,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    audioFilePath = data['audioFilePath'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      audioFilePath: audioFilePath!,
    );
  }
}
