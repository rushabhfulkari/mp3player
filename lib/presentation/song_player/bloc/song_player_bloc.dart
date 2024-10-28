import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mp3player/common/helpers/load_parse_json.dart';
import 'package:mp3player/domain/usecases/get_song.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_state.dart';
import 'package:mp3player/service_locator.dart';

class SongPlayerBloc extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = const Duration(seconds: 13, milliseconds: 0);
  Duration songPosition = Duration.zero;
  List<double> samples = [];

  SongPlayerBloc() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;

      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong() async {
    emit(SongPlayerLoading());
    var returnedSong = await sl<GetSongsUseCase>().call();
    returnedSong.fold((l) {
      emit(NetworkFailure());
    }, (data) async {
      try {
        final json =
            await rootBundle.loadString('assets/jsons/background.json');

        Map<String, dynamic> audioDataMap = {
          "json": json,
          "totalSamples": 512,
        };
        final samplesData = await compute(loadparseJson, audioDataMap);

        samples = samplesData["samples"];

        audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(data.audioFilePath)));
        audioPlayer.play();
        log(data.audioFilePath.toString());
        audioPlayer.setLoopMode(LoopMode.all);

        emit(SongPlayerLoaded());
      } catch (e) {
        emit(SongPlayerFailure());
      }
    });
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  void sliderChange(value) {
    songPosition = value;
    audioPlayer.seek(songPosition);

    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
