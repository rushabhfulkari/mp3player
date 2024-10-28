import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_bloc.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_state.dart';
import 'package:mp3player/presentation/song_player/widgets/formatted_time_widget.dart';
import 'package:mp3player/presentation/song_player/widgets/play_and_pause_controls.dart';
import 'package:mp3player/presentation/song_player/widgets/slider_waveform.dart';

Widget songStateHandler(BuildContext context) {
  return BlocBuilder<SongPlayerBloc, SongPlayerState>(
    builder: (context, state) {
      if (state is SongPlayerLoading) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.15),
          child: const CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 6,
              backgroundColor: AppColors.buttonForeground),
        );
      }
      if (state is NetworkFailure) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.15),
          child: const Text(
            "Network Error!",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
      }
      if (state is SongPlayerFailure) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.15),
          child: const Text(
            "Audio Player Error!",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
      }
      if (state is SongPlayerLoaded) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            sliderWaveform(context),
            const SizedBox(
              height: 20,
            ),
            formattedTimeWidget(context),
            playAndPauseControls(context)
          ],
        );
      }

      return Container();
    },
  );
}
