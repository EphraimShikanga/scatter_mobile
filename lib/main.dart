import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'features/board/presentation/pages/scatter_board_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}



final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ScatterBoardPage(),
    ),
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.read(themeModeProvider);
    
    return ThemeProvider(
      duration: const Duration(seconds: 1),
      themeModel: ThemeModel(
        themeMode: themeMode,
        lightTheme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
      builder: (context, themeModel) {
        return MaterialApp.router(
          title: 'Scatter',
          themeMode: themeModel.themeMode,
          theme: themeModel.lightTheme,
          darkTheme: themeModel.darkTheme,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
