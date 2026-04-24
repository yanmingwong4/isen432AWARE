import 'dart:async';
import 'package:flutter/material.dart';
import 'minimap_painter.dart';

class MinimapWidget extends StatefulWidget {
  final String userSeat; // e.g., "22D"
  const MinimapWidget({super.key, required this.userSeat});

  @override
  State<MinimapWidget> createState() => _MinimapWidgetState();
}

class _MinimapWidgetState extends State<MinimapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    // For accessibility, restart animation every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.45, // Tall and narrow for aircraft
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: MinimapPainter(
              userSeat: widget.userSeat,
              animationValue: _controller.value,
            ),
            willChange: true,
          );
        },
      ),
    );
  }
}
