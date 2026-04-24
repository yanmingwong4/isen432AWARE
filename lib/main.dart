import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/enhanced_quiz_screen.dart';
import 'screens/enhanced_minimap_screen.dart';

void main() {
  runApp(const AwareApp());
}

class AwareApp extends StatefulWidget {
  const AwareApp({super.key});

  @override
  State<AwareApp> createState() => _AwareAppState();
}

class _AwareAppState extends State<AwareApp> {
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWARE - Safety Quiz',
      theme: _buildAccessibleTheme(),
      home: AwareNavigator(appState: _appState),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildAccessibleTheme() {
    // High-contrast theme with 7:1 luminance ratio
    // Navy/Black background with high-visibility yellow
    const Color darkNavy = Color(0xFF0B1929); // Very dark navy
    const Color brightYellow = Color(0xFFFFED4E); // High-visibility yellow
    const Color white = Color(0xFFFFFFFF);
    const Color darkText = Color(0xFF0B1929);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: brightYellow,
        secondary: Color(0xFF00D4FF), // Cyan for secondary actions
        tertiary: Color(0xFF00FF41), // Lime for success/positive
        error: Color(0xFFFF4444), // Bright red for errors
        surface: darkNavy,
        surfaceContainer: Color(0xFF1A2E4A),
      ),
      scaffoldBackgroundColor: darkNavy,
      appBarTheme: AppBarTheme(
        backgroundColor: darkNavy,
        surfaceTintColor: darkNavy,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: brightYellow,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brightYellow,
          foregroundColor: darkText,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          minimumSize: Size(120, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brightYellow,
          side: BorderSide(color: brightYellow, width: 3),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          minimumSize: Size(120, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: brightYellow,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: brightYellow,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: brightYellow,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: white,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: white,
          fontSize: 16,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1A2E4A),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: brightYellow, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: brightYellow, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: brightYellow, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: TextStyle(color: Color(0xFF888888)),
        labelStyle: TextStyle(color: brightYellow, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AppState {
  String language = 'en'; // 'en' or 'es'
  String seatNumber = '';
  int currentScreenIndex = 0;

  void updateLanguage(String lang) {
    language = lang;
  }

  void updateSeatNumber(String seat) {
    seatNumber = seat;
  }

  void goToQuiz() {
    currentScreenIndex = 1;
  }

  void goToMinimap() {
    currentScreenIndex = 2;
  }

  void reset() {
    language = 'en';
    seatNumber = '';
    currentScreenIndex = 0;
  }
}

class AwareNavigator extends StatefulWidget {
  final AppState appState;

  const AwareNavigator({super.key, required this.appState});

  @override
  State<AwareNavigator> createState() => _AwareNavigatorState();
}

class _AwareNavigatorState extends State<AwareNavigator> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        widget.appState.currentScreenIndex = index;
      },
      children: [
        WelcomeScreen(
          appState: widget.appState,
          onNext: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        EnhancedQuizScreen(
          appState: widget.appState,
          onComplete: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        EnhancedMinimapScreen(
          appState: widget.appState,
          onPrevious: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onRestart: () {
            widget.appState.reset();
            _pageController.jumpToPage(0);
          },
        ),
      ],
    );
  }
}
