import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/minimap_widget.dart';

class EnhancedMinimapScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onPrevious;
  final VoidCallback onRestart;

  const EnhancedMinimapScreen({
    super.key,
    required this.appState,
    required this.onPrevious,
    required this.onRestart,
  });

  @override
  State<EnhancedMinimapScreen> createState() => _EnhancedMinimapScreenState();
}

class _EnhancedMinimapScreenState extends State<EnhancedMinimapScreen> {
  String _getExitName() {
    final seatStr = widget.appState.seatNumber;
    final rowStr = seatStr.replaceAll(RegExp(r'[A-Z]'), '');
    
    if (rowStr.isEmpty) {
      return widget.appState.language == 'en'
          ? 'Front Exit'
          : 'Salida Frontal';
    }

    final row = int.tryParse(rowStr) ?? 1;

    if (row <= 8) {
      return widget.appState.language == 'en'
          ? 'Front Exit'
          : 'Salida Frontal';
    } else if (row <= 22) {
      return widget.appState.language == 'en'
          ? 'Overwing Exit'
          : 'Salida de Ala';
    } else {
      return widget.appState.language == 'en'
          ? 'Rear Exit'
          : 'Salida Trasera';
    }
  }

  String _getTitle() {
    return widget.appState.language == 'en'
        ? 'Your Evacuation Route'
        : 'Tu Ruta de Evacuación';
  }

  String _getSeatLabel() {
    return widget.appState.language == 'en'
        ? 'Seat: ${widget.appState.seatNumber}'
        : 'Asiento: ${widget.appState.seatNumber}';
  }

  String _getInstructionText() {
    return widget.appState.language == 'en'
        ? 'Follow the animated path to your nearest emergency exit. In case of evacuation, move quickly and help others if possible.'
        : 'Sigue la ruta animada hacia tu salida de emergencia más cercana. En caso de evacuación, muévete rápidamente.';
  }

  String _getCompleteText() {
    return widget.appState.language == 'en'
        ? 'Ready for Departure!'
        : '¡Listo para Despegar!';
  }

  String _getFinishButtonText() {
    return widget.appState.language == 'en' ? 'Finish' : 'Terminar';
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
              // Progress indicator (3 of 3)
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

              // Animated Aircraft Minimap
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFFED4E), width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF1A2E4A),
                ),
                padding: EdgeInsets.all(16),
                child: MinimapWidget(
                  userSeat: widget.appState.seatNumber,
                ),
              ),
              SizedBox(height: 32),

              // Seat Information and Exit Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '💺',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF00FF41), width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF1A2E4A),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _getExitName(),
                            style: TextStyle(
                              color: Color(0xFF00FF41),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '🚪',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.appState.language == 'en'
                          ? 'Safety training complete!'
                          : '¡Capacitación de seguridad completa!',
                      style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 14,
                      ),
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
