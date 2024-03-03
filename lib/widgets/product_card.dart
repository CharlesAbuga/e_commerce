import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                    fit: BoxFit.cover,
                    width: 210,
                    height: 160,
                    'assets/images/jeans.jpeg'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  'Jeans',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leadingAndTrailingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  leading: const Text('Ksh.500'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 10),
                          Text('Add to Cart',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
