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
      appBar: AppBar(
        title: const Center(
          child: SizedBox(
            width: 200,
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
      ),
      body: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            elevation: 1,
            minWidth: 100,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home_filled),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.sanitizer_outlined),
                  selectedIcon: Icon(Icons.sanitizer),
                  label: Text('Home'),
                ),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedIndex: _selectedIndex),
          Column(
            children: [const Padding(padding: EdgeInsets.all(8.0), child: ProductCard())]),
        ],
      ),
    );
  }
}
