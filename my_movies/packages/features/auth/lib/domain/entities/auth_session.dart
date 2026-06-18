class AuthSession {
  const AuthSession({
    required this.sessionId,
    required this.accountId,
    required this.username,
    this.name,
    this.isGuest = false,
  });

  final String sessionId;
  final int accountId;
  final String username;
  final String? name;
  final bool isGuest;
}
