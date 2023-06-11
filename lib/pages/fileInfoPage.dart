import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/model/storedItem.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';

import '../painters/curvePainter.dart';

class FileInfoPage extends StatelessWidget {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  FileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    /* final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    StoredItem file = arguments['file']; */
    var size = MediaQuery.of(context).size;
    var storageProvider = Provider.of<StorageProvider>(context);
    nameController.text = storageProvider.showInfoFile!.name;
    descController.text = storageProvider.showInfoFile!.desc;

    return Scaffold(
      /* floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: [
          deleteFloat(context, storageProvider.showInfoFile!),
          downloadFloat(context, storageProvider.showInfoFile!)
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.blue,
        animatedIconData: AnimatedIcons.menu_close,
      ), */
      backgroundColor: const Color.fromARGB(255, 57, 60, 76),
      body: SingleChildScrollView(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.25,
              child: CustomPaint(
                painter: CurvePainter(true),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              right: size.width * 0.05,
              left: size.width * 0.05,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        constraints:
                            BoxConstraints(maxHeight: size.height * 0.5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 57, 60, 76),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade900,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2))
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: storageProvider.showInfoFile!.type
                                    .contains('image')
                                ? FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/loading.webp'),
                                      image: NetworkImage(
                                        (storageProvider.showInfoFile!.imgUrl),
                                      ),
                                      fit: BoxFit.contain,
                                    )
                                  
                                : Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: size.width * 0.6,
                                      height: size.height * 0.3,
                                      child: Icon(
                                          storageProvider.getIconByType(storageProvider.showInfoFile!.type),
                                          size: 200,
                                          color: Color.fromARGB(
                                              255, 20, 146, 230)),
                                    )))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onSubmitted: (value) {
                            storageProvider.updateFile(
                                'name', storageProvider.showInfoFile!, value);
                          },
                          onChanged: (value) =>
                              storageProvider.showInfoFile!.name = value,
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          
                          onSubmitted: (value) {
                            storageProvider.updateFile(
                                'desc', storageProvider.showInfoFile!, value);
                          },
                          onChanged: (value) =>
                              storageProvider.showInfoFile!.desc = value,
                          controller: descController,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tamaño: ${(storageProvider.showInfoFile!.size / 1024 / 1024).toStringAsFixed(2)}MB',
                              style: TextStyle(fontSize: 15),
                            ),
                            //Text('${storageProvider.storedItems[storageProvider.selectedFile].metadata.size}kb', style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fecha creación: ${storageProvider.showInfoFile!.createdAt.split(' ')[0]}',
                              style: TextStyle(fontSize: 15),
                            ),
                            //Text(storageProvider.storedItems[storageProvider.selectedFile].metadata.timeCreated.toString(), style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
             Positioned(
              bottom: 40,
              left: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                    heroTag: 'goBack',
                    onPressed: (() {
                    Navigator.pop(context);
                
                  }),
                  child: Icon(Icons.arrow_back,) ,)
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: AnimatedFloatingActionButton(
                    fabButtons: [
                      deleteFloat(context, storageProvider.showInfoFile!),
                      downloadFloat(context, storageProvider.showInfoFile!)
                    ],
                    colorStartAnimation: Colors.blue,
                    colorEndAnimation: Colors.blue,
                    animatedIconData: AnimatedIcons.menu_close,
                  ),
            )
          ],
        ),
      )),
    );
  }

  Widget deleteFloat(BuildContext context, StoredItem file) {
    return FloatingActionButton(
      heroTag: 'delete',
      backgroundColor: Colors.red,
      onPressed: (() async {
        

            showDialog(context: context, builder: ((context) => AlertDialog(
              title: Text('¿Seguro que quieres borrar este archivo?'),
              actions: [
                TextButton(onPressed: (() {
                  Navigator.pop(context);
                }), child: Text('No')),
                TextButton(onPressed: (() async{
                  var storageProvder =
                Provider.of<StorageProvider>(context, listen: false);
            await storageProvder.deleteFile(file.id!);
            Navigator.pop(context);
            Navigator.pop(context);
                }), child: Text('Si'))
              ],
            )));
      }),
      child: const Icon(Icons.delete),
    );
  }

  Widget downloadFloat(BuildContext context, StoredItem file) {
    return FloatingActionButton(
      heroTag: 'download',
      backgroundColor: Colors.blue,
      onPressed: (() async {
     

        if (!kIsWeb) {
          var storageProvider =
              Provider.of<StorageProvider>(context, listen: false);
          await storageProvider.downloadFile();
        } else {
          var storageProvider =
              Provider.of<StorageProvider>(context, listen: false);
          await storageProvider.downloadFileWeb(file);
        }

        
      }),
      child: const Icon(Icons.download),
    );
  }
}
