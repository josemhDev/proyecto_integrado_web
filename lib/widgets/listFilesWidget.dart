import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:proyecto_integrado_3/model/storedItem.dart';
import 'package:proyecto_integrado_3/providers/appProvider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';
import 'package:proyecto_integrado_3/search/filesSearchDelegate.dart';
import 'package:proyecto_integrado_3/services/storageService.dart';

import '../painters/curvePainter.dart';
import '../providers/googleSignInProvider.dart';

class ListFilesWidget extends StatelessWidget {
  const ListFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final storageProvider = Provider.of<StorageProvider>(context);
    var appProvider = Provider.of<AppProvider>(context);
    const icons = [
      Icons.image,
      Icons.picture_as_pdf,
      Icons.video_file,
      Icons.audio_file
    ];
    const fileType = ['image', 'pdf', 'video', 'audio'];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 60, 76),
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.25,
              child: CustomPaint(
                painter: CurvePainter(true),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              appProvider.fileSelected
                                  ? GestureDetector(
                                      onTap: () {
                                        /*  final provider =
                                          Provider.of<GoogleSignInProvider>(
                                              context,
                                              listen: false);
                                      provider.logout(); */

                                        appProvider.changeFileSelected();
                                      },
                                      child: const Icon(Icons.arrow_back,
                                          size: 30))
                                  : Container(),
                              const Text(
                                'BIENVENIDO',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                  onTap: (() => showSearch(
                                      context: context,
                                      delegate: FileSearchDelegate())),
                                  child: const Icon(Icons.search))
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            !appProvider.fileSelected
                ? !kIsWeb
                    ? TypeSelectorWidget(
                        size: size,
                        appProvider: appProvider,
                        fileType: fileType,
                        icons: icons)
                    : TypeSelectorWidgetWeb(
                        size: size,
                        appProvider: appProvider,
                        fileType: fileType,
                        icons: icons)
                : ListFileCardWidget(
                    size: size, storageProvider: storageProvider),
            //TODO Botones no suporteados en web
            //ListFileCardWidget(size: size, storageProvider: storageProvider),

            appProvider.fileSelected &&
                    appProvider.fileSelectedType == 'image' &&
                    !kIsWeb
                ? ShowListTypeSelectorWidget(
                    size: size, storageProvider: storageProvider)
                : Container()
          ],
        ),
      ),
    );
  }
}

class TypeSelectorWidget extends StatelessWidget {
  const TypeSelectorWidget({
    super.key,
    required this.size,
    required this.appProvider,
    required this.fileType,
    required this.icons,
  });

