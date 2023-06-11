import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:proyecto_integrado_3/model/storedItem.dart';
import 'package:proyecto_integrado_3/services/fireStoreService.dart';
import 'package:proyecto_integrado_3/services/storageService.dart';
import 'package:uuid/uuid.dart';
import 'package:universal_html/html.dart' as html;

class StorageProvider extends ChangeNotifier{

  ListResult? files;
  List<StoredItem> storedItems = [];
  List<StoredItem> storedImages = [];
  bool isLoading = false;
  int selectedFile = -1;
  StoredItem? showInfoFile;
  PlatformFile? imageToUpload;
  String fileToUploadName = '';

  Map<String,IconData> formats = {
    'image/jpeg': Icons.image,
    'image/jpg': Icons.image,
    'video/mp4': Icons.video_file
  };

  List<String> imageFormats = ['png','jpeg','jpg','webp'];
  List<String> audioFormats = ['mp3','wav'];

  

  set fileName(String newName){
    fileToUploadName = newName;
   
    notifyListeners();
  }

  
  IconData getIconByType(String type){
    if(type.toLowerCase().contains('image')){
      return Icons.image;
    }
    if(type.toLowerCase().contains('video')){
      return Icons.video_file;
    }
    if(type.toLowerCase().contains('audio')){
      return Icons.audio_file;
    }
    return Icons.picture_as_pdf;
  }

  IconData getIconByExtension(String extension){
    if(imageFormats.contains(extension)){
      return Icons.image;
    }
    if(extension == 'mp4'){
      return Icons.video_file;
    }
    if(audioFormats.contains(extension)){
      return Icons.audio_file;
    }
    return Icons.picture_as_pdf;
  }




  Future getFiles() async {

    storedItems = [];

    StorageService ss = StorageService();
    isLoading = true;
    files = await ss.listFiles();

    if(files!.items.isNotEmpty){
      await Future.forEach(files!.items, (ref) async {
      String imgUrl = await ss.getDownloadURL(ref);
      FullMetadata metadata = await ss.getMetadata(ref);
      //storedItems.add(StoredItem(name: ref.name, imgUrl: imgUrl, metadata: metadata));
    });

    }

    isLoading = false;

  }

  Stream<List<StoredItem>> readFiles(){
    var fs = FirestoreService();

    return fs.readFiles();
  }


  Future selectFile()async{

  /* final ImagePicker picker = ImagePicker();

  imageToUpload = await picker.pickImage(source: ImageSource.gallery); */

  final result = await FilePicker.platform.pickFiles();

  if(result == null){
    return;
  }

  imageToUpload = result.files.first;


  
  notifyListeners();

}

Future updateFile(String elementToUpdate, StoredItem file, String newValue) async{

  final fs = FirestoreService();
  await fs.updateFile(elementToUpdate, file, newValue);
}


Future deleteFile(String id) async{
  final fs = FirestoreService();
  final ss = StorageService();

  await ss.deleteFile(id);
  await fs.deleteFile(id);
}


Future<bool> uploadImage(String name, String desc) async{

    StorageService ss = StorageService();
    FirestoreService fs = FirestoreService();

    var uuid = Uuid().v4();
    uuid += '.${imageToUpload!.extension}';

    if(!kIsWeb){
      await ss.uploadImage(File(imageToUpload!.path!),uuid);
    }
    else{
     
      
      await ss.uploadImageWeb(imageToUpload!.bytes!,uuid);

    }
    
    String imgUrl = await ss.getDownloadUrlByUuid(uuid);
    FullMetadata metadata = await ss.getMetadataByUuid(uuid);
    await fs.createFile(uuid, name, desc, imgUrl, metadata.size!, metadata.contentType!, metadata.timeCreated.toString());


    return true;
    
  }

  Future downloadFile() async{
    var ss = StorageService();
    await ss.downloadFile(storedItems[selectedFile]);
  }

  Future downloadFileWeb(StoredItem file) async{
    var ss = StorageService();
    await ss.downloadFileWeb(file.imgUrl);
  } 

void reset(){

  selectedFile = -1;
  imageToUpload = null;
  notifyListeners();


}



}