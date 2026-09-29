import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../providers/chat_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/zimi_avatar.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Container(
      height: 155,
      width: double.infinity,
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              _buildBackButton(),
              const SizedBox(width: 4),
              const ZimiAvatar(size: 58),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zimi Assistant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Your food companion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
=======
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

                        onPressed: () {},

                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    // Zimi
                    const ZimiAvatar(
                      size: 60,
                    ),

                    const SizedBox(width: 14),

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

            
                    Container(
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
>>>>>>> gaelle/feature/chat-ui
                  ],
                ),
              ),
              _buildMoreButton(context),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildBackButton() {
    return SizedBox(
      width: 44,
      height: 50,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 21,
        ),
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      icon: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.20),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.more_horiz_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      onSelected: (value) {
        if (value == 'refresh') {
          final chatProvider = Provider.of<ChatProvider>(context, listen: false);
          final cartProvider = Provider.of<CartProvider>(context, listen: false);

          // Clears both chat state and active order status
          chatProvider.clearMessages(cartProvider);
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'refresh',
          child: Row(
            children: [
              Icon(Icons.refresh_rounded, color: AppColors.primary, size: 20),
              SizedBox(width: 10),
              Text(
                'Refresh Chat',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
=======
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
>>>>>>> gaelle/feature/chat-ui
  }
}