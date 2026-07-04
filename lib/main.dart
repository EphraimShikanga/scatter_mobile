import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'features/board/presentation/pages/scatter_board_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
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
    final themeMode = ref.watch(themeModeProvider);
    
    return ThemeProvider(
      initTheme: themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme,
      builder: (context, myTheme) {
        return MaterialApp.router(
          title: 'Scatter',
          theme: myTheme,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
