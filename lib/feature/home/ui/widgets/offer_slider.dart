import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stepify/feature/home/models/offer_model.dart';

class OfferSlider extends StatefulWidget {
  final List<OfferModel> offers;

  const OfferSlider({super.key, required this.offers});

  @override
  State<OfferSlider> createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: CarouselSlider(
              items: widget.offers
                  .map(
                    (e) => SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(e.imageUrl,
                            fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                aspectRatio: 2.5,
                viewportFraction: 1,
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: DotsIndicator(
                    position: double.parse(currentIndex.toString()),
                    dotsCount: widget.offers.length,
                    decorator:  DotsDecorator(
                        size: Size.square(7.0),
                        activeSize: Size(8.0, 8.0),
                        color: Colors.grey,
                        activeColor:Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
