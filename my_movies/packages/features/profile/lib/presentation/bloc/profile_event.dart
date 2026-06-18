sealed class ProfileEvent {
  const ProfileEvent();
}

class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

class ProfileLogoutRequested extends ProfileEvent {
  const ProfileLogoutRequested();
}
