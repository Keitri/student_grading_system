import 'package:cloud_firestore/cloud_firestore.dart' as fb;

extension DateTimeParser on Object {
  DateTime fromTimeStampToDateTime() {
    if (this is fb.Timestamp) {
      return (this as fb.Timestamp).toDate();
    } else {
      return DateTime(1900, 01, 01);
    }
  }
}
