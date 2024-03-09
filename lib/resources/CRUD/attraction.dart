import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitajom/model/attraction.dart';

class AttractionController {
  final CollectionReference attractionsCollection = FirebaseFirestore.instance
      .collection('activity');

  Stream<QuerySnapshot> getAttractions() {
    return attractionsCollection.snapshots();
  }




}