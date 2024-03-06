import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/product_class.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/global_variables.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: null,
      height: null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
                    context.goNamed(RouteConstants.details,
                        pathParameters: {'productId': product.productId},
                        extra: product);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                        fit: BoxFit.cover,
                        width: 180,
                        height: 160,
                        product.imageUrl[0]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leadingAndTrailingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    leading: Text(product.price),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Text('Add to Cart',
                                style: TextStyle(
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
  }
}
