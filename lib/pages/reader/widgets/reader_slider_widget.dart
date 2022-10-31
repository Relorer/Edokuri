import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'reader_page_widget.dart';

class ReaderSliderWidget extends StatelessWidget {
  final CarouselController? carouselController;
  final List<String> pages;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const ReaderSliderWidget(
      {Key? key,
      required this.pages,
      this.onPageChanged,
      this.carouselController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselController,
      options: CarouselOptions(
          height: double.infinity,
          enableInfiniteScroll: false,
          autoPlay: false,
          onPageChanged: onPageChanged,
          viewportFraction: 1),
      itemCount: pages.length,
      itemBuilder: (_, index, __) => ReaderPageWidget(
        content: pages[index],
      ),
    );
  }
}
