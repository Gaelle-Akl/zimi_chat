import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class DeliveryStatusCard extends StatelessWidget {
  final String status;
  final String arrivalTime;
  final String orderNumber;

  const DeliveryStatusCard({
    super.key,
    required this.status,
    required this.arrivalTime,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order update + status
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.primary,
                  size: 23,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER UPDATE',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Your order is on the way',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // Status pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 5),

                    Text(
                      status,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Arrival information
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ESTIMATED ARRIVAL',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      arrivalTime,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                orderNumber,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          // Progress bar
          Row(
            children: [
              _ProgressPoint(
                active: true,
                completed: true,
              ),

              Expanded(
                child: Container(
                  height: 3,
                  color: AppColors.primary,
                ),
              ),

              _ProgressPoint(
                active: true,
                completed: false,
              ),

              Expanded(
                child: Container(
                  height: 3,
                  color: AppColors.border,
                ),
              ),

              _ProgressPoint(
                active: false,
                completed: false,
              ),
            ],
          ),

          const SizedBox(height: 7),

          // Progress labels
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Preparing',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  'On the way',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  'You',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressPoint extends StatelessWidget {
  final bool active;
  final bool completed;

  const _ProgressPoint({
    required this.active,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primary
            : AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: active
              ? AppColors.primary
              : AppColors.border,
          width: 2,
        ),
      ),
      child: completed
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 11,
            )
          : null,
    );
  }
}