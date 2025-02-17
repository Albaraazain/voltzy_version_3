import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/user_type.dart';

part 'user_type_provider.g.dart';

@riverpod
class UserTypeNotifier extends _$UserTypeNotifier {
  @override
  String? build() {
    debugPrint('🐛 Initializing user type provider with default: homeowner');
    // Start with no user type selected
    return null;
  }

  void setUserType(String type) {
    debugPrint('🔄 Setting user type to: $type');
    state = type;
  }
}
