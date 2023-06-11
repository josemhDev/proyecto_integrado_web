import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_integrado_3/model/User.dart';
import 'package:proyecto_integrado_3/model/storedItem.dart';

class FirestoreService {
  final user = FirebaseAuth.instance.currentUser!;

  Future createFile(String uuid, String name, String desc, String imgPath,
      int size, String type, String createdAt) async {
    final docFile = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('files')
        .doc(uuid);

    final fileToUpload = StoredItem(
        name: name,
        imgUrl: imgPath,
        desc: desc,
        size: size,
        type: type,
        createdAt: createdAt);

    await docFile.set(fileToUpload.toMap());
  }

  Stream<List<StoredItem>> readFiles() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('files')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var storedItem = StoredItem.fromMap(doc.data());
              storedItem.id = doc.id;
              return storedItem;
            }).toList());
  }

  Future updateFile(String elementToUpdate,StoredItem file, String newValue) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('files')
        .doc(file.id);

    await doc.update({elementToUpdate: newValue});
  }

  Future updateUserName(String newValue) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
        

    await doc.update({"name": newValue});
  }

  Future updateUserEmail(String newValue) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
         
    await user.updateEmail(newValue);
    await doc.update({"email": newValue});
  }

  Future deleteFile(String id) async{
    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('files').doc(id);
    await doc.delete();
  }

  Future<UserModel> getUser() async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      var user = UserModel.fromMap(snapshot.data()!);
     
      user.id = snapshot.id;
      return user;
    } else {
      var userToCreate = UserModel(
          email: user.email!,
          name: user.displayName!,
          imgProfilePath: user.photoURL!);
      await docUser.set(userToCreate.toMap());
      userToCreate.id = user.uid;
      return userToCreate;
    }
  }

  Future createUser(UserModel userToCreate) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    await docUser.set(userToCreate.toMap());
  }
}
