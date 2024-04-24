import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class AppBarMain extends StatefulWidget {
  const AppBarMain({super.key});

  @override
  State<AppBarMain> createState() => _AppBarMainState();
}

class _AppBarMainState extends State<AppBarMain> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: SizedBox(
            width: 300,
            height: 40,
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
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: badges.Badge(
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
                GoRouter.of(context).goNamed(RouteConstants.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ),
      ],
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 1.0,
      centerTitle: true,
      title: Center(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 15,
            ),
            InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHover: (value) {
                  setState(() {});
                },
                onTap: () {
                  GoRouter.of(context).goNamed(RouteConstants.home);
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            PopupMenuButton(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Container(
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: SvgPicture.asset(
                            'assets/images/shoe-1-svgrepo-com.svg',
                            height: 24,
                            width: 24),
                        title: const Text('Shoes')),
                  ),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.mensShoes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/reshot-icon-jeans-XLD58F3HEU.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Clothes')),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.mensClothes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/belt-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Accessories')),
                  onTap: () {
                    GoRouter.of(context)
                        .goNamed(RouteConstants.mensAccessories);
                  },
                ),
              ],
              child: const Text(
                'Men',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            PopupMenuButton(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/baby-shoes-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Shoes')),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.babyShoes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/baby-boy-clothes-with-anchor-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Clothes')),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.babyClothes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/play-time-baby-toy-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Accessories')),
                  onTap: () {
                    GoRouter.of(context)
                        .goNamed(RouteConstants.babyAccessories);
                  },
                ),
              ],
              child: const Text(
                'Kids',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            PopupMenuButton(
              splashRadius: 0,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/shoe-with-high-heel-shoe-heel-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Shoes')),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.womensShoes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/dress-4-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Clothes')),
                  onTap: () {
                    GoRouter.of(context).goNamed(RouteConstants.womensClothes);
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: SvgPicture.asset(
                          'assets/images/necklace-svgrepo-com.svg',
                          height: 24,
                          width: 24),
                      title: const Text('Accessories')),
                  onTap: () {
                    GoRouter.of(context)
                        .goNamed(RouteConstants.womensAccessories);
                  },
                ),
              ],
              child: const Text(
                'Women',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
