import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitajom/model/user.dart' as model;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await _firestore.collection('user')
        .doc(currentUser.uid)
        .get();

    return model.User.fromSnap(documentSnapshot);
  }


  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String lastName,
    required String firstName,
    required String confirm,
    required String phoneNumber,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          confirm.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore
            .collection('user')
            .doc(cred.user!.uid)
            .set({'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'photoUrl':"https://firebasestorage.googleapis.com/v0/b/kitajomdemo.appspot.com/o/default%20profile%20picture.png?alt=media&token=c5a98ab2-5cf8-4560-9f0b-c36dc6ce0940",

        'role': "customer",
          'bookmark': []});
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        print("empty field found");
      } // on FirebaseAuthException catch (e) {if(e.code == 'wrong-password' or 'user-not-found')}
    } catch (err) {
      res = err.toString();
    }
    return res;
  }



}