import 'package:get_it/get_it.dart';
import 'package:mp3player/data/repository/song_repository_impl.dart';
import 'package:mp3player/data/sources/song_http_service.dart';
import 'package:mp3player/domain/repository/song.dart';
import 'package:mp3player/domain/usecases/get_song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<SongHttpService>(SongHttpServiceImpl());

  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<GetSongsUseCase>(GetSongsUseCase());
}
