import 'navigation_event.dart';

class NavigationState {
  final AppTab currentTab;

  const NavigationState({required this.currentTab});

  const NavigationState.initial() : this(currentTab: AppTab.home);

  NavigationState copyWith({AppTab? currentTab}) {
    return NavigationState(currentTab: currentTab ?? this.currentTab);
  }
}
