import 'package:cloud_firestore/cloud_firestore.dart';
import 'Campsite.dart';

class DataRepository {
  // Call reference to firestore collection campsites
  final CollectionReference collection = Firestore.instance.collection('campsites');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addCampsite(Campsite campsite) {
    return collection.add(campsite.toJson());
  }
  // 4
  updateCampsite(Campsite campsite) async {
    await collection.document(campsite.reference.documentID).updateData(campsite.toJson());
  }
}