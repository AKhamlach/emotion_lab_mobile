import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class CelebrationAnimation extends StatefulWidget {
  const CelebrationAnimation({
    this.onComplete,
    super.key,
  });

  final VoidCallback? onComplete;

  @override
  State<CelebrationAnimation> createState() => _CelebrationAnimationState();
}

class _CelebrationAnimationState extends State<CelebrationAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final _random = Random();

  static const _particleCount = 40;
  static const _colors = [
    Color(0xFF6C63FF),
    Color(0xFF03DAC6),
    Color(0xFFFFD700),
    Color(0xFFFF9800),
    Color(0xFF4CAF50),
    Color(0xFFE91E63),
  ];

  @override
  void initState() {
    super.initState();
    _particles = List.generate(_particleCount, (_) => _generateParticle());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppDimensions.animVerySlow * 2,
      ),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      })
      ..forward();
  }

  _Particle _generateParticle() {
    return _Particle(
      x: _random.nextDouble(),
      speed: 0.5 + _random.nextDouble() * 0.5,
      angle: _random.nextDouble() * pi * 2,
      size: 4 + _random.nextDouble() * 8,
      color: _colors[_random.nextInt(_colors.length)],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _ConfettiPainter(
            particles: _particles,
            progress: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Particle {
  _Particle({
    required this.x,
    required this.speed,
    required this.angle,
    required this.size,
    required this.color,
  });

  final double x;
  final double speed;
  final double angle;
  final double size;
  final Color color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.particles, required this.progress});

  final List<_Particle> particles;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = (1 - progress).clamp(0.0, 1.0);

    for (final p in particles) {
      final x = p.x * size.width + sin(p.angle + progress * 6) * 30;
      final y = progress * size.height * p.speed;
      final paint = Paint()..color = p.color.withAlpha((opacity * 255).toInt());
      canvas.drawCircle(Offset(x, y), p.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}
