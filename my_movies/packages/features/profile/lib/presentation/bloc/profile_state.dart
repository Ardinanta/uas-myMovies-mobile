enum ProfileStatus {
  initial,
  loading,
  success,
  loggingOut,
  loggedOut,
  failure,
}

class ProfileState {
  const ProfileState({
    required this.status,
    this.username = 'Guest',
    this.isGuest = false,
    this.message,
  });

  const ProfileState.initial() : this(status: ProfileStatus.initial);

  final ProfileStatus status;
  final String username;
  final bool isGuest;
  final String? message;

  ProfileState copyWith({
    ProfileStatus? status,
    String? username,
    bool? isGuest,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      username: username ?? this.username,
      isGuest: isGuest ?? this.isGuest,
      message: message,
    );
  }
}
