import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart.dart';
import 'package:flutter_bloc_project/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_project/features/wishlist/ui/wishlist.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    homeBloc.add(EventHomeInitial());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('Product added to Cart'),
            ),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('Product added to Wishlist'),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            // Indem wir den HomeLoadedSuccsessState als Variable einführen,
            // bekommen wir Zugriff auf die Parameter der HomeLoadedSuccessState-Klasse,
            // wie beispielsweise das ProductDataModel bzw. die Liste products,
            // die wir brauchen, um die Produkte in der UI darstellen zu können.
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Grocery'),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(EventHomeWishlistButtonNavigate());
                    },
                    icon: const Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(EventHomeCartButtonNavigate());
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                    // Hier greifen wir auf die oben geschaffene Variable zu, um die
                    // products-Liste abzufragen und alle Produkte zu listen.
                  }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('ERROR!'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
