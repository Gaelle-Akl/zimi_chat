import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class ZimiAvatar extends StatelessWidget {
  final double size;

  const ZimiAvatar({
    super.key,
    this.size = 58,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft circular background
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.28),
            ),
          ),

          // Robot head
          Positioned(
            top: size * 0.25,
            child: Container(
              width: size * 0.62,
              height: size * 0.48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size * 0.20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Left eye
                  Positioned(
                    left: size * 0.17,
                    top: size * 0.17,
                    child: _eye(),
                  ),

                  // Right eye
                  Positioned(
                    right: size * 0.17,
                    top: size * 0.17,
                    child: _eye(),
                  ),

                  // Smile
                  Positioned(
                    bottom: size * 0.08,
                    child: Container(
                      width: size * 0.20,
                      height: size * 0.08,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  // Cheeks
                  Positioned(
                    left: size * 0.08,
                    bottom: size * 0.12,
                    child: _cheek(),
                  ),

                  Positioned(
                    right: size * 0.08,
                    bottom: size * 0.12,
                    child: _cheek(),
                  ),
                ],
              ),
            ),
          ),

          // Antenna
          Positioned(
            top: size * 0.08,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: size * 0.12,
                  color: Colors.white,
                ),
                Container(
                  width: size * 0.10,
                  height: size * 0.10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          // Chef hat
          Positioned(
            top: size * 0.16,
            child: SizedBox(
              width: size * 0.38,
              height: size * 0.16,
              child: Stack(
                children: [
                  Positioned(
                    left: size * 0.08,
                    right: size * 0.08,
                    bottom: 0,
                    child: Container(
                      height: size * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 0,
                    child: _hatBubble(),
                  ),

                  Positioned(
                    left: size * 0.10,
                    top: -size * 0.01,
                    child: _hatBubble(),
                  ),

                  Positioned(
                    right: 0,
                    top: 0,
                    child: _hatBubble(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eye() {
    return Container(
      width: size * 0.10,
      height: size * 0.10,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _cheek() {
    return Container(
      width: size * 0.08,
      height: size * 0.05,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _hatBubble() {
    return Container(
      width: size * 0.14,
      height: size * 0.14,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}