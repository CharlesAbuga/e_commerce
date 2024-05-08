import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MensShoes extends StatelessWidget {
  const MensShoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).size.width < 800
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const AppBarSmall())
            : PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const Center(child: AppBarMain())),
        drawer: MediaQuery.of(context).size.width < 800
            ? const DrawerWidget()
            : null,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) =>
                  MyUserBloc(myUserRepository: FirebaseUserRepository())
                    ..add(GetMyUser(
                        myUserId: context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .uid)),
              child: BlocBuilder<MyUserBloc, MyUserState>(
                builder: (context, state) {
                  return BlocBuilder<GetProductBloc, GetProductState>(
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
                        final products = state.products
                            .where((product) =>
                                product.category == 'Shoes' &&
                                product.ageGroup == "Adults" &&
                                product.gender == 'Male')
                            .toList();
                        return SingleChildScrollView(
                          child: MediaQuery.of(context).size.width < 900
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 320,
                                          crossAxisCount: 2),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return ProductCard(product: product);
                                  },
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          mainAxisExtent: 320,
                                          crossAxisCount: 6),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return ProductCard(product: product);
                                  },
                                ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}
