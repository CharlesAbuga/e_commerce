// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/product_class.dart';

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
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                      fit: BoxFit.cover,
                      width: 400,
                      height: 356,
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
              )
            ],
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
                  selectedImage == index ? Colors.orange : Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(fit: BoxFit.cover, widget.product.imageUrl[index]),
        ),
      ),
    );
  }
}
