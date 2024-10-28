import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3player/common/widgets/waveforms/waveform.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_bloc.dart';

Widget sliderWaveform(BuildContext context) {
  return Stack(
    children: [
      Column(
        children: [
          Waveform(
            maxDuration: context.read<SongPlayerBloc>().songDuration,
            elapsedDuration: context.read<SongPlayerBloc>().songPosition,
            samples: context.read<SongPlayerBloc>().samples,
            height: MediaQuery.of(context).size.height * 0.05,
            absolute: true,
            borderWidth: 1,
            inactiveBorderColor: AppColors.grey,
            width: MediaQuery.of(context).size.width,
            inactiveColor: AppColors.grey,
            activeBorderColor: AppColors.white,
            activeGradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.white,
                AppColors.white,
              ],
            ),
          ),
          Waveform(
            maxDuration: context.read<SongPlayerBloc>().songDuration,
            elapsedDuration: context.read<SongPlayerBloc>().songPosition,
            samples: context.read<SongPlayerBloc>().samples,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            absolute: true,
            invert: true,
            borderWidth: 0.5,
            inactiveBorderColor: AppColors.grey,
            activeBorderColor: AppColors.white,
            activeColor: AppColors.white,
            inactiveColor: AppColors.grey,
          ),
        ],
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: SliderTheme(
          data: const SliderThemeData(
              thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 0,
          )),
          child: Slider(
              value: context
                  .read<SongPlayerBloc>()
                  .songPosition
                  .inSeconds
                  .toDouble(),
              min: 0.0,
              thumbColor: Colors.transparent,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              allowedInteraction: SliderInteraction.tapAndSlide,
              activeColor: Colors.transparent,
              inactiveColor: Colors.transparent,
              divisions: 512,
              max: context
                  .read<SongPlayerBloc>()
                  .songDuration
                  .inSeconds
                  .toDouble(),
              onChanged: (value) {
                Duration tempChange =
                    Duration(seconds: int.parse(value.toStringAsFixed(0)));
                context.read<SongPlayerBloc>().sliderChange(tempChange);
              }),
        ),
      ),
    ],
  );
}
