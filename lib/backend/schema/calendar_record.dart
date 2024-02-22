import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarRecord extends FirestoreRecord {
  CalendarRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "venture" field.
  DocumentReference? _venture;
  DocumentReference? get venture => _venture;
  bool hasVenture() => _venture != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  bool hasNombre() => _nombre != null;

  // "celular" field.
  String? _celular;
  String get celular => _celular ?? '';
  bool hasCelular() => _celular != null;

  // "dateBooked" field.
  DateTime? _dateBooked;
  DateTime? get dateBooked => _dateBooked;
  bool hasDateBooked() => _dateBooked != null;

  // "dateCanceled" field.
  DateTime? _dateCanceled;
  DateTime? get dateCanceled => _dateCanceled;
  bool hasDateCanceled() => _dateCanceled != null;

  // "personaService" field.
  List<DocumentReference>? _personaService;
  List<DocumentReference> get personaService => _personaService ?? const [];
  bool hasPersonaService() => _personaService != null;

  // "fechaInicio" field.
  DateTime? _fechaInicio;
  DateTime? get fechaInicio => _fechaInicio;
  bool hasFechaInicio() => _fechaInicio != null;

  // "fechaFin" field.
  DateTime? _fechaFin;
  DateTime? get fechaFin => _fechaFin;
  bool hasFechaFin() => _fechaFin != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  bool hasUuid() => _uuid != null;

  void _initializeFields() {
    _venture = snapshotData['venture'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _nombre = snapshotData['nombre'] as String?;
    _celular = snapshotData['celular'] as String?;
    _dateBooked = snapshotData['dateBooked'] as DateTime?;
    _dateCanceled = snapshotData['dateCanceled'] as DateTime?;
    _personaService = getDataList(snapshotData['personaService']);
    _fechaInicio = snapshotData['fechaInicio'] as DateTime?;
    _fechaFin = snapshotData['fechaFin'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _uuid = snapshotData['uuid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calendar');

  static Stream<CalendarRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalendarRecord.fromSnapshot(s));

  static Future<CalendarRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalendarRecord.fromSnapshot(s));

  static CalendarRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalendarRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalendarRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalendarRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalendarRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalendarRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalendarRecordData({
  DocumentReference? venture,
  DateTime? date,
  String? nombre,
  String? celular,
  DateTime? dateBooked,
  DateTime? dateCanceled,
  DateTime? fechaInicio,
  DateTime? fechaFin,
  String? status,
  String? uuid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'venture': venture,
      'date': date,
      'nombre': nombre,
      'celular': celular,
      'dateBooked': dateBooked,
      'dateCanceled': dateCanceled,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'status': status,
      'uuid': uuid,
    }.withoutNulls,
  );

  return firestoreData;
}

class CalendarRecordDocumentEquality implements Equality<CalendarRecord> {
  const CalendarRecordDocumentEquality();

  @override
  bool equals(CalendarRecord? e1, CalendarRecord? e2) {
    const listEquality = ListEquality();
    return e1?.venture == e2?.venture &&
        e1?.date == e2?.date &&
        e1?.nombre == e2?.nombre &&
        e1?.celular == e2?.celular &&
        e1?.dateBooked == e2?.dateBooked &&
        e1?.dateCanceled == e2?.dateCanceled &&
        listEquality.equals(e1?.personaService, e2?.personaService) &&
        e1?.fechaInicio == e2?.fechaInicio &&
        e1?.fechaFin == e2?.fechaFin &&
        e1?.status == e2?.status &&
        e1?.uuid == e2?.uuid;
  }

  @override
  int hash(CalendarRecord? e) => const ListEquality().hash([
        e?.venture,
        e?.date,
        e?.nombre,
        e?.celular,
        e?.dateBooked,
        e?.dateCanceled,
        e?.personaService,
        e?.fechaInicio,
        e?.fechaFin,
        e?.status,
        e?.uuid
      ]);

  @override
  bool isValidKey(Object? o) => o is CalendarRecord;
}
