import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_application/BloC/navigation_event.dart';
import 'package:comics_application/BloC/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitialState()) {
    on<NavigationTappedEvent>((event, emit) {
      emit(NavigationSelectedState(event.selectedIndex));
    });
  }
}
