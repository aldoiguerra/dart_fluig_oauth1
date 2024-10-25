library user;

/// A class describing OAuth client credentials.
class User {
  final String _user;
  final String _password;

  User(this._user, this._password);

  String get user => _user;
  String get password => _password;
}
