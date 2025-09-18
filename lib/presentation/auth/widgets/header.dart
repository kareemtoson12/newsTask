import 'package:flutter/material.dart';
import 'package:news/app/styles/text_styels.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hello", style: AppTextStyles.headingBlack(context)),
        Text("Again!", style: AppTextStyles.headingBlue(context)),
        const SizedBox(height: 8),
        Text(
          "Welcome back you’ve been missed",
          style: AppTextStyles.subtitle(context),
        ),
      ],
    );
  }
}
