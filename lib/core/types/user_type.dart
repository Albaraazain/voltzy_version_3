enum UserType {
  homeowner,
  professional,
  admin;

  String get name => toString().split('.').last;
}
