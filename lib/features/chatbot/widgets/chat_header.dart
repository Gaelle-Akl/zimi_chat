import 'package:flutter/material.dart';
import "../../../app/theme/app_colors.dart";

import '../widgets/zimi_avatar.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
      ),
      child: ClipPath(
        clipper: HeaderWaveClipper(),
        child: Stack(
          children: [
            Positioned(
              left: -35,
              top: 15,
              child: _decorativeCircle(
                95,
                Colors.white.withOpacity(0.05),
              ),
            ),
            Positioned(
              right: -35,
              top: 5,
              child: _decorativeCircle(
                90,
                Colors.white.withOpacity(0.06),
              ),
            ),
            Positioned(
              right: 65,
              top: -35,
              child: _decorativeCircle(
                75,
                Colors.white.withOpacity(0.04),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        ],
                      ),
                    ),
                    _buildMoreButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildBackButton(){
    return SizedBox(
      width: 44,
      height:50,

      child:IconButton(
        onPressed: () {},

        icon:const Icon(
            Icons.arrow_back_ios_new_rounded,
            color:Colors.white,
            size:21,
        ),
      ),
    );
  }

  Widget _buildMoreButton(){
    return Container(
      width:43,
      height:43,
      decoration :BoxDecoration(
        color:Colors.white.withOpacity(0.20),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.more_horiz_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _decorativeCircle(
    double size,
    Color color,
  ) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
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

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.97,
      size.width * 0.32,
      size.height * 0.88,
    );


    path.quadraticBezierTo(
      size.width * 0.48,
      size.height * 0.78,
      size.width * 0.65,
      size.height * 0.87,
    );

    path.quadraticBezierTo(
      size.width * 0.83,
      size.height * 0.97,
      size.width,
      size.height * 0.78,
    );      

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(
    covariant CustomClipper<Path> oldClipper,
  ) {
    return false;
  }
}