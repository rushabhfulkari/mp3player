import 'package:flutter/material.dart';
import 'package:mp3player/core/configs/assets/app_images.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';
import 'package:mp3player/presentation/song_player/pages/song_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
          child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppImages.logo))),
      )),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SongPlayerPage()));
  }
}
