import 'package:flutter/material.dart';
import 'dart:math' as math;

class Seat {
  final int row;
  final int column;
  final String id;
  final Offset position;

  Seat({
    required this.row,
    required this.column,
    required this.id,
    required this.position,
  });
}

class Exit {
  final String name;
  final Offset position;
  final String type; // 'front', 'overwing', 'rear'

  Exit({
    required this.name,
    required this.position,
    required this.type,
  });
}

class EnhancedAircraftPainter extends CustomPainter {
  final String seatNumber;
  final double animationProgress;
  final String exitType; // 'front', 'overwing', 'rear'

  static const double seatSize = 18;
  static const int totalRows = 20;
  static const int seatsPerSide = 3;

  EnhancedAircraftPainter({
    required this.seatNumber,
    required this.animationProgress,
    required this.exitType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Draw aircraft body
    _drawAircraftBody(canvas, width, height);

    // Draw seats
    _drawSeats(canvas, width, height);

    // Draw exits
    _drawExits(canvas, width, height);

    // Draw evacuation path and animate
    _drawEvacuationPath(canvas, width, height);
    _drawAnimatedPerson(canvas, width, height);
  }

  void _drawAircraftBody(Canvas canvas, double width, double height) {
    // Draw fuselage outline
    final paint = Paint()
      ..color = Color(0xFF00D4FF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fuselagePath = Path()
      ..moveTo(width * 0.1, height * 0.08)
      ..lineTo(width * 0.9, height * 0.12)
      ..lineTo(width * 0.9, height * 0.88)
      ..lineTo(width * 0.1, height * 0.92)
      ..close();

    canvas.drawPath(fuselagePath, paint);

    // Draw cockpit
    final cockpitPaint = Paint()
      ..color = Color(0xFF00FF41)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(width * 0.5, height * 0.05),
        width: width * 0.12,
        height: height * 0.06,
      ),
      cockpitPaint,
    );
  }

  void _drawSeats(Canvas canvas, double width, double height) {
    final startX = width * 0.12;
    final startY = height * 0.18;
    final seatsWidth = width * 0.76;
    final seatsHeight = height * 0.7;

    final seatSpacingH = seatsWidth / (seatsPerSide * 2 + 1.5);
    final seatSpacingV = seatsHeight / totalRows;

    for (int row = 0; row < totalRows; row++) {
      final String rowLabel = (row + 1).toString();

      // Left section (3 seats: A, B, C)
      for (int col = 0; col < seatsPerSide; col++) {
        final double x = startX + seatSpacingH * (col + 0.5);
        final double y = startY + seatSpacingV * row;
        final String seatId = rowLabel + String.fromCharCode(65 + col);
        _drawSeat(canvas, x, y, seatId);
      }

      // Right section (3 seats: D, E, F)
      for (int col = 0; col < seatsPerSide; col++) {
        final double x = startX + seatSpacingH * (seatsPerSide + col + 1);
        final double y = startY + seatSpacingV * row;
        final String seatId = rowLabel + String.fromCharCode(65 + seatsPerSide + col);
        _drawSeat(canvas, x, y, seatId);
      }
    }
  }

