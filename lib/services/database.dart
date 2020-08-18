import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kutchmahamandalbhav/models/report.dart';

class Database {
  static Stream<List<Report>> getReport() {
    return Firestore.instance
        .collection("reports")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Report.fromJson(e.data)).toList());
  }
}
