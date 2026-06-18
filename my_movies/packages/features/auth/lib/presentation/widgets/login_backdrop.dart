import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class LoginBackdrop extends StatelessWidget {
  const LoginBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff101010),
            AppColors.background,
            Color(0xff080808),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _BackdropLinePainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _BackdropLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;

    for (var y = 0.0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 10), paint);
    }

    final redPaint = Paint()
      ..color = AppColors.cinematicRed.withValues(alpha: 0.05)
      ..strokeWidth = 1.2;

    canvas.drawLine(
      Offset(0, size.height * 0.74),
      Offset(size.width, size.height * 0.72),
      redPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
