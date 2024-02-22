// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VentureTimeStruct extends FFFirebaseStruct {
  VentureTimeStruct({
    String? id,
    String? ventureId,
    String? day,
    List<RangesStruct>? timeRanges,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _ventureId = ventureId,
        _day = day,
        _timeRanges = timeRanges,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  // "venture_id" field.
  String? _ventureId;
  String get ventureId => _ventureId ?? '';
  set ventureId(String? val) => _ventureId = val;
  bool hasVentureId() => _ventureId != null;

  // "day" field.
  String? _day;
  String get day => _day ?? '';
  set day(String? val) => _day = val;
  bool hasDay() => _day != null;

  // "time_ranges" field.
  List<RangesStruct>? _timeRanges;
  List<RangesStruct> get timeRanges => _timeRanges ?? const [];
  set timeRanges(List<RangesStruct>? val) => _timeRanges = val;
  void updateTimeRanges(Function(List<RangesStruct>) updateFn) =>
      updateFn(_timeRanges ??= []);
  bool hasTimeRanges() => _timeRanges != null;

  static VentureTimeStruct fromMap(Map<String, dynamic> data) =>
      VentureTimeStruct(
        id: data['id'] as String?,
        ventureId: data['venture_id'] as String?,
        day: data['day'] as String?,
        timeRanges: getStructList(
          data['time_ranges'],
          RangesStruct.fromMap,
        ),
      );

  static VentureTimeStruct? maybeFromMap(dynamic data) => data is Map
      ? VentureTimeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'venture_id': _ventureId,
        'day': _day,
        'time_ranges': _timeRanges?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'venture_id': serializeParam(
          _ventureId,
          ParamType.String,
        ),
        'day': serializeParam(
          _day,
          ParamType.String,
        ),
        'time_ranges': serializeParam(
          _timeRanges,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static VentureTimeStruct fromSerializableMap(Map<String, dynamic> data) =>
      VentureTimeStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        ventureId: deserializeParam(
          data['venture_id'],
          ParamType.String,
          false,
        ),
        day: deserializeParam(
          data['day'],
          ParamType.String,
          false,
        ),
        timeRanges: deserializeStructParam<RangesStruct>(
          data['time_ranges'],
          ParamType.DataStruct,
          true,
          structBuilder: RangesStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'VentureTimeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is VentureTimeStruct &&
        id == other.id &&
        ventureId == other.ventureId &&
        day == other.day &&
        listEquality.equals(timeRanges, other.timeRanges);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, ventureId, day, timeRanges]);
}

VentureTimeStruct createVentureTimeStruct({
  String? id,
  String? ventureId,
  String? day,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VentureTimeStruct(
      id: id,
      ventureId: ventureId,
      day: day,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VentureTimeStruct? updateVentureTimeStruct(
  VentureTimeStruct? ventureTime, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    ventureTime
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVentureTimeStructData(
  Map<String, dynamic> firestoreData,
  VentureTimeStruct? ventureTime,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (ventureTime == null) {
    return;
  }
  if (ventureTime.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && ventureTime.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final ventureTimeData =
      getVentureTimeFirestoreData(ventureTime, forFieldValue);
  final nestedData =
      ventureTimeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = ventureTime.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVentureTimeFirestoreData(
  VentureTimeStruct? ventureTime, [
  bool forFieldValue = false,
]) {
  if (ventureTime == null) {
    return {};
  }
  final firestoreData = mapToFirestore(ventureTime.toMap());

  // Add any Firestore field values
  ventureTime.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVentureTimeListFirestoreData(
  List<VentureTimeStruct>? ventureTimes,
) =>
    ventureTimes?.map((e) => getVentureTimeFirestoreData(e, true)).toList() ??
    [];
