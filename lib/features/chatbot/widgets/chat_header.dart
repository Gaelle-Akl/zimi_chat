import 'package:flutter/material.dart';
import "../../../app/theme/app_colors.dart";

class ChatHeader extends StatelessWidget {
    const ChatHeader({super.key});
    @override

    Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,

      decoration: const BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),



}