import 'package:dartz/dartz.dart';
import 'package:mp3player/data/sources/song_http_service.dart';
import 'package:mp3player/domain/repository/song.dart';
import 'package:mp3player/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getSong() async {
    return await sl<SongHttpService>().getSong();
  }
}
