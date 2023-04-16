part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class EventHomeInitial extends HomeEvent {}

class EventHomeProductWishlistButtonClicked extends HomeEvent {
  EventHomeProductWishlistButtonClicked({required this.clickedProduct});
  final ProductDataModel clickedProduct;
}

class EventHomeProductCartButtonClicked extends HomeEvent {
  EventHomeProductCartButtonClicked({required this.clickedProduct});
  final ProductDataModel clickedProduct;
}

class EventHomeWishlistButtonNavigate extends HomeEvent {}

class EventHomeCartButtonNavigate extends HomeEvent {}
