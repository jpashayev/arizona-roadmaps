import 'package:cloud_firestore/cloud_firestore.dart';

import 'Campsite.dart';

class DataRepository {
  // Call reference to firestore collection campsites
  final CollectionReference collection =
      Firestore.instance.collection('campsites');

  // snapshots method --> getStream listens for updates automatically
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  addCampsite(Campsite campsite) async {
    await collection.add(campsite.toJson());
  }

  // update Each Campsite if changed
  updateCampsite(Campsite campsite) async {
    await collection
        .document(campsite.reference.documentID)
        .updateData(campsite.toJson());
  }
}
