import 'package:go_router/go_router.dart';
import 'package:leximatch/core/router/route_path.dart';
import 'package:leximatch/feature/game/ui/game_result.dart';
import 'package:leximatch/feature/game/ui/game_screen.dart';
import 'package:leximatch/feature/home/ui/home_screen.dart';
import 'package:leximatch/feature/splash/ui/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.home,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePath.game,
      builder: (context, state) => const GameScreen(),
    ),
    GoRoute(
      path: RoutePath.result,
      builder: (context, state) => const GameResult(),
    ),
  ],
);
