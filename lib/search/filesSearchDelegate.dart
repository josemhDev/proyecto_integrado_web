import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';

import '../model/storedItem.dart';
import '../widgets/listFilesWidget.dart';

class FileSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: const Icon(
            Icons.clear,
            color: Color.fromARGB(255, 20, 146, 230),
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Color.fromARGB(255, 20, 146, 230),
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    StorageProvider storageProvider = StorageProvider();

    return ListView.builder(
      itemCount: storageProvider.storedItems.length,
      itemBuilder: ((context, index) {
        if (storageProvider.storedItems[index].name.contains(query)) {
          return GestureDetector(
            onTap: () {
              storageProvider.selectedFile = index;
              Navigator.pushNamed(context, 'info');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 146, 230),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListTile(
                    leading: Icon(storageProvider
                        .formats[storageProvider.storedItems[index].type]),
                    title: Text(storageProvider.storedItems[index].name),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //TODO StreamBulder

    var storageProvider = Provider.of<StorageProvider>(context);

    if (query == "") {
      return Container(
        color: const Color.fromARGB(255, 57, 60, 76),
        child: const Center(
          child: Icon(
            Icons.file_copy,
            size: 200,
            color: Color.fromARGB(255, 20, 146, 230),
          ),
        ),
      );
    } else {
      return StreamBuilder(
        stream: storageProvider.readFiles(),
        builder:
            (BuildContext context, AsyncSnapshot<List<StoredItem>> snapshot) {
          if (snapshot.hasData) {
            storageProvider.storedItems = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: storageProvider.storedItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data![index].name.toLowerCase().contains(query.toLowerCase())
                      ? GestureDetector(
                          onTap: () {
                            storageProvider.selectedFile = index;
                            storageProvider.showInfoFile = storageProvider.storedItems[index];
                            Navigator.pushNamed(context, 'info',
                                arguments: {'file': snapshot.data![index]});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 20, 146, 230),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  leading: Icon(
                                    storageProvider.getIconByType(storageProvider.storedItems[index].type),
                                    size: 35,
                                  ),
                                  title: Text(snapshot.data![index].name),
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
          } else if (snapshot.hasError) {
            return Text('Ha ocurrido un error');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
