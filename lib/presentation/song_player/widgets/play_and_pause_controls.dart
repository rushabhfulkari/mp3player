import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3player/core/configs/assets/app_images.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_bloc.dart';

Padding playAndPauseControls(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: GestureDetector(
      onTap: () {
        context.read<SongPlayerBloc>().playOrPauseSong();
      },
      child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withOpacity(0.4),
                  offset: const Offset(0, 10),
                  blurRadius: 25.0,
                ),
              ],
              color: AppColors.white.withOpacity(0.5)),
          child: context.read<SongPlayerBloc>().audioPlayer.playing
              ? Center(
                  child: Image.asset(
                    AppImages.pause,
                    height: 25,
                  ),
                )
              : const Center(
                  child: Icon(
                  Icons.play_arrow_rounded,
                  size: 50,
                  color: AppColors.buttonForeground,
                ))),
    ),
  );
}
