import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Men extends StatelessWidget {
  const Men({super.key});

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
        drawer: MediaQuery.of(context).size.width < 800
            ? const DrawerWidget()
            : null,
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
              final products = state.products
                  .where((product) => product.gender == "Male")
                  .toList();
              return SingleChildScrollView(
                child: MediaQuery.of(context).size.width < 800
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
                                crossAxisCount: 4),
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
        ));
  }
}
