import 'dart:developer';

import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repository/product_repository.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        return SizedBox(
          width: null,
          height: null,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(RouteConstants.details,
                            pathParameters: {'productId': product.productId},
                            extra: product);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(product.imageUrl[0],
                            fit: BoxFit.cover,
                            width: 180,
                            height: 160, errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return const Center(
                            child: Text('Could not load image'),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 7.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leadingAndTrailingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        leading: Text('Ksh ${product.price.toString()}'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart,
                                    color: Colors.white),
                                const SizedBox(width: 10),
                                Text('Add to Cart',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
