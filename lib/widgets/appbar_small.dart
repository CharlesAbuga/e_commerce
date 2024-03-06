import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarSmall extends StatelessWidget {
  const AppBarSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(RouteConstants.cart);
          },
          icon: const Icon(Icons.shopping_cart),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
      title: const Text('Home'),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width / 1.5, 40),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                counterStyle: TextStyle(fontSize: 13),
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintText: 'Search',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
