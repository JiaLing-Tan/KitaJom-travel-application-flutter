import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageList;

  const ImageSlider({super.key, required this.imageList});

  FullScreenWidget getImage(String url) {
    return FullScreenWidget(
      disposeLevel: DisposeLevel.High,
      child: Image.network(url, fit: BoxFit.contain,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return child;
          }, loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }


  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    return Container(
      height: 300,
      child: Stack(children: [
        PageView.builder(
          itemCount:imageList.length,
          itemBuilder: (context, index) {
            var url = imageList[index];
            Key tileKey = Key(url);
            return getImage(url);
          },
          controller: _controller,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                effect: ExpandingDotsEffect(
                    spacing: 5,
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor: lightGreen),
                controller: _controller,
                count: imageList.length,
              ),
            ))
      ]),
    );
  }
}
