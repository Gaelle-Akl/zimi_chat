import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../widgets/zimi_avatar.dart';

class ChatHeader extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onBackPressed;

  const ChatHeader({
    super.key,
    this.onRefresh,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return ClipPath(
      clipper: HeaderWaveClipper(),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF625A),
              Color(0xFFFF4745),
            ],
            stops: [
              0.0,
              1.0,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -40,
              top: 15,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.055),
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
                  color: Colors.white.withOpacity(0.045),
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
                  color: Colors.white.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 42,
                      height: 48,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onBackPressed ?? () => Navigator.maybePop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // Zimi Avatar
                    const ZimiAvatar(
                      size: 60,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            langProvider.translate('title'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            langProvider.translate('subtitle'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.more_horiz_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 'refresh' && onRefresh != null) {
                          onRefresh!();
                        } else if (value.startsWith('lang_')) {
                          final selectedLang = value.replaceFirst('lang_', '');
                          langProvider.setLanguage(selectedLang);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'refresh',
                          child: Row(
                            children: [
                              const Icon(Icons.refresh, color: Colors.black87, size: 20),
                              const SizedBox(width: 8),
                              Text(langProvider.translate('refresh')),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem<String>(
                          value: 'lang_en',
                          child: Text(
                            '🇬🇧 English',
                            style: TextStyle(
                              fontWeight: langProvider.currentLanguage == 'en'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'lang_fr',
                          child: Text(
                            '🇫🇷 Français',
                            style: TextStyle(
                              fontWeight: langProvider.currentLanguage == 'fr'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'lang_ar',
                          child: Text(
                            '🇸🇦 العربية',
                            style: TextStyle(
                              fontWeight: langProvider.currentLanguage == 'ar'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
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