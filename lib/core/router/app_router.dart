import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/activities/views/activity_details_screen.dart';
import '../../features/activities/views/create_activity_screen.dart';
import '../../features/activities/views/program_activities_screen.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/register_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/profile/views/profile_screen.dart';
import '../../features/programs/models/program_response_dto.dart';
import '../../features/programs/views/create_program_screen.dart';
import '../../features/programs/views/edit_program_screen.dart';
import '../../features/programs/views/program_details_screen.dart';
import '../../features/programs/views/programs_screen.dart';
import '../providers/secure_storage_provider.dart';
import '../widgets/layout/main_layout_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final secureStorage = ref.read(secureStorageProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
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
        path: AppRoutes.createProgram,
        builder: (context, state) => const CreateProgramScreen(),
      ),
      GoRoute(
        path: AppRoutes.programDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final program = state.extra as ProgramResponseDto?;
          return ProgramDetailsScreen(programCode: id, programExtra: program);
        },
      ),
      GoRoute(
        path: AppRoutes.editProgram,
        builder: (context, state) {
          final program = state.extra as ProgramResponseDto;
          return EditProgramScreen(program: program);
        },
      ),
      GoRoute(
        path: AppRoutes.programActivities,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProgramActivitiesScreen(programCode: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createProgramActivity,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CreateActivityScreen(programCode: id);
        },
      ),
      GoRoute(
        path: AppRoutes.activityDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ActivityDetailsScreen(activityCode: id);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.programs,
                builder: (context, state) => const ProgramsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
