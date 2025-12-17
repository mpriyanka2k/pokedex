import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {

  final FlutterSecureStorages secureStorage;

  AuthNotifier(this.secureStorage) : super(const AuthState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    state = state.copyWith(isObscured: !state.isObscured,isSuccess: false);
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

     await secureStorage.setIsLogedIn(true);

    await Future.delayed(const Duration(seconds: 5));

   secureStorage.saveUserEmailAndPassword(
      emailController.text,
      passwordController.text,
    );

    state = state.copyWith(isLoading: false, isSuccess: true);


  }

  Future<void> logout() async{
    await secureStorage.clearAll();
  }

  Future<void> isUserLoggedIn() async {
    final isLogged = await secureStorage.getIsLogedIn();
    
    
  }
}
