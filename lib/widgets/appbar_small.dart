import 'package:badges/badges.dart' as badges;
import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppBarSmall extends StatelessWidget {
  const AppBarSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        badges.Badge(
          badgeStyle: const badges.BadgeStyle(
              badgeGradient: badges.BadgeGradient.linear(
                  colors: [Colors.orange, Colors.yellow])),
          position: badges.BadgePosition.custom(
            top: -5,
            end: 0.5,
          ),
          badgeAnimation: const badges.BadgeAnimation.fade(),
          badgeContent: const Text('4'),
          child: IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed(RouteConstants.cart);
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 20,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
      title: GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed(RouteConstants.home);
          },
          child: const Text('Home')),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
        child: Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            height: 40,
            width: 300,
            child: Container(
              margin: const EdgeInsets.all(2),
              child: const TextField(
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
      ),
    );
  }
}
