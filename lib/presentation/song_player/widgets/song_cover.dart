import 'package:flutter/material.dart';
import 'package:mp3player/core/configs/assets/app_images.dart';

Widget songCover(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 1.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(AppImages.background))),
  );
}
