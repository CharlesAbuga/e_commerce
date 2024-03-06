// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/product_class.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedImage = 0;
  int selectedSize = 0;
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
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                        fit: BoxFit.cover,
                        width: 300,
                        height: 266,
                        widget.product.imageUrl[selectedImage]),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(widget.product.imageUrl.length,
                        (index) => smallPreview(index)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Text(
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  widget.product.title)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  ' Ksh ${widget.product.price}'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              'Sizes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  widget.product.sizes.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSize = index;
                                        });
                                      },
                                      child: Chip(
                                        side: BorderSide(
                                          color: selectedSize == index
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                        label:
                                            Text(widget.product.sizes[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 24.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star),
                                      Text('12.0'),
                                      Text('(120)')
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14),
                          child: Row(
                            children: [
                              Text(
                                'Status :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'In Stock',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              width: MediaQuery.of(context).size.width / 1.1,
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  GestureDetector smallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(0),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  selectedImage == index ? Colors.black : Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(widget.product.imageUrl[index], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
