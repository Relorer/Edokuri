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
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ReaderPageWidget(content: pages[index]),
        );
      },
    );
  }
}
