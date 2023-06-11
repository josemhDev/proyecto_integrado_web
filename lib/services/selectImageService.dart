/* 

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
class SelectImageService {


  Future<XFile?> getImage()async{

  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(source: ImageSource.gallery);


  return image;
}

} */
