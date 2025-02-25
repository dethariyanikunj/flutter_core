import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityManager {
  static final ConnectivityManager instance = ConnectivityManager._internal();

  factory ConnectivityManager({
    Function(bool isConnected)? callback,
  }) {
    if (callback != null) {
      instance.connectionCallback = callback;
    }
    return instance;
  }

  ConnectivityManager._internal();

  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivitySubscription =>
      _connectivity.onConnectivityChanged;

  Function(bool isConnected)? connectionCallback;

  RxBool isNetConnected = false.obs;

  Future<bool> checkInternet() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      for (final result in connectivityResult) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.ethernet) {
          return true;
        }
      }
      return false;
    } on PlatformException catch (e) {
      debugPrint('Could not check connectivity status: $e');
      return false;
    }
  }

  void setConnectionCallBack({Function(bool isConnected)? callback}) {
    if (callback != null) {
      connectionCallback = callback;
    }
  }

  void setConnectivityListener() async {
    connectivitySubscription.listen(
      (events) {
        for (final event in events) {
          if (event.name == 'none') {
            isNetConnected.value = false;
            return;
          }
          isNetConnected.value = true;
        }
        connectionCallback?.call(isNetConnected.value);
      },
    );
  }
}
