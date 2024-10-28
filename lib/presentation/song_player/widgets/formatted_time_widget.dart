import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3player/common/helpers/format_duration.dart';
import 'package:mp3player/presentation/song_player/bloc/song_player_bloc.dart';

Row formattedTimeWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        formatDuration(context.read<SongPlayerBloc>().songPosition),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    ],
  );
}
