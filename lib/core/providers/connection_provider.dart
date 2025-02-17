import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/logger.dart';

enum ConnectionStatus {
  connected,
  disconnected,
  waiting,
}

class ConnectionState {
  final ConnectionStatus status;
  final String? error;

  const ConnectionState({
    required this.status,
    this.error,
  });

  factory ConnectionState.initial() {
    return const ConnectionState(status: ConnectionStatus.waiting);
  }
}

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final Connectivity _connectivity;
  StreamSubscription? _subscription;
  Timer? _testTimer;

  ConnectionNotifier(this._connectivity) : super(ConnectionState.initial()) {
    _init();
  }

  void _init() {
    // Listen to connectivity changes
    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // Initial check
    _checkConnection();

    // Set up periodic connection test
    _testTimer = Timer.periodic(
        const Duration(minutes: 1), (_) => _testFirebaseConnection());
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      state = const ConnectionState(status: ConnectionStatus.disconnected);
    } else {
      _testFirebaseConnection();
    }
  }

  Future<void> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(result);
  }

  Future<void> _testFirebaseConnection() async {
    try {
      // Try to make a simple request to Firestore
      await FirebaseFirestore.instance
          .collection('_connectivity_test')
          .limit(1)
          .get();

      state = const ConnectionState(status: ConnectionStatus.connected);
    } catch (e) {
      state = ConnectionState(
        status: ConnectionStatus.disconnected,
        error: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _testTimer?.cancel();
    super.dispose();
  }
}

/// Provider for network connectivity state
final connectionProvider =
    StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
  return ConnectionNotifier(Connectivity());
});

final isConnectedProvider = Provider<bool>((ref) {
  return ref.watch(connectionProvider).status == ConnectionStatus.connected;
});
