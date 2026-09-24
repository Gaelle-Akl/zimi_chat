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
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 21,
              ),
            ),
          const SizedBox(width: 4),
        Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 32,
            ),
        ),
        const SizedBox(width: 14),
        const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Zimi Assistent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 5),
                  Text(
                    'Your food companion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 24,
              ),
           
            ),
          ],
        ),
      ),
    );
}
  }