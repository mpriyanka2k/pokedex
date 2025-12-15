import 'package:flutter/material.dart';

class AuthState {
  final bool isLoading;
  final bool isObscured;
  final String? error;
  final bool isSuccess;

  const AuthState({
    this.isLoading = false,
    this.isObscured = true,
    this.error,
    this.isSuccess = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isObscured,
    String? error,
    bool? isSuccess,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isObscured: isObscured ?? this.isObscured,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
