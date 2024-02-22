import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PersonaServiceRecord extends FirestoreRecord {
  PersonaServiceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "servicios" field.
  List<DocumentReference>? _servicios;
  List<DocumentReference> get servicios => _servicios ?? const [];
  bool hasServicios() => _servicios != null;

  // "orden" field.
  int? _orden;
  int get orden => _orden ?? 0;
  bool hasOrden() => _orden != null;

  void _initializeFields() {
    _servicios = getDataList(snapshotData['servicios']);
    _orden = castToType<int>(snapshotData['orden']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('personaService');

  static Stream<PersonaServiceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PersonaServiceRecord.fromSnapshot(s));

  static Future<PersonaServiceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PersonaServiceRecord.fromSnapshot(s));

  static PersonaServiceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PersonaServiceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PersonaServiceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PersonaServiceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PersonaServiceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PersonaServiceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPersonaServiceRecordData({
  int? orden,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'orden': orden,
    }.withoutNulls,
  );

  return firestoreData;
}

class PersonaServiceRecordDocumentEquality
    implements Equality<PersonaServiceRecord> {
  const PersonaServiceRecordDocumentEquality();

  @override
  bool equals(PersonaServiceRecord? e1, PersonaServiceRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.servicios, e2?.servicios) &&
        e1?.orden == e2?.orden;
  }

  @override
  int hash(PersonaServiceRecord? e) =>
      const ListEquality().hash([e?.servicios, e?.orden]);

  @override
  bool isValidKey(Object? o) => o is PersonaServiceRecord;
}
