import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class WelcomeScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onNext;

  const WelcomeScreen({
    super.key,
    required this.appState,
    required this.onNext,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController _seatController;

  @override
  void initState() {
    super.initState();
    _seatController = TextEditingController(text: widget.appState.seatNumber);
  }

  @override
  void dispose() {
    _seatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AWARE Safety Quiz'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Message
                Text(
                  'Welcome Aboard',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Let\'s keep everyone safe!',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),

                // Language Selector
                Text(
                  'Select Your Language',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // English Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.appState.updateLanguage('en');
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.appState.language == 'en'
                                ? Color(0xFFFFED4E)
                                : Color(0xFF888888),
                            width: widget.appState.language == 'en' ? 4 : 2,
                          ),
                          color: widget.appState.language == 'en'
                              ? Color(0xFF1A2E4A)
                              : Color(0xFF0B1929),
                        ),
                        padding: EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Text(
                              '🇺🇸',
                              style: TextStyle(fontSize: 48),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'English',
                              style: TextStyle(
                                color: widget.appState.language == 'en'
                                    ? Color(0xFFFFED4E)
                                    : Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Spanish Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.appState.updateLanguage('es');
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.appState.language == 'es'
                                ? Color(0xFFFFED4E)
                                : Color(0xFF888888),
                            width: widget.appState.language == 'es' ? 4 : 2,
                          ),
                          color: widget.appState.language == 'es'
                              ? Color(0xFF1A2E4A)
                              : Color(0xFF0B1929),
                        ),
                        padding: EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Text(
                              '🇪🇸',
                              style: TextStyle(fontSize: 48),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Español',
                              style: TextStyle(
                                color: widget.appState.language == 'es'
                                    ? Color(0xFFFFED4E)
                                    : Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48),

                // Seat Number Entry
                Text(
                  'Enter Your Seat Number',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _seatController,
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))
                  ],
                  onChanged: (value) {
                    widget.appState.updateSeatNumber(value.toUpperCase());
                  },
                  decoration: InputDecoration(
                    hintText: 'e.g., 12A',
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                SizedBox(height: 48),

                // Continue Button
                ElevatedButton(
                  onPressed: widget.appState.seatNumber.isNotEmpty
                      ? () {
                          widget.onNext();
                        }
                      : null,
                  child: Text(
                    widget.appState.language == 'en' ? 'Continue' : 'Continuar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
