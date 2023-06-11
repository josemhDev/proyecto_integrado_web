import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:universal_html/html.dart' as html;

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_integrado_3/model/storedItem.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final formats = {
    'jpg': 'image',
    'jpeg': 'image',
    'png': 'image',
    'mp4': 'video',
    'mp3': 'audio',
    'pdf': 'application',
    'wav': 'audio'
  };

  Future<bool> uploadImage(File file, String namefile) async {
    Reference ref =
        storage.ref().child(user.uid).child('images').child(namefile);

    final UploadTask uploadTask = ref.putFile(file);

    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

    if (snapshot.state == TaskState.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadImageWeb(Uint8List image, String namefile) async {
    Reference ref =
        storage.ref().child(user.uid).child('images').child(namefile);

    final UploadTask uploadTask = ref.putData(
        image,
        SettableMetadata(
            contentType:
                '${formats[namefile.split('.').last]}/${namefile.split('.').last}'));

    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

    if (snapshot.state == TaskState.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<ListResult> listFiles() async =>
      await storage.ref().child(user.uid).child('images').listAll();

  Future<String> getDownloadURL(Reference reference) async =>
      await reference.getDownloadURL();

  Future<String> getDownloadUrlByUuid(String uuid) async {
    Reference ref = storage.ref().child(user.uid).child('images').child(uuid);
    return await ref.getDownloadURL();
  }

  Future<FullMetadata> getMetadata(Reference reference) async =>
      await reference.getMetadata();

  Future<FullMetadata> getMetadataByUuid(String uuid) async {
    Reference ref = storage.ref().child(user.uid).child('images').child(uuid);
    return await ref.getMetadata();
  }

  Future downloadFileWeb(String url) async {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = 'sereto';
    //anchorElement.setAttribute('download', '$url.jpg');
    anchorElement.target = "_blank";
    anchorElement.click();
  }

  Future deleteFile(String id) async {
    Reference ref = storage.ref().child(user.uid).child('images').child(id);

    await ref.delete();
  }

  Future downloadFile(StoredItem fileToDownload) async {
    String path = '';
    String fileName = fileToDownload.name;

    if (Platform.isAndroid) {

      final savedDir = Directory('/sdcard/download');

      bool hasExisted = await savedDir.exists();

      if (!hasExisted) {
     
        savedDir.create();
      }
      path += 'sdcard/download';
    }
    if (Platform.isIOS) {
      var directory = await getApplicationDocumentsDirectory();
      path += directory.path + Platform.pathSeparator + 'Download';
    
    }

    /*  if (fileToDownload.type.contains('image')) {
      fileName += '.jpg';
    }
    if (fileToDownload.type.contains('video')) {
      fileName += '.mp4';
    }
    if (fileToDownload.type.toLowerCase().contains('pdf')) {
      fileName += '.pdf';
    }
    if (fileToDownload.type.toLowerCase().contains('wav')) {
      fileName += '.WAV';
    } */

    fileName += '.${fileToDownload.id!.split('.').last}';

    if (!kIsWeb) {


      await Dio().download(fileToDownload.imgUrl, '$path/${fileName.replaceAll(' ', '_')}');
    } else {
      final rs = await Dio().get<List<int>>(
        fileToDownload.imgUrl,
        options: Options(
            responseType:
                ResponseType.bytes), // Set the response type to `bytes`.
      );
     //
    }

    /* if(fileToDownload.type.contains('image')){
      await GallerySaver.saveImage(path);
      }
    if(fileToDownload.type.contains('video')){
      await GallerySaver.saveVideo(path);
      } */

  

    //await Dio().download(fileToDownload.imgUrl, path);

    /* if(fileToDownload.type.contains('video')){
      await GallerySaver.saveVideo(path, toDcim: true);
    }else if(fileToDownload.type.contains('image')){
      await GallerySaver.saveImage(path, toDcim: true);
    } */
  }
}
