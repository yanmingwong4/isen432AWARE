import 'package:flutter/material.dart';
import 'dart:math' as math;

class AircraftPainter extends CustomPainter {
  final String seatNumber;
  
  static const double seatSize = 20;
  static const double seatSpacing = 10;
  static const double aisle = 15;
  
  // Seat mapping: rows and columns
  // Format: "Row + Section(A, B, C or D, E, F)"
  // 3-3 configuration (left and right sections separated by aisle)
  
  AircraftPainter({required this.seatNumber});

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
    
    // Draw emergency exit arrows
    _drawExitArrows(canvas, width, height);
  }

  void _drawAircraftBody(Canvas canvas, double width, double height) {
    // Draw fuselage outline
    final paint = Paint()
      ..color = Color(0xFF00D4FF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final fuselagePath = Path()
      ..moveTo(width * 0.1, height * 0.1)
      ..lineTo(width * 0.9, height * 0.15)
      ..lineTo(width * 0.9, height * 0.85)
      ..lineTo(width * 0.1, height * 0.9)
      ..close();
    
    canvas.drawPath(fuselagePath, paint);
    
    // Draw cockpit
    final cockpitPaint = Paint()
      ..color = Color(0xFF00FF41)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(width * 0.5, height * 0.08),
        width: width * 0.15,
        height: height * 0.08,
      ),
      cockpitPaint,
    );
  }

  void _drawSeats(Canvas canvas, double width, double height) {
    const int rows = 15;
    const int seatsPerSide = 3; // 3 seats on each side of aisle
    
    final double startX = width * 0.15;
    final double startY = height * 0.2;
    final double seatsWidth = width * 0.7;
    final double seatsHeight = height * 0.65;
    
    final double seatSpacingH = seatsWidth / (seatsPerSide * 2 + 1);
    final double seatSpacingV = seatsHeight / rows;

    for (int row = 0; row < rows; row++) {
      final String rowLabel = (row + 1).toString();
      
      // Left section (3 seats: A, B, C)
      for (int col = 0; col < seatsPerSide; col++) {
        final double x = startX + seatSpacingH * (col + 1);
        final double y = startY + seatSpacingV * row;
        final String seatId = rowLabel + String.fromCharCode(65 + col);
        
        _drawSeat(canvas, x, y, seatId);
      }
      
      // Right section (3 seats: D, E, F)
      for (int col = 0; col < seatsPerSide; col++) {
        final double x = startX + seatSpacingH * (seatsPerSide + col + 1.5);
        final double y = startY + seatSpacingV * row;
        final String seatId = rowLabel + String.fromCharCode(65 + seatsPerSide + col);
        
        _drawSeat(canvas, x, y, seatId);
      }
    }
  }

  void _drawSeat(Canvas canvas, double x, double y, String seatId) {
    final isSelected = seatId == seatNumber;
    
    final paint = Paint()
      ..color = isSelected ? Color(0xFFFFED4E) : Color(0xFF888888)
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
    
    if (isSelected || seatId == seatNumber) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, y), width: seatSize, height: seatSize),
          Radius.circular(2),
        ),
        borderPaint,
      );
    }
  }

  void _drawExits(Canvas canvas, double width, double height) {
    final exitPaint = Paint()
      ..color = Color(0xFF00FF41)
      ..style = PaintingStyle.fill;
    
    // Front left exit
    canvas.drawRect(
      Rect.fromLTWH(width * 0.12, height * 0.15, width * 0.08, height * 0.08),
      exitPaint,
    );
    
    // Front right exit
    canvas.drawRect(
      Rect.fromLTWH(width * 0.8, height * 0.15, width * 0.08, height * 0.08),
      exitPaint,
    );
    
    // Rear left exit
    canvas.drawRect(
      Rect.fromLTWH(width * 0.12, height * 0.77, width * 0.08, height * 0.08),
      exitPaint,
    );
    
    // Rear right exit
    canvas.drawRect(
      Rect.fromLTWH(width * 0.8, height * 0.77, width * 0.08, height * 0.08),
      exitPaint,
    );
    
    // Draw "EXIT" text on exits
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'EXIT',
        style: TextStyle(
          color: Color(0xFF0B1929),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    
    // Front left
    textPainter.paint(canvas, Offset(width * 0.12 + 2, height * 0.17));
    
    // Front right
    textPainter.paint(canvas, Offset(width * 0.8 + 2, height * 0.17));
    
    // Rear left
    textPainter.paint(canvas, Offset(width * 0.12 + 2, height * 0.79));
    
    // Rear right
    textPainter.paint(canvas, Offset(width * 0.8 + 2, height * 0.79));
  }

  void _drawExitArrows(Canvas canvas, double width, double height) {
    // Find nearest exit to passenger seat and draw arrows
    if (seatNumber.isEmpty) return;
    
    // Parse seat number (e.g., "12A" -> row 12, column A)
    final rowStr = seatNumber.replaceAll(RegExp(r'[A-Z]'), '');
    final colStr = seatNumber.replaceAll(RegExp(r'[0-9]'), '');
    
    if (rowStr.isEmpty || colStr.isEmpty) return;
    
    final row = int.tryParse(rowStr) ?? 0;
    final col = colStr.codeUnitAt(0) - 65; // A=0, B=1, etc.
    
    // Determine which exit is nearest
    final isFrontHalf = row <= 8;
    final isLeftSide = col < 3;
    
    Offset targetExit;
    if (isFrontHalf && isLeftSide) {
      targetExit = Offset(width * 0.16, height * 0.19);
    } else if (isFrontHalf && !isLeftSide) {
      targetExit = Offset(width * 0.84, height * 0.19);
    } else if (!isFrontHalf && isLeftSide) {
      targetExit = Offset(width * 0.16, height * 0.81);
    } else {
      targetExit = Offset(width * 0.84, height * 0.81);
    }
    
    // Calculate seat position
    final startX = width * 0.15 + (width * 0.7) * (col + 1) / 7;
    final startY = height * 0.2 + (height * 0.65) * row / 15;
    
    _drawArrow(canvas, Offset(startX, startY), targetExit);
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to) {
    final paint = Paint()
      ..color = Color(0xFFFFED4E)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    // Draw line
    canvas.drawLine(from, to, paint);
    
    // Draw arrowhead
    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const arrowSize = 12.0;
    
    final p1 = Offset(
      to.dx - arrowSize * math.cos(angle - math.pi / 6),
      to.dy - arrowSize * math.sin(angle - math.pi / 6),
    );
    final p2 = Offset(
      to.dx - arrowSize * math.cos(angle + math.pi / 6),
      to.dy - arrowSize * math.sin(angle + math.pi / 6),
    );
    
    canvas.drawLine(to, p1, paint);
    canvas.drawLine(to, p2, paint);
  }

  @override
  bool shouldRepaint(AircraftPainter oldDelegate) {
    return oldDelegate.seatNumber != seatNumber;
  }
}
