import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SocialRecord extends FirestoreRecord {
  SocialRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "venture" field.
  DocumentReference? _venture;
  DocumentReference? get venture => _venture;
  bool hasVenture() => _venture != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _url = snapshotData['url'] as String?;
    _venture = snapshotData['venture'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('social');

  static Stream<SocialRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SocialRecord.fromSnapshot(s));

  static Future<SocialRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SocialRecord.fromSnapshot(s));

  static SocialRecord fromSnapshot(DocumentSnapshot snapshot) => SocialRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SocialRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SocialRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SocialRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SocialRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSocialRecordData({
  String? title,
  String? url,
  DocumentReference? venture,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'url': url,
      'venture': venture,
    }.withoutNulls,
  );

  return firestoreData;
}

class SocialRecordDocumentEquality implements Equality<SocialRecord> {
  const SocialRecordDocumentEquality();

  @override
  bool equals(SocialRecord? e1, SocialRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.url == e2?.url &&
        e1?.venture == e2?.venture;
  }

  @override
  int hash(SocialRecord? e) =>
      const ListEquality().hash([e?.title, e?.url, e?.venture]);

  @override
  bool isValidKey(Object? o) => o is SocialRecord;
}
