import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signally/models/announcement.dart';
import 'package:signally/models/signal.dart';
import 'package:signally/models/support.dart';

import '../models/app_control.dart';

class FirestoreService {
  static Stream<AppControl> streamAppControl() {
    var ref = FirebaseFirestore.instance.collection('appControl').doc('appControl').snapshots();
    return ref.map((doc) => AppControl.fromJson({...?doc.data(), "id": doc.id}));
  }

  static Stream<List<Signal>> streamSignals() {
    var ref = FirebaseFirestore.instance.collection('signals').snapshots();
    return ref.map((doc) => doc.docs.map((doc) => Signal.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Announcement>> streamAnnouncements() {
    var ref = FirebaseFirestore.instance.collection('announcements').orderBy('timestampCreated').snapshots();
    return ref.map((doc) => doc.docs.map((doc) => Announcement.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Future<bool> addSupport(Support support) async {
    var ref = FirebaseFirestore.instance.collection('supports').doc();
    try {
      await ref.set(support.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
