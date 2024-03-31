abstract class NavigationEvent {}

class NavigationTappedEvent extends NavigationEvent {
  final int selectedIndex;

  NavigationTappedEvent(this.selectedIndex);
}
