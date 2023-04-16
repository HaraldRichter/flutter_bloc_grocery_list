part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class EventCartInitial extends CartEvent {}

class EventRemoveFromCart extends CartEvent {}
