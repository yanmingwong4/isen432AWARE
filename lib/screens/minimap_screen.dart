import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/aircraft_painter.dart';

class MinimapScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onPrevious;
  final VoidCallback onRestart;

  const MinimapScreen({
    super.key,
    required this.appState,
    required this.onPrevious,
    required this.onRestart,
  });

  @override
  State<MinimapScreen> createState() => _MinimapScreenState();
}

class _MinimapScreenState extends State<MinimapScreen> {
  String _getTitle() {
    return widget.appState.language == 'en'
        ? 'Your Seat Location'
        : 'Tu Ubicación de Asiento';
  }

  String _getSeatLabel() {
    return widget.appState.language == 'en'
        ? 'Seat: ${widget.appState.seatNumber}'
        : 'Asiento: ${widget.appState.seatNumber}';
  }

  String _getExitLabel() {
    return widget.appState.language == 'en'
        ? 'Nearest Exit'
        : 'Salida Más Cercana';
  }

  String _getInstructionText() {
    return widget.appState.language == 'en'
        ? 'Familiarize yourself with the emergency exits. Follow the illuminated signs in case of evacuation.'
        : 'Familiarícete con las salidas de emergencia. Sigue los señalamientos iluminados en caso de evacuación.';
  }

  String _getCompleteText() {
    return widget.appState.language == 'en'
        ? 'Quiz Complete!'
        : '¡Cuestionario Completo!';
  }

  String _getFinishButtonText() {
    return widget.appState.language == 'en'
        ? 'Finish'
        : 'Terminar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Procedures'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Progress indicator
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFED4E),
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Color(0xFF0B1929),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(width: 12, height: 4, color: Color(0xFF00D4FF)),
                    SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFED4E),
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Color(0xFF0B1929),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(width: 12, height: 4, color: Color(0xFF00D4FF)),
                    SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFED4E),
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Color(0xFF0B1929),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Title
              Text(
                _getTitle(),
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // Aircraft Minimap
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFFED4E), width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF1A2E4A),
                ),
                padding: EdgeInsets.all(16),
                child: CustomPaint(
                  painter: AircraftPainter(
                    seatNumber: widget.appState.seatNumber,
                  ),
                  size: Size(double.infinity, 400),
                ),
              ),
              SizedBox(height: 32),

              // Seat Information
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF00D4FF), width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF1A2E4A),
                ),
                child: Column(
                  children: [
                    Text(
                      _getSeatLabel(),
                      style: TextStyle(
                        color: Color(0xFFFFED4E),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _getExitLabel(),
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Instructions
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF888888), width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF1A2E4A).withOpacity(0.5),
                ),
                child: Text(
                  _getInstructionText(),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32),

              // Completion Message
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF00FF41), width: 3),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF1A2E4A),
                ),
                child: Column(
                  children: [
                    Text(
                      '✓',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      _getCompleteText(),
                      style: TextStyle(
                        color: Color(0xFFFFED4E),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: widget.onPrevious,
                    child: Text(
                      widget.appState.language == 'en' ? 'Back' : 'Atrás',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.onRestart,
                    child: Text(
                      _getFinishButtonText(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
