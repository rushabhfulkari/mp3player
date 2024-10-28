import 'package:dartz/dartz.dart';
import 'package:mp3player/core/usecase/usecase.dart';
import 'package:mp3player/domain/repository/song.dart';
import 'package:mp3player/service_locator.dart';

class GetSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getSong();
  }
}
