import 'package:flutter/material.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';
import 'package:mp3player/presentation/song_player/widgets/song_detail.dart';
import 'package:mp3player/presentation/song_player/widgets/song_state_handler.dart';

Widget audioPlayerCard(context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.darkBackground,
            AppColors.grey,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.12),
            offset: const Offset(0, -5),
            blurRadius: 15.0,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [songDetail(), songStateHandler(context)],
      ),
    ),
  );
}
