import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../widgets/zimi_avatar.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderWaveClipper(),
      child: Container(
        height: 170,
        width: double.infinity,

        // More visible Zimi coral gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B67),
              Color(0xFFFF5552),
              Color(0xFFFF3F48),
            ],
            stops: [
              0.0,
              0.55,
              1.0,
            ],
          ),
        ),

        child: Stack(
          children: [
            // ─────────────────────────────
            // Decorative circles
            // ─────────────────────────────

            Positioned(
              left: -40,
              top: 15,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              right: 60,
              top: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              right: -25,
              top: 20,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.11),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // ─────────────────────────────
            // Header content
            // ─────────────────────────────

            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ─────────────────────
                    // BACK BUTTON
                    // ─────────────────────

                    SizedBox(
                      width: 42,
                      height: 48,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    // ─────────────────────
                    // CUSTOM ZIMI AVATAR
                    // ─────────────────────

                    const ZimiAvatar(
                      size: 60,
                    ),

                    const SizedBox(width: 14),

                    // ─────────────────────
                    // TITLE
                    // ─────────────────────

                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Zimi Assistant',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Your food companion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ─────────────────────
                    // THREE-DOT MENU
                    // ─────────────────────

                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        tooltip: 'More options',
                        icon: const Icon(
                          Icons.more_horiz_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        onSelected: (value) {
                          switch (value) {
                            case 'clear':
                              debugPrint('Clear chat selected');
                              break;

                            case 'help':
                              debugPrint('Help selected');
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem<String>(
                            value: 'clear',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text('Clear chat'),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'help',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text('Help'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// HEADER WAVE
// ─────────────────────────────────────

class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height * 0.82);

    path.cubicTo(
      size.width * 0.10,
      size.height * 0.98,
      size.width * 0.23,
      size.height * 0.98,
      size.width * 0.36,
      size.height * 0.87,
    );

    path.cubicTo(
      size.width * 0.49,
      size.height * 0.75,
      size.width * 0.58,
      size.height * 0.76,
      size.width * 0.69,
      size.height * 0.86,
    );

    path.cubicTo(
      size.width * 0.81,
      size.height * 0.97,
      size.width * 0.92,
      size.height * 0.96,
      size.width,
      size.height * 0.79,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(
    covariant HeaderWaveClipper oldClipper,
  ) {
    return false;
  }
}