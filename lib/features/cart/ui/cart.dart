import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(EventCartInitial());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        // Ein BlocConsumer kombiniert BlocBuilder und BlocListener. Wenn man nur
        // build oder nur listen benötigt, kann man einen der letzteren verwenden,
        // will man aber beide Funktionen haben, benötigt man den Consumer.
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          // TODO: implement
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Scaffold(
                body: ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartTile(
                          cartBloc: cartBloc,
                          productDataModel: successState.cartItems[index]);
                      // Hier greifen wir auf die oben geschaffene Variable zu, um die
                      // products-Liste abzufragen und alle Produkte zu listen.
                    }),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
