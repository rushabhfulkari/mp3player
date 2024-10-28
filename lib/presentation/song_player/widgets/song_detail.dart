import 'package:flutter/material.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';

Widget songDetail() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Instant Crush",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: AppColors.white),
            ),
            Text(
              "feat. Julian Casablancas",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white),
            ),
          ],
        ),
      ),
    ],
  );
}
