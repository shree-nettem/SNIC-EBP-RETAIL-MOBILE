import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CarouselSliderWidget extends StatelessWidget {
  final HomeXController controller;

  const CarouselSliderWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            VisibilityDetector(
              key: Key('AUTO_PLAY'),
              onVisibilityChanged: (visibilityInfo) {
                controller.autoPlaySlider(visibilityInfo.visibleFraction);
              },
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: controller.autoPlay,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    controller.changed(index);
                  },
                ),
                items: controller.imgList
                    .map(
                      (item) => Container(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_LARGE),
                          ),
                          child:
                              Image.network(item, fit: BoxFit.fill, width: 1000),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0.0,
          bottom: 12.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.imgList.map((url) {
              int index = controller.imgList.indexOf(url);
              return Container(
                width: controller.currentPos == index ? 12.0 : 8.0,
                height: controller.currentPos == index ? 12.0 : 8.0,
                margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
