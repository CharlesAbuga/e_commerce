import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/product_class.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/carousel.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.products});

  final List<Product> products;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 800
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: AppBarSmall())
          : PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 60),
              child: const Center(child: AppBarMain())),
      drawer: MediaQuery.of(context).size.width < 800 ? const Drawer() : null,
      body: ListView(
        shrinkWrap: true,
        children: [
          MediaQuery.of(context).size.width < 800
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton.filled(
                            onPressed: () {},
                            tooltip: 'For men',
                            icon: const Icon(Icons.man),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Men\'s clothes',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(Icons.woman),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Women\'s Clothes',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(Icons.child_care),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Children\'s clothes',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CarouselSliderHome()],
          ),
          MediaQuery.of(context).size.width > 900
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 40,
                              mainAxisExtent: 320,
                              crossAxisCount: 5),
                      itemCount: widget.products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductCard(product: widget.products[index]);
                      }),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisExtent: 320,
                              crossAxisCount: 2),
                      itemCount: widget.products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductCard(product: widget.products[index]);
                      }),
                ),
        ],
      ),
    );
  }
}
