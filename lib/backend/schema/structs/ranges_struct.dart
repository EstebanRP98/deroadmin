// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RangesStruct extends FFFirebaseStruct {
  RangesStruct({
    String? startTime,
    String? endTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _startTime = startTime,
        _endTime = endTime,
        super(firestoreUtilData);

  // "start_time" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  set startTime(String? val) => _startTime = val;
  bool hasStartTime() => _startTime != null;

  // "end_time" field.
  String? _endTime;
  String get endTime => _endTime ?? '';
  set endTime(String? val) => _endTime = val;
  bool hasEndTime() => _endTime != null;

  static RangesStruct fromMap(Map<String, dynamic> data) => RangesStruct(
        startTime: data['start_time'] as String?,
        endTime: data['end_time'] as String?,
      );

  static RangesStruct? maybeFromMap(dynamic data) =>
      data is Map ? RangesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'start_time': _startTime,
        'end_time': _endTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'start_time': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'end_time': serializeParam(
          _endTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static RangesStruct fromSerializableMap(Map<String, dynamic> data) =>
      RangesStruct(
        startTime: deserializeParam(
          data['start_time'],
          ParamType.String,
          false,
        ),
        endTime: deserializeParam(
          data['end_time'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RangesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RangesStruct &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }

  @override
  int get hashCode => const ListEquality().hash([startTime, endTime]);
}

RangesStruct createRangesStruct({
  String? startTime,
  String? endTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RangesStruct(
      startTime: startTime,
      endTime: endTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RangesStruct? updateRangesStruct(
  RangesStruct? ranges, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    ranges
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRangesStructData(
  Map<String, dynamic> firestoreData,
  RangesStruct? ranges,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (ranges == null) {
    return;
  }
  if (ranges.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && ranges.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final rangesData = getRangesFirestoreData(ranges, forFieldValue);
  final nestedData = rangesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = ranges.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRangesFirestoreData(
  RangesStruct? ranges, [
  bool forFieldValue = false,
]) {
  if (ranges == null) {
    return {};
  }
  final firestoreData = mapToFirestore(ranges.toMap());

  // Add any Firestore field values
  ranges.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRangesListFirestoreData(
  List<RangesStruct>? rangess,
) =>
    rangess?.map((e) => getRangesFirestoreData(e, true)).toList() ?? [];
