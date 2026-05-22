import 'dart:ui';
import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../utils/sizes/border_radius.dart';
import '../../utils/sizes/font_size.dart';
import '../api base/api_helper/api_exception.dart';

class ErrorBottomSheet extends StatelessWidget {
  final AppException exception;
  final VoidCallback? onRetry;

  const ErrorBottomSheet({super.key, required this.exception, this.onRetry});

  /// Displays the premium error bottom sheet.
  static Future<T?> show<T>(
    BuildContext context, {
    required AppException exception,
    VoidCallback? onRetry,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: ErrorBottomSheet(exception: exception, onRetry: onRetry),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Select styling configuration based on exception type
    IconData icon;
    Color color;
    Gradient glowGradient;

    if (exception is NetworkTimeoutException) {
      icon = Icons.wifi_off_rounded;
      color = AppColors.secondary; // Cyan
      glowGradient = const LinearGradient(
        colors: [Color(0x3322D3EE), Color(0x0022D3EE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (exception is ServerErrorException) {
      icon = Icons.dns_rounded;
      color = AppColors.warning; // Amber
      glowGradient = const LinearGradient(
        colors: [Color(0x33F59E0B), Color(0x00F59E0B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      icon = Icons.error_outline_rounded;
      color = AppColors.error; // Red
      glowGradient = const LinearGradient(
        colors: [Color(0x33EF4444), Color(0x00EF4444)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.92),
        border: Border(
          top: BorderSide(
            color: AppColors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),

          // Error Icon Container with soft glow
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: glowGradient,
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            exception.title,
            style: TextStyle(
              fontSize: FontSize.headlineSmall,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              exception.message,
              style: TextStyle(
                fontSize: FontSize.bodyMedium,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 36),

          // Action Buttons
          Row(
            children: [
              if (onRetry != null) ...[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        side: BorderSide(
                          color: AppColors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: FontSize.titleSmall,
                        color: AppColors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onRetry?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                      ),
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          fontSize: FontSize.titleSmall,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                      ),
                      child: Text(
                        "Okay",
                        style: TextStyle(
                          fontSize: FontSize.titleSmall,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
