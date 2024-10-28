import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mp3player/presentation/song_player/bloc/song_player_bloc.dart';

import 'package:mp3player/presentation/song_player/widgets/audio_player_card.dart';
import 'package:mp3player/presentation/song_player/widgets/song_cover.dart';

// ignore: must_be_immutable
class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => SongPlayerBloc()..loadSong(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [songCover(context), audioPlayerCard(context)],
            ),
          )),
    );
  }
}
