sealed class HomeEvent {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeRetried extends HomeEvent {
  const HomeRetried();
}
