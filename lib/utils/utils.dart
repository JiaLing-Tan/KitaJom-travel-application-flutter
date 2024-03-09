import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: (source));

  if (_file != null) {

    return _file.readAsBytes();
  }
  print('No image selected.');
}


showSnackBar(String message, context) {
  final snackbar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

selectImages(ImageSource source) async {
  List _imageList = [];
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: (source));

  if (_file != null) {
    _imageList.add(_file.readAsBytes());
    return _imageList;
  }
  print('No image selected.');

}
