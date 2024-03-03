import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/carousel.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 800
          ? AppBar(
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {},
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
                preferredSize:
                    Size(MediaQuery.of(context).size.width / 1.5, 40),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 60),
              child: const Center(child: AppBarMain())),
      drawer: MediaQuery.of(context).size.width < 800 ? const Drawer() : null,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
              const Row(
                children: [
                  Column(children: [
                    Padding(padding: EdgeInsets.all(8.0), child: ProductCard())
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