  void _drawSeat(Canvas canvas, double x, double y, String seatId) {
    final isSelected = seatId == seatNumber;

    final paint = Paint()
      ..color = isSelected ? Color(0xFFFFED4E) : Color(0xFF555555)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = isSelected ? Color(0xFFFFED4E) : Color(0xFF00D4FF)
      ..strokeWidth = isSelected ? 2 : 1
      ..style = PaintingStyle.stroke;

    // Draw seat as small rectangle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(x, y), width: seatSize, height: seatSize),
        Radius.circular(2),
      ),
      paint,
    );

    if (isSelected) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, y), width: seatSize, height: seatSize),
          Radius.circular(2),
        ),
        borderPaint,
      );
    }
  }

  Offset _getExitPosition(double width, double height, String type) {
    switch (type) {
      case 'front':
        return Offset(width * 0.5, height * 0.13);
      case 'overwing':
        return Offset(width * 0.5, height * 0.50);
      case 'rear':
        return Offset(width * 0.5, height * 0.87);
      default:
        return Offset(width * 0.5, height * 0.13);
    }
  }

  List<Exit> _drawExits(Canvas canvas, double width, double height) {
    final exitPaint = Paint()
      ..color = Color(0xFF00FF41)
      ..style = PaintingStyle.fill;

    final exits = [
      Exit(
        name: 'Front Left',
        position: Offset(width * 0.11, height * 0.13),
        type: 'front',
      ),
      Exit(
        name: 'Front Right',
        position: Offset(width * 0.89, height * 0.13),
        type: 'front',
      ),
      Exit(
        name: 'Overwing Left',
        position: Offset(width * 0.11, height * 0.50),
        type: 'overwing',
      ),
      Exit(
        name: 'Overwing Right',
        position: Offset(width * 0.89, height * 0.50),
        type: 'overwing',
      ),
      Exit(
        name: 'Rear Left',
        position: Offset(width * 0.11, height * 0.87),
        type: 'rear',
      ),
      Exit(
        name: 'Rear Right',
        position: Offset(width * 0.89, height * 0.87),
        type: 'rear',
      ),
    ];

    for (var exit in exits) {
      canvas.drawRect(
        Rect.fromCenter(
          center: exit.position,
          width: width * 0.07,
          height: height * 0.07,
        ),
        exitPaint,
      );

      // Draw "EXIT" text
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'EXIT',
          style: TextStyle(
            color: Color(0xFF0B1929),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          exit.position.dx - textPainter.width / 2,
          exit.position.dy - textPainter.height / 2,
        ),
      );
    }

    return exits;
  }

  List<Offset> _calculateEvacuationPath(double width, double height) {
    // Parse seat number
    final rowStr = seatNumber.replaceAll(RegExp(r'[A-Z]'), '');
    final colStr = seatNumber.replaceAll(RegExp(r'[0-9]'), '');

    if (rowStr.isEmpty || colStr.isEmpty) {
      return [];
    }

    final row = int.tryParse(rowStr) ?? 1;
    final col = colStr.codeUnitAt(0) - 65; // A=0, B=1, etc.

    // Calculate seat position
    final startX = width * 0.12;
    final startY = height * 0.18;
    final seatsWidth = width * 0.76;
    final seatsHeight = height * 0.7;

    final seatSpacingH = seatsWidth / (seatsPerSide * 2 + 1.5);
    final seatSpacingV = seatsHeight / totalRows;
    final aisleX = width * 0.5;

    final double seatX = col < seatsPerSide
        ? startX + seatSpacingH * (col + 0.5)
        : startX + seatSpacingH * (seatsPerSide + col - seatsPerSide + 1);

    final double seatY = startY + seatSpacingV * (row - 1);

    // Get exit position based on exitType
    final exitPos = _getExitPosition(width, height, exitType);

    // Create path: seat -> aisle -> exit
    return [
      Offset(seatX, seatY), // Starting seat
      Offset(aisleX, seatY), // Move to aisle
      Offset(aisleX, (seatY + exitPos.dy) / 2), // Halfway to exit
      exitPos, // Exit
    ];
  }

  void _drawEvacuationPath(Canvas canvas, double width, double height) {
    final path = _calculateEvacuationPath(width, height);
    if (path.length < 2) return;

    final pathPaint = Paint()
      ..color = Color(0xFFFFED4E).withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw the path
    final pathObj = Path();
    pathObj.moveTo(path[0].dx, path[0].dy);
    for (int i = 1; i < path.length; i++) {
      pathObj.lineTo(path[i].dx, path[i].dy);
    }
    canvas.drawPath(pathObj, pathPaint);

    // Draw animated arrows along the path
    _drawAnimatedArrows(canvas, path);
  }

  void _drawAnimatedArrows(Canvas canvas, List<Offset> path) {
    if (path.length < 2) return;

    final arrowPaint = Paint()
      ..color = Color(0xFFFFED4E)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double arrowSize = 8.0;

    // Draw arrows at intervals
    for (double i = 0; i <= 1.0; i += 0.15) {
      final pulseFactor = (animationProgress + i) % 1.0;
      final opacity = (math.sin(pulseFactor * math.pi * 2) + 1) / 2;

      if (opacity < 0.3) continue;

      final point = _getPointOnPath(path, i);
      if (point == null) continue;

      // Draw arrowhead
      final nextI = math.min(i + 0.05, 1.0);
      final nextPoint = _getPointOnPath(path, nextI);
      if (nextPoint == null) continue;

      final angle = math.atan2(
        nextPoint.dy - point.dy,
        nextPoint.dx - point.dx,
      );

      final p1 = Offset(
        point.dx - arrowSize * math.cos(angle - math.pi / 6),
        point.dy - arrowSize * math.sin(angle - math.pi / 6),
      );
      final p2 = Offset(
        point.dx - arrowSize * math.cos(angle + math.pi / 6),
        point.dy - arrowSize * math.sin(angle + math.pi / 6),
      );

      arrowPaint.color = Color(0xFFFFED4E).withOpacity(opacity);
      canvas.drawLine(point, p1, arrowPaint);
      canvas.drawLine(point, p2, arrowPaint);
    }
  }

  void _drawAnimatedPerson(Canvas canvas, double width, double height) {
    final path = _calculateEvacuationPath(width, height);
    if (path.isEmpty) return;

    // Calculate current position on path based on animation progress
    final currentPos = _getPointOnPath(path, animationProgress);
    if (currentPos == null) return;

    // Draw animated person/dot
    final personPaint = Paint()
      ..color = Color(0xFFFFED4E)
      ..style = PaintingStyle.fill;

    // Outer glow
    canvas.drawCircle(currentPos, 8, personPaint..color = Color(0xFFFFED4E).withOpacity(0.3));

    // Main circle
    canvas.drawCircle(currentPos, 5, personPaint..color = Color(0xFFFFED4E));

    // Inner highlight
    canvas.drawCircle(
      currentPos,
      3,
      personPaint..color = Color(0xFFFFFFFF).withOpacity(0.7),
    );
  }

  Offset? _getPointOnPath(List<Offset> path, double progress) {
    if (path.isEmpty) return null;
    if (progress <= 0) return path[0];
    if (progress >= 1.0) return path.last;

    // Find the segment
    for (int i = 0; i < path.length - 1; i++) {
      final segmentStart = i / (path.length - 1);
      final segmentEnd = (i + 1) / (path.length - 1);

      if (progress >= segmentStart && progress <= segmentEnd) {
        final segmentProgress = (progress - segmentStart) / (segmentEnd - segmentStart);
        final start = path[i];
        final end = path[i + 1];

        return Offset(
          start.dx + (end.dx - start.dx) * segmentProgress,
          start.dy + (end.dy - start.dy) * segmentProgress,
        );
      }
    }

    return path.last;
  }

  @override
  bool shouldRepaint(EnhancedAircraftPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.seatNumber != seatNumber ||
        oldDelegate.exitType != exitType;
  }
}
