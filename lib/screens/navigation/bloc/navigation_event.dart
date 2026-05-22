enum AppTab { home, search, favorites }

abstract class NavigationEvent {
  const NavigationEvent();
}

class SelectTabEvent extends NavigationEvent {
  final AppTab tab;
  const SelectTabEvent(this.tab);
}
