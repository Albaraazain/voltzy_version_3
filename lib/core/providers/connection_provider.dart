import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  ),
);

class ConnectionState {
  final bool isConnected;
  final bool isInitialized;

  const ConnectionState({
    this.isConnected = false,
    this.isInitialized = false,
  });

  ConnectionState copyWith({
    bool? isConnected,
    bool? isInitialized,
  }) {
    return ConnectionState(
      isConnected: isConnected ?? this.isConnected,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final SupabaseClient _supabase;

  ConnectionNotifier(this._supabase) : super(const ConnectionState()) {
    _init();
  }

  void _init() {
    _logger.i('ConnectionNotifier: Initializing connection state');
    _supabase.onAuthStateChange.listen((event) {
      _logger.i('ConnectionNotifier: Auth state change detected');
      state = state.copyWith(isInitialized: true);
    });

    _supabase.onConnectionStateChange.listen((event) {
      _logger.i('ConnectionNotifier: Connection state change detected - ${event.isConnected}');
      state = state.copyWith(isConnected: event.isConnected);
    });
  }
}

final connectionProvider = StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
  return ConnectionNotifier(ref.watch(supabaseProvider));
});
