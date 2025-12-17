
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
enum InternetStatus { connected, disconnected }

final connectivityProvider = StreamProvider<InternetStatus>((ref) {
  
  final connectivity = Connectivity();

  return connectivity.onConnectivityChanged.asyncMap((result) async {
    if (result == ConnectivityResult.none) {
      return InternetStatus.disconnected;
    }

    final hasInternet = await hasInternetAccess();
    return hasInternet
        ? InternetStatus.connected
        : InternetStatus.disconnected;
  });
});

Future<bool> hasInternetAccess() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

