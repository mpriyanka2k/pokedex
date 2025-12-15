import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/features/auth/presentation/riverpod/auth_notifire.dart';
import 'package:pokedex/core/di/injection.dart';
import '../../../../core/flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
   locator<FlutterSecureStorages>()
  );
});
