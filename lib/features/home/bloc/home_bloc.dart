import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc_project/data/grocery_data.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';

import '../../../data/cart_items.dart';
import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<EventHomeInitial>(eventHomeInitial);
    on<EventHomeWishlistButtonNavigate>(eventHomeWishlistButtonNavigate);
    on<EventHomeCartButtonNavigate>(eventHomeCartButtonNavigate);
    on<EventHomeProductCartButtonClicked>(eventHomeProductCartButtonClicked);
    on<EventHomeProductWishlistButtonClicked>(
        eventHomeProductWishlistButtonClicked);
  }

  FutureOr<void> eventHomeInitial(
      EventHomeInitial event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    try {
      emit(HomeLoadedSuccessState(
          products: GroceryData.groceryProducts
              .map((element) => ProductDataModel(
                  id: element['id'],
                  name: element['name'],
                  description: element['description'],
                  price: element['price'],
                  imageUrl: element['imageUrl']))
              .toList()));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  FutureOr<void> eventHomeWishlistButtonNavigate(
      EventHomeWishlistButtonNavigate event, Emitter<HomeState> emit) {
    print('Navigate to Wishlist');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> eventHomeCartButtonNavigate(
      EventHomeCartButtonNavigate event, Emitter<HomeState> emit) {
    print('Navigate to Cart');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> eventHomeProductCartButtonClicked(
      EventHomeProductCartButtonClicked event, Emitter<HomeState> emit) {
    cartItems.add(event.clickedProduct);
    emit(HomeProductAddedToCartActionState());
  }

  FutureOr<void> eventHomeProductWishlistButtonClicked(
      EventHomeProductWishlistButtonClicked event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }
}
