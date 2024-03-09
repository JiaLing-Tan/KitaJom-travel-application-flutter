import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:provider/provider.dart';

class ImageReview extends StatefulWidget {
  const ImageReview({super.key});

  @override
  State<ImageReview> createState() => _ImageReviewState();
}

class _ImageReviewState extends State<ImageReview> {
  final ImagePicker imagePicker = ImagePicker();
  List<Uint8List>? imageFileList = [];
  int maxImageCount = 5; // Set the maximum image limit

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      // Ensure only up to 5 images are added
      for (int i = 0;
      i < selectedImages.length && imageFileList!.length < maxImageCount;
      i++) {
        imageFileList!.add(await selectedImages[i].readAsBytes());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            imageFileList!.length == maxImageCount
                ? "Maximum of 5 images reached"
                : "Images added successfully",
          ),
        ),
      );
    }
    if (imageFileList!.isNotEmpty) {
      Provider.of<ReviewProvider>(context, listen: false)
          .setImage(imageFileList!);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Column(
        children: [
          imageFileList!.isEmpty
              ? Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 3),
                children: [
                  GestureDetector(
                      onTap: selectImages,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border:
                            Border.all(width: 1, color: Colors.grey)),
                        child: Icon(Icons.add),
                      ))
                ],
              ),
            ),
          )
              : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return index < imageFileList!.length? Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border:
                          Border.all(width: 1, color: Colors.white30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                              imageFileList![index],
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(onTap:(){
                            setState(() {
                              imageFileList!.remove(imageFileList![index]);
                            });

                          },
                            child: Container(
                              color: Colors.grey.withOpacity(0.2),
                              child: Icon(
                                Icons.remove,
                                size: 15,
                              ),
                              width: 15,
                              height: 15,
                            ),
                          ))
                    ]): index == imageFileList!.length? GestureDetector(
                        onTap: selectImages,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border:
                              Border.all(width: 1, color: Colors.grey)),
                          child: Icon(Icons.add),
                        )):Container();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
