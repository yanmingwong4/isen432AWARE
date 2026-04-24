import 'package:flutter/material.dart';
import 'dart:math';

class MinimapPainter extends CustomPainter {
  final String userSeat;
  final double animationValue;

  static const int numRows = 30;
  static const int numCols = 6;
  static const List<String> seatLetters = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const Color navy = Color(0xFF0B1929);
  static const Color yellow = Color(0xFFFFED4E);

  MinimapPainter({
    required this.userSeat,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = navy,
    );

    // Layout constants
    final double margin = size.width * 0.08;
    final double topLabelSpace = 32;
    final double bottomLabelSpace = 32;
    final double gridHeight = size.height - topLabelSpace - bottomLabelSpace;
    final double rowHeight = gridHeight / numRows;
    final double seatSpacing = (size.width - 2 * margin) / (numCols + 1);

    // Draw fuselage (rounded rectangle)
    final fuselageRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        margin / 2,
        topLabelSpace,
        size.width - margin,
        gridHeight,
      ),
      Radius.circular(size.width * 0.18),
    );
    canvas.drawRRect(
      fuselageRect,
      Paint()
        ..color = navy
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      fuselageRect,
      Paint()
        ..color = yellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // Draw labels
    void textPainter(String text, double y, {bool top = true}) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: yellow,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset((size.width - tp.width) / 2, y - (top ? 0 : tp.height)),
      );
    }
    textPainter('FRONT / COCKPIT', 8, top: true);
    textPainter('BACK / TAIL', size.height - 8, top: false);

    // Draw seats
    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numCols; col++) {
        final Offset seatOffset = getOffsetForSeat(
          row + 1,
          seatLetters[col],
          size,
          margin,
          topLabelSpace,
          gridHeight,
          seatSpacing,
        );
        final isUserSeat = userSeat.toUpperCase() ==
            '${row + 1}${seatLetters[col]}'.toUpperCase();
        canvas.drawCircle(
          seatOffset,
          isUserSeat ? 8 : 5,
          Paint()
            ..color = isUserSeat ? yellow : Colors.white
            ..style = PaintingStyle.fill,
        );
        if (isUserSeat) {
          // Draw pulsing dot
          final pulse = 0.5 + 0.5 * sin(animationValue * 2 * pi);
          canvas.drawCircle(
            seatOffset,
            14 * pulse,
            Paint()
              ..color = yellow.withOpacity(0.4)
              ..style = PaintingStyle.fill,
          );
        }
      }
    }

    // Draw exits
    final exitRows = [1, 15, 30];
    for (final exitRow in exitRows) {
      for (final col in [0, 5]) {
        final exitOffset = getOffsetForSeat(
          exitRow,
          seatLetters[col],
          size,
          margin,
          topLabelSpace,
          gridHeight,
          seatSpacing,
        );
        // Exit marker
        canvas.drawRect(
          Rect.fromCenter(center: exitOffset, width: 22, height: 14),
          Paint()
            ..color = yellow
            ..style = PaintingStyle.fill,
        );
        // Exit label
        final tp = TextPainter(
          text: TextSpan(
            text: 'EXIT',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(
          canvas,
          Offset(exitOffset.dx - tp.width / 2, exitOffset.dy - tp.height / 2),
        );
      }
    }

    // Animate path from user seat to nearest exit
    final seatCoord = parseSeat(userSeat);
    if (seatCoord != null) {
      final Offset seatOffset = getOffsetForSeat(
        seatCoord.row,
        seatCoord.letter,
        size,
        margin,
        topLabelSpace,
        gridHeight,
        seatSpacing,
      );
      // Find nearest exit
      final int nearestExitRow = getNearestExitRow(seatCoord.row);
      final int aisleCol = 2; // Between C and D
      final Offset aisleOffset = Offset(
        margin + seatSpacing * (aisleCol + 1),
        topLabelSpace + (seatCoord.row - 0.5) * rowHeight,
      );
      final Offset exitOffset = getOffsetForSeat(
        nearestExitRow,
        seatCoord.letter.codeUnitAt(0) < 'D'.codeUnitAt(0) ? 'A' : 'F',
        size,
        margin,
        topLabelSpace,
        gridHeight,
        seatSpacing,
      );
      final Offset exitAisleOffset = Offset(
        aisleOffset.dx,
        topLabelSpace + (nearestExitRow - 0.5) * rowHeight,
      );

      // Path: seat -> aisle (horizontal), aisle -> exit row (vertical), aisle -> exit (horizontal)
      final List<Offset> pathPoints = [
        seatOffset,
        aisleOffset,
        exitAisleOffset,
        exitOffset,
      ];

      drawDashedPath(
        canvas,
        pathPoints,
        animationValue,
        color: yellow,
        width: 7,
        dashLength: 18,
        gapLength: 12,
      );
    }
  }

  // Helper: Draw dashed path with animation
  void drawDashedPath(
    Canvas canvas,
    List<Offset> points,
    double animationValue, {
    required Color color,
    double width = 6,
    double dashLength = 16,
    double gapLength = 10,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final segment = p2 - p1;
      final segmentLength = segment.distance;
      final direction = (p2 - p1) / segmentLength;
      double progress =
          (animationValue * (dashLength + gapLength)) % (dashLength + gapLength);

      double distance = 0;
      while (distance < segmentLength) {
        final double dash = min(dashLength - progress, segmentLength - distance);
        if (dash > 0) {
          final start = p1 + direction * distance;
          final end = p1 + direction * (distance + dash);
          canvas.drawLine(start, end, paint);
        }
        distance += dashLength + gapLength;
        progress = 0;
      }
    }
  }

  // Helper: Map seat string to Offset
  Offset getOffsetForSeat(
    int row,
    String letter,
    Size size,
    double margin,
    double topLabelSpace,
    double gridHeight,
    double seatSpacing,
  ) {
    final rowHeight = gridHeight / numRows;
    final colIndex = seatLetters.indexOf(letter.toUpperCase());
    return Offset(
      margin + seatSpacing * (colIndex + 1),
      topLabelSpace + (row - 0.5) * rowHeight,
    );
  }

  // Helper: Parse seat string
  _SeatCoord? parseSeat(String seat) {
    final match = RegExp(r'^(\d{1,2}|30)([A-Fa-f])$')
        .firstMatch(seat.trim());
    if (match == null) return null;
    final row = int.parse(match.group(1)!);
    final letter = match.group(2)!.toUpperCase();
    return _SeatCoord(row, letter);
  }

  // Helper: Find nearest exit row
  int getNearestExitRow(int row) {
    if (row <= 8) return 1;
    if (row <= 22) return 15;
    return 30;
  }

  @override
  bool shouldRepaint(MinimapPainter oldDelegate) =>
      oldDelegate.userSeat != userSeat ||
      oldDelegate.animationValue != animationValue;
}

class _SeatCoord {
  final int row;
  final String letter;
  _SeatCoord(this.row, this.letter);
}
