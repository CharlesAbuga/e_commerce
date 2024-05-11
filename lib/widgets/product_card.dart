import 'dart:developer';

import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ValueNotifier<bool> _isHovering = ValueNotifier<bool>(false);
  bool isProductSaved = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final myUserBloc = context.read<MyUserBloc>();
    if (myUserBloc.state.user != null) {
      MyUser myUser = myUserBloc.state.user!;
      if (myUser.savedProducts != null) {
        isProductSaved = myUser.savedProducts!
            .any((product) => product['productId'] == widget.product.productId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        return BlocListener<MyUserBloc, MyUserState>(
          listener: (context, state) {
            if (state.user != null) {
              MyUser myUser = state.user!;
              if (myUser.savedProducts != null) {
                setState(() {
                  isProductSaved = myUser.savedProducts!.any((product) =>
                      product['productId'] == widget.product.productId);
                });
              }
            }
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MyUserBloc(
                  myUserRepository: FirebaseUserRepository(),
                )..add(GetMyUser(
                    myUserId:
                        context.read<AuthenticationBloc>().state.user!.uid)),
              ),
            ],
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return BlocBuilder<GetProductBloc, GetProductState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: 220,
                        height: null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).goNamed(
                                        RouteConstants.details,
                                        pathParameters: {
                                          'productId': widget.product.productId
                                        },
                                        extra: widget.product);
                                  },
                                  child: MouseRegion(
                                    onEnter: (_) => _isHovering.value = true,
                                    onExit: (_) => _isHovering.value = false,
                                    child: ValueListenableBuilder(
                                        valueListenable: _isHovering,
                                        builder:
                                            (context, bool isHovering, child) {
                                          return AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeIn,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: isHovering
                                                  ? [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        spreadRadius: 3,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ]
                                                  : [],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                  widget.product.imageUrl[0],
                                                  fit: BoxFit.cover,
                                                  width: 220,
                                                  height: 170, errorBuilder:
                                                      (BuildContext context,
                                                          Object exception,
                                                          StackTrace?
                                                              stackTrace) {
                                                return const Center(
                                                  child: Text(
                                                      'Could not load image'),
                                                );
                                              }),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        widget.product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leadingAndTrailingTextStyle:
                                        const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    leading: Text(
                                        'Ksh ${widget.product.price.toString()}'),
                                    trailing: BlocBuilder<UpdateUserInfoBloc,
                                        UpdateUserInfoState>(
                                      builder: (context, state) {
                                        return BlocBuilder<MyUserBloc,
                                            MyUserState>(
                                          builder: (context, state) {
                                            return Container(
                                              alignment: Alignment.centerRight,
                                              width: 50,
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    try {
                                                      final myUserBloc = context
                                                          .read<MyUserBloc>();
                                                      if (myUserBloc
                                                              .state.user !=
                                                          null) {
                                                        MyUser myUser =
                                                            myUserBloc
                                                                .state.user!;
                                                        if (myUser
                                                                .savedProducts ==
                                                            null) {
                                                          myUser = myUser.copyWith(
                                                              savedProducts: []);
                                                        }
                                                        var productToAdd =
                                                            Product(
                                                          createdAt:
                                                              DateTime.now(),
                                                          productId: widget
                                                              .product
                                                              .productId,
                                                          name: widget
                                                              .product.name,
                                                          description: widget
                                                              .product.ageGroup,
                                                          price: widget
                                                              .product.price,
                                                          category: widget
                                                              .product.category,
                                                          size: widget
                                                              .product.size,
                                                          color: widget
                                                              .product.color,
                                                          stock: widget
                                                              .product.stock,
                                                          ageGroup: widget
                                                              .product.ageGroup,
                                                          gender: widget
                                                              .product.gender,
                                                          imageUrl: widget
                                                              .product.imageUrl,
                                                        );
                                                        if (!myUser
                                                            .savedProducts!
                                                            .any((product) =>
                                                                product[
                                                                    'productId'] ==
                                                                widget.product
                                                                    .productId)) {
                                                          // If the product is not in the list, append it to the list
                                                          context
                                                              .read<
                                                                  UpdateUserInfoBloc>()
                                                              .add(AddSavedProducts(
                                                                  myUser,
                                                                  productToAdd
                                                                      .toEntity()
                                                                      .toDocument()));

                                                          // Add the product to the local list
                                                          myUser.savedProducts!
                                                              .add(productToAdd
                                                                  .toEntity()
                                                                  .toDocument());

                                                          setState(() {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                    'Product added to saved products'),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1000),
                                                              ),
                                                            );
                                                            isProductSaved =
                                                                true; // Update the local state variable
                                                          });
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              backgroundColor:
                                                                  Colors.orange,
                                                              content: Text(
                                                                  'Product already saved to Products saved products'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                            ),
                                                          );
                                                          // If the product is in the list, remove it
                                                        }
                                                      }
                                                    } catch (e) {
                                                      log(e.toString());
                                                    }
                                                  },
                                                  icon:
                                                      isProductSaved // Use the local state variable to determine which icon to show
                                                          ? const Icon(Icons
                                                              .favorite) // filled icon when product is in savedProducts
                                                          : const Icon(Icons
                                                              .favorite_border),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
