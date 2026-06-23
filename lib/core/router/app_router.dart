import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/register_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../providers/secure_storage_provider.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final secureStorage = ref.read(secureStorageProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) async {
      final token = await secureStorage.getToken();
      final isLoggedIn = token != null && token.isNotEmpty;

      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      final isRegisterRoute = state.matchedLocation == AppRoutes.register;
      final isAuthRoute = isLoginRoute || isRegisterRoute;

      if (isAuthRoute) {
        return isLoggedIn ? AppRoutes.home : null;
      }

      if (!isLoggedIn) {
        return AppRoutes.login;
      }

      // Rutas Restringidas (Validación de Roles)
      // if (state.matchedLocation == AppRoutes.adminPanel) {
      //   final roles = await secureStorage.getRoles();
      //   if (!roles.contains('admin')) return AppRoutes.home;
      // }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
