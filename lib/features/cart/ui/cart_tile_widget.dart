import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';

import '../bloc/cart_bloc.dart';

class CartTile extends StatelessWidget {
  const CartTile(
      {Key? key, required this.productDataModel, required this.cartBloc})
      : super(key: key);
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productDataModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '\$${productDataModel.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(productDataModel.description)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  // homeBloc.add(EventHomeProductWishlistButtonClicked(
                  //     clickedProduct: productDataModel));
                },
                icon: const Icon(Icons.favorite_outline),
              ),
              IconButton(
                onPressed: () {
                  // homeBloc.add(EventHomeProductCartButtonClicked(
                  //     clickedProduct: productDataModel));
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