  final Size size;
  final AppProvider appProvider;
  final List<String> fileType;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.2,
      left: size.width * 0.05,
      right: size.width * 0.05,
      child: Container(
        height: size.height,
        width: size.width,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(3),
              child: GestureDetector(
                onTap: () {
                  appProvider.changeFileSelected();
                  appProvider.changeFileType(fileType[index]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 57, 60, 76),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 3,
                            spreadRadius: 3,
                            offset: const Offset(0, 4))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Icon(
                    icons[index],
                    size: 100,
                    color: const Color.fromARGB(255, 20, 146, 230),
                  ),
                  /* storageProvider.storedItems.isEmpty
                                        ? const Center(child: Text('No hay ninguna imagen'),)
                                        : storageProvider.gridMode
                    ? const FileListGridWidget()
                    : const FileListWidget() */
                  /* StreamBuilder(
                stream: storageProvider.readFiles(),
                builder: (BuildContext context, AsyncSnapshot<List<StoredItem>> snapshot) {
                  if(snapshot.hasData){
                    storageProvider.storedItems = snapshot.data!;
                    return storageProvider.gridMode
                      ? const FileListGridWidget()
                      : const FileListWidget();
                  } else if (snapshot.hasError){
                    return Text('Ha ocurrido un error');
                  } else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
                                        ), */
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TypeSelectorWidgetWeb extends StatelessWidget {
  const TypeSelectorWidgetWeb({
    super.key,
    required this.size,
    required this.appProvider,
    required this.fileType,
    required this.icons,
  });

  final Size size;
  final AppProvider appProvider;
  final List<String> fileType;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.23,
      bottom: 0,
      left: size.width > 1000 ? size.width * 0.3 : size.width * 0.2,
      right: size.width > 1000 ? size.width * 0.3 : size.width * 0.2,
      child: Container(
        height: size.height,
        width: size.width,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: size.width > 900
                  ? const EdgeInsets.all(10.0)
                  : const EdgeInsets.all(3),
              child: GestureDetector(
                onTap: () {
                  appProvider.changeFileSelected();
                  appProvider.changeFileType(fileType[index]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 57, 60, 76),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 3,
                            spreadRadius: 3,
                            offset: const Offset(0, 4))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Icon(
                    icons[index],
                    size: 100,
                    color: const Color.fromARGB(255, 20, 146, 230),
                  ),
                  /* storageProvider.storedItems.isEmpty
                                        ? const Center(child: Text('No hay ninguna imagen'),)
                                        : storageProvider.gridMode
                    ? const FileListGridWidget()
                    : const FileListWidget() */
                  /* StreamBuilder(
                stream: storageProvider.readFiles(),
                builder: (BuildContext context, AsyncSnapshot<List<StoredItem>> snapshot) {
                  if(snapshot.hasData){
                    storageProvider.storedItems = snapshot.data!;
                    return storageProvider.gridMode
                      ? const FileListGridWidget()
                      : const FileListWidget();
                  } else if (snapshot.hasError){
                    return Text('Ha ocurrido un error');
                  } else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
                                        ), */
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShowListTypeSelectorWidget extends StatelessWidget {
  ShowListTypeSelectorWidget({
    Key? key,
    required this.size,
    required this.storageProvider,
  }) : super(key: key);

  final Size size;
  final StorageProvider storageProvider;
  AnimatedButtonController controller = AnimatedButtonController();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    controller.index = appProvider.gridMode ? 1 : 0;
    return Positioned(
      bottom: 55,
      left: 50,
      right: 50,
      child: Container(
        height: size.height * 0.11,
        width: size.width * 0.7,
        child: AnimatedButtonBar(
          controller: controller,
          radius: 32.0,
          padding: const EdgeInsets.all(16.0),
          backgroundColor: const Color.fromARGB(255, 57, 60, 76),
          foregroundColor: const Color.fromARGB(255, 20, 146, 230),
          elevation: 24,
          innerVerticalPadding: 16,
          children: [
            ButtonBarEntry(
                onTap: () => appProvider.turnOffGrid(),
                child: const Icon(Icons.list)),
            ButtonBarEntry(
                onTap: () => appProvider.turnOnGrid(),
                child: const Icon(Icons.grid_view)),
          ],
        ),
      ),
    );
  }
}

class ListFileCardWidget extends StatelessWidget {
  const ListFileCardWidget({
    Key? key,
    required this.size,
    required this.storageProvider,
  }) : super(key: key);

  final Size size;
  final StorageProvider storageProvider;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Positioned(
      top: size.height * 0.2,
      bottom: size.height * 0.12,
      right: size.width * 0.05,
      left: size.width * 0.05,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 57, 60, 76),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade900,
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: const Offset(0, 4))
            ]),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: /* storageProvider.storedItems.isEmpty
          ? const Center(child: Text('No hay ninguna imagen'),)
          : storageProvider.gridMode
                ? const FileListGridWidget()
                : const FileListWidget() */
            StreamBuilder(
          stream: storageProvider.readFiles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<StoredItem>> snapshot) {
            if (snapshot.hasData) {
              storageProvider.storedItems = snapshot.data!;
              storageProvider.storedImages = [];
              for (var element in storageProvider.storedItems) {
                if (element.type.contains('image')) {
                  storageProvider.storedImages.add(element);
                }
              
                
              }

              return appProvider.gridMode &&
                      appProvider.fileSelectedType.contains('image')
                  ? FileListGridWidget(files: storageProvider.storedImages)
                  : FileListWidget(
                      files: snapshot.data!,
                    );
            } else if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class FileListGridWidget extends StatelessWidget {
  final List<StoredItem> files;
  const FileListGridWidget({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storageProvider = Provider.of<StorageProvider>(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: storageProvider.storedImages.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                storageProvider.selectedFile = index;
                storageProvider.showInfoFile = storageProvider.storedImages[index];
                Navigator.pushNamed(context, 'info',
                    arguments: {'file': storageProvider.storedImages[index]});
              },
              child: Container(
                color: const Color.fromARGB(255, 57, 60, 76),
                child: Column(
                  children: [
                    Hero(
                      tag: storageProvider.storedItems[index].name,
                      child: Image.network(storageProvider.storedImages[index].imgUrl,fit: BoxFit.fill,),
                        
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FileListWidget extends StatelessWidget {
  final List<StoredItem> files;
  const FileListWidget({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storageProvider = Provider.of<StorageProvider>(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: storageProvider.storedItems.length,
        itemBuilder: (BuildContext context, int index) {
          return storageProvider.storedItems[index].type
                      .contains(appProvider.fileSelectedType) ||
                  storageProvider.storedItems[index].type ==
                      'application/octet-stream'
              ? GestureDetector(
                  onTap: () {
                    storageProvider.selectedFile = index;
                    storageProvider.showInfoFile = files[index];
                    Navigator.pushNamed(context, 'info');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 20, 146, 230),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListTile(
                          leading: Icon(
                            storageProvider.getIconByType(files[index].type),
                            size: 35,
                          ),
                          title: Text(files[index].name),
                          trailing: Text(
                              '${double.parse((storageProvider.storedItems[index].size / 1024 / 1024).toStringAsFixed(2))}MB'),
                          
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
