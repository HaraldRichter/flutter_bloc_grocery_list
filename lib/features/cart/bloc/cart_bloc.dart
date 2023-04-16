import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../data/cart_items.dart';
import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<EventCartInitial>(eventCartInitial);
    on<EventRemoveFromCart>(eventRemoveFromCart);
  }

  FutureOr<void> eventCartInitial(
      EventCartInitial event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> eventRemoveFromCart(
      EventRemoveFromCart event, Emitter<CartState> emit) {
    // 1. get cartItems
    // 2. check if product model is in cartItems (will always be true)
    // 3. run a function to remove the product
    // 4. emit new BuildState
  }
}
