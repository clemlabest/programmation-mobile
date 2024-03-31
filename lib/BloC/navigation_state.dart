abstract class NavigationState {}

class NavigationInitialState extends NavigationState {}

class NavigationSelectedState extends NavigationState {
  final int selectedIndex;

  NavigationSelectedState(this.selectedIndex);
}
