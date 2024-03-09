import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitajom/model/restaurant.dart';

class RestaurantController{
  final CollectionReference restaurantsCollection = FirebaseFirestore.instance.collection('restaurant');

  Stream<QuerySnapshot> getRestaurants(){
    return restaurantsCollection.snapshots();
  }
}