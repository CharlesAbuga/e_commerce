import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 800
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 70),
              child: const AppBarSmall())
          : PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 70),
              child: const Center(child: AppBarMain())),
      drawer:
          MediaQuery.of(context).size.width < 800 ? const DrawerWidget() : null,
      body: BlocProvider(
        create: (context) => MyUserBloc(
            myUserRepository: FirebaseUserRepository())
          ..add(GetMyUser(
              myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
        child: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(context.read<AuthenticationBloc>().state.user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final cartProducts = (snapshot.data!.data()
                          as Map<String, dynamic>)['cartProducts']
                      as List<dynamic>?;
                  var myUser = MyUser.fromEntity(MyUserEntity.fromDocument(
                      snapshot.data!.data() as Map<String, dynamic>));
                  double totalPrice = 0;
                  if (cartProducts != null) {
                    for (var product in cartProducts) {
                      totalPrice += (product['price'] as double) *
                          (product['quantity'] as int);
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'ORDER SUMMARY',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Items: ${cartProducts!.length}'),
                            Text(
                                'Items Total: Ksh ${totalPrice.toStringAsFixed(2)}'),
                            const Text('Delivery Fee: Ksh 200'),
                            const Divider(),
                            const Text('Total'),
                          ],
                        ),
                      ),
                      // Shipping details
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          'Shipping Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Shipping details content
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${myUser.name}'),
                            Text('Phone Number: ${myUser.addressLine1}'),
                            Text('City: ${myUser.city}'),
                          ],
                        ),
                      ),
                      // Product list
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Product list content
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: scrollController,
                          interactive: true,
                          child: ListView.builder(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartProducts.length,
                            itemBuilder: (context, index) {
                              final product = cartProducts[index];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product['imageUrl'][0],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(product['name']),
                                subtitle: Text(
                                    'Price: Ksh ${product['price'].toStringAsFixed(2)}'),
                              );
                            },
                          ),
                        ),
                      ),

                      // Checkout button
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            final myUser =
                                context.read<MyUserBloc>().state.user;

                            // Create a new order document in the 'orders' subcollection
                            final orderRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(myUser!.id)
                                .collection('orders')
                                .doc(); // This creates a new document with a unique ID

                            // Prepare the order data
                            final orderData = {
                              'products': cartProducts
                                  .map((product) => {
                                        'productId': product['productId'],
                                        'quantity': product['quantity'],
                                        'price': product['price'],
                                      })
                                  .toList(),
                              'totalPrice': totalPrice,
                              'date': Timestamp.now(),
                              // Add any other order details here
                            };

                            // This merges the new data with the existing document

                            try {
                              await orderRef.set(orderData);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                ),
                              );
                              return;
                            }

                            try {
                              for (var cartProduct in cartProducts) {
                                // Run a transaction on the product document
                                await FirebaseFirestore.instance
                                    .runTransaction((transaction) async {
                                  // Fetch the product document
                                  final productDoc = await transaction.get(
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(cartProduct['productId']),
                                  );

                                  // Check if the document exists before updating
                                  if (productDoc.exists) {
                                    // Subtract the quantity of the product in the cart from the product's stock
                                    final newStock =
                                        productDoc.data()!['stock'] -
                                            cartProduct['quantity'];

                                    // Update the product document with the new stock
                                    transaction.update(productDoc.reference,
                                        {'stock': newStock});
                                  } else {}
                                });
                              }
                            } catch (e) {
                              log(e.toString());
                            }

                            // For each product in the cart

                            // Save the order

                            // Update the user document to clear the cart
                            final userRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(myUser.id);
                            await userRef.update({'cartProducts': []});

                            // Optionally, notify the user that the order was successful
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Order placed successfully!')),
                            );
                            // Get current orders and cart products

                            // Place order
                            // Clear cart
                            /*context.read<MyUserBloc>().add(
                                    MyUserUpdateCartProductsEvent(
                                        cartProducts: []));*/
                          },
                          child: const Text('COMPLETE ORDER',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
