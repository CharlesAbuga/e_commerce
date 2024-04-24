// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/color_conv.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/product_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final String productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedImage = 0;
  int selectedSize = 0;
  int selectedColor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 800
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: const AppBarSmall())
          : PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 60),
              child: const Center(child: AppBarMain())),
      drawer: MediaQuery.of(context).size.width < 800 ? const Drawer() : null,
      body: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetProductFailure) {
            return const Center(
              child: Text('Failed to fetch products'),
            );
          } else if (state is GetProductSuccess) {
            Product product = state.products
                .firstWhere((element) => element.productId == widget.productId);
            List<Color> productColor =
                product.color.map((e) => getColorFromString(e)).toList();
            return SingleChildScrollView(
                child: MediaQuery.of(context).size.width < 800
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 266,
                                    product.imageUrl[selectedImage]),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(product.imageUrl.length,
                                    (index) => smallPreview(index, product)),
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
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              product.name),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.share),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              ' Ksh ${product.price}'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 14.0, right: 14),
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
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Text(
                                                'Sizes',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                ...List.generate(
                                                  product.size.length,
                                                  (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedSize = index;
                                                        });
                                                      },
                                                      child: Chip(
                                                        backgroundColor:
                                                            selectedSize ==
                                                                    index
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        side: const BorderSide(
                                                          width: 0,
                                                          color: Colors.black,
                                                        ),
                                                        label: Text(
                                                            style: TextStyle(
                                                              color:
                                                                  selectedSize ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                            ),
                                                            product
                                                                .size[index]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Colors',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  ...List.generate(
                                                    product.color.length,
                                                    (index) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedColor =
                                                                index;
                                                          });
                                                        },
                                                        child: Container(
                                                          width:
                                                              selectedColor ==
                                                                      index
                                                                  ? 25
                                                                  : 30,
                                                          height:
                                                              selectedColor ==
                                                                      index
                                                                  ? 25
                                                                  : 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(
                                                                      selectedColor ==
                                                                              index
                                                                          ? 12.5
                                                                          : 15),
                                                                  color: selectedColor ==
                                                                          index
                                                                      ? productColor[
                                                                          index]
                                                                      : Colors
                                                                          .white,
                                                                  border: Border
                                                                      .all(
                                                                    width: 2,
                                                                    color: productColor[
                                                                        index],
                                                                  )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white),
                                                  const SizedBox(width: 10),
                                                  Text('Add to Cart',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary)),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 24.0),
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
                                    const SizedBox(height: 10),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          height: 300,
                                          child: Container(
                                            margin: const EdgeInsets.all(20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Description',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(product.description)
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
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 2.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              width: 760,
                                              height: 473,
                                              product.imageUrl[selectedImage]),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ...List.generate(
                                                product.imageUrl.length,
                                                (index) => smallPreview(
                                                    index, product)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                  product.name),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.share),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  ' Ksh ${product.price}'),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 14.0, right: 14),
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
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Text(
                                                    'Sizes',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    ...List.generate(
                                                      product.size.length,
                                                      (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedSize =
                                                                  index;
                                                            });
                                                          },
                                                          child: Chip(
                                                            backgroundColor:
                                                                selectedSize ==
                                                                        index
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .transparent,
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            side:
                                                                const BorderSide(
                                                              width: 0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            label: Text(
                                                                style:
                                                                    TextStyle(
                                                                  color: selectedSize ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                product.size[
                                                                    index]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Colors',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      ...List.generate(
                                                        product.color.length,
                                                        (index) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedColor =
                                                                    index;
                                                              });
                                                            },
                                                            child: Container(
                                                              width:
                                                                  selectedColor ==
                                                                          index
                                                                      ? 25
                                                                      : 30,
                                                              height:
                                                                  selectedColor ==
                                                                          index
                                                                      ? 25
                                                                      : 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(selectedColor ==
                                                                              index
                                                                          ? 12.5
                                                                          : 15),
                                                                      color: productColor[
                                                                          index],
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            2,
                                                                        color: productColor[
                                                                            index],
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.white),
                                                      const SizedBox(width: 10),
                                                      Text('Add to Cart',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary)),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 24.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.star),
                                                      Text('12.0'),
                                                      Text('(120)')
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.05,
                                          child: Container(
                                            margin: const EdgeInsets.all(20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Description',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    product.description,
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GestureDetector smallPreview(int index, Product product) {
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
          child: Image.network(product.imageUrl[index], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
