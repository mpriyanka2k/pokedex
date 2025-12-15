import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex/features/auth/presentation/screens/login_screen.dart';
import 'package:pokedex/features/pokedex/presentation/screens/pokedex_detail_screen.dart';
import 'package:pokedex/features/pokedex/presentation/screens/pokedex_list_screen.dart';
import 'package:pokedex/core/di/injection.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',

  routes: [
    GoRoute(
      path: '/login',
      name: 'login_screen',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/pokedex_list',
      name: 'pokedex_list_screen',
      builder: (context, state) => const PokedexListScreen(),
    ),
    GoRoute(
      path: '/pokedex_detail/:id',
      name: 'pokedex_detail_screen',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return PokedexDetailScreen(id: id.toString());
      },
    ),
  ],

  redirect: (BuildContext context, GoRouterState state) async {
    final FlutterSecureStorages secureStorage =
        locator<FlutterSecureStorages>();
    final isLoggedIn = await secureStorage.getIsLogedIn();

    final isAuthRoute = state.uri.path == '/login';

    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/pokedex_list';
    }

    return null;
  },
);
