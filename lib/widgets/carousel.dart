import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderHome extends StatelessWidget {
  const CarouselSliderHome({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width / 1.4,
          height: size.height / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              CarouselSlider(
                carouselController: buttonCarouselController,
                items: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                        width: size.width / 1.4,
                        'assets/images/pexels-melvin-buezo-2529148.jpg',
                        fit: BoxFit.fitWidth),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                        width: size.width / 1.4,
                        'assets/images/still-life-spring-wardrobe-switch.jpg',
                        fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                        width: size.width / 1.4,
                        'assets/images/jeans.jpeg',
                        fit: BoxFit.cover),
                  ),
                ],
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 0.8,
                    aspectRatio: 16 / 9,
                    height: size.height / 2,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    enlargeCenterPage: true),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      buttonCarouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    },
                    icon: const Icon(Icons.arrow_left),
                  ),
                  IconButton(
                    onPressed: () {
                      buttonCarouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    },
                    icon: const Icon(Icons.arrow_right),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
