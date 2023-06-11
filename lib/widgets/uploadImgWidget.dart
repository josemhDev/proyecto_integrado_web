import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';


import '../painters/curvePainter.dart';

class UploadImgWidget extends StatelessWidget {
  

  final nameController = TextEditingController();

  final descController = TextEditingController();

  UploadImgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var storageProvider = Provider.of<StorageProvider>(context);
   

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 60, 76),
        body: SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: CustomPaint(
                painter: CurvePainter(true),
              ),
            ),
            Positioned(
              top: size.height * 0.13,
              right: size.width * 0.05,
              left: size.width * 0.05,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () => storageProvider.selectFile(),
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
                          child: storageProvider.imageToUpload == null
                              ? Container(
                                  width: size.width * 0.8,
                                  height: size.height * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Añadir Archivo')
                                    ],
                                  ),
                                )
                              : storageProvider.imageFormats.contains(storageProvider.imageToUpload!.extension!.toLowerCase())
                              
                               ? !kIsWeb 
                                ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.file(
                                    File(storageProvider.imageToUpload!.path!),
                                    fit: BoxFit.contain,
                                  ),
                                )
                                : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.memory(
                                    storageProvider.imageToUpload!.bytes!
                                    ,
                                    fit: BoxFit.contain,
                                  ),
                                )

                                : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: size.width * 0.6,
                                    height: size.height * 0.3,
                                    child: 
                                        Icon(storageProvider.getIconByExtension(storageProvider.imageToUpload!.extension!), size: 200,color: Color.fromARGB(255, 20,146,230)),
                                        
                                    
                                  )
                                )
                                
                                
                                )
                                
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: nameController,
                    onChanged: (value) => storageProvider.fileName = value,
                    
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: descController,
                    onChanged: (value) => storageProvider.fileName = value,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: nameController.text == ''
                      ? null
                      : () async {

                      bool uploaded = await storageProvider.uploadImage(nameController.text, descController.text);
                      if (uploaded) {

                        storageProvider.reset();
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Imagen subida correctamente")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Ha ocurrido un error")));
                      }
                    },

                    child: Text('Subir archivo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )

        /* Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
      
            img_to_upload == null
              ? Container(
              height: 200,
              width: double.infinity,
              color: Colors.red,
              margin: EdgeInsets.all(10),
            )
            : Image.file(img_to_upload!, width: double.infinity, height: 200),
            
            ElevatedButton(
              onPressed: () async {
      
                SelectImageService sis = SelectImageService();
      
                final XFile? image = await sis.getImage();
                setState(() {
                  img_to_upload = File(image!.path);
                });
                
              },
              child: Text('Seleccionar imagen'),
            ),
            ElevatedButton(
              onPressed: () async {
      
                StorageService ss = StorageService();
                final uploaded = await ss.uploadImage(img_to_upload!);
      
                if(uploaded){
                  final storageProvider = Provider.of<StorageProvider>(context, listen: false);
                   await storageProvider.getFiles();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Imagen subida correctamente"))
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ha ocurrido un error"))
                  );
                }
                
              },
              child: Text('Subir imagen'),
            ),
            
          ],
        ),
      ) */
        );
  }
}
