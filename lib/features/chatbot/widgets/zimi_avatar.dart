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
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.28),
            ),
          ),

          Positioned(
            top: size * 0.34,
            child: Container(
              width: size * 0.54,
              height: size * 0.45,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(
                  size * 0.18,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: Stack(
                children: [
                  // Left eye
                  Positioned(
                    left: size * 0.13,
                    top: size * 0.13,
                    child: _eye(),
                  ),

                  // Right eye
                  Positioned(
                    right: size * 0.13,
                    top: size * 0.13,
                    child: _eye(),
                  ),

                  Positioned(
                    left: size * 0.07,
                    bottom: size * 0.17,
                    child: _cheek(),
                  ),

                  Positioned(
                    right: size * 0.07,
                    bottom: size * 0.17,
                    child: _cheek(),
                  ),

                  // Smile
                  Positioned(
                    left: size * 0.21,
                    right: size * 0.21,
                    bottom: size * 0.1,
                    child: Container(
                      height: size * 0.9,

                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primary,
                            width: 3,
                          ),
                        ),

                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            top: size * 0.17,
            child: SizedBox(
              width: size * 0.46,
              height: size * 0.27,

              child: Stack(
                clipBehavior: Clip.none,
                children: [
             
                  Positioned(
                    left: size * 0.02,
                    top: size * 0.02,
                    child: _hatPuff(size * 0.17),
                  ),

                  Positioned(
                    left: size * 0.14,
                    top: -size * 0.015,
                    child: _hatPuff(size * 0.20),
                  ),

                  Positioned(
                    right: size * 0.02,
                    top: size * 0.02,
                    child: _hatPuff(size * 0.17),
                  ),

                  Positioned(
                    left: size * 0.07,
                    right: size * 0.07,
                    top: size * 0.10,
                    child: Container(
                      height: size * 0.14,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(
                          size * 0.04,
                        ),

                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    left: size * 0.055,
                    right: size * 0.055,
                    bottom: 0,
                    child: Container(
                      height: size * 0.08,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(
                          size * 0.035,
                        ),

                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
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
      width: size * 0.085,
      height: size * 0.085,

      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _cheek() {
    return Container(
      width: size * 0.075,
      height: size * 0.045,

      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _hatPuff(double diameter) {
    return Container(
      width: diameter,
      height: diameter,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        border: Border.all(
          color: AppColors.primary,
          width: 1.2,
        ),
      ),
    );
  }
}