import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ijob_clone_app/Services/global_variabel.dart';

class Persistent {
  static List<String> jobCategoryList = [
    'Architecture and Construction',
    'Education and Traning',
    'Development - Programming',
    'Business',
    'Human Resources',
    'Markating',
    'Accounting',
  ];

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    name = userDoc.get('name');
    userImage = userDoc.get('userImage');
    location = userDoc.get('location');
  }
}
