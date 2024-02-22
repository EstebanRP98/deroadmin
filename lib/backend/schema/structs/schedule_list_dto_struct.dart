// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScheduleListDtoStruct extends FFFirebaseStruct {
  ScheduleListDtoStruct({
    List<ScheduleDtoStruct>? events,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _events = events,
        super(firestoreUtilData);

  // "events" field.
  List<ScheduleDtoStruct>? _events;
  List<ScheduleDtoStruct> get events => _events ?? const [];
  set events(List<ScheduleDtoStruct>? val) => _events = val;
  void updateEvents(Function(List<ScheduleDtoStruct>) updateFn) =>
      updateFn(_events ??= []);
  bool hasEvents() => _events != null;

  static ScheduleListDtoStruct fromMap(Map<String, dynamic> data) =>
      ScheduleListDtoStruct(
        events: getStructList(
          data['events'],
          ScheduleDtoStruct.fromMap,
        ),
      );

  static ScheduleListDtoStruct? maybeFromMap(dynamic data) => data is Map
      ? ScheduleListDtoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'events': _events?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'events': serializeParam(
          _events,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static ScheduleListDtoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ScheduleListDtoStruct(
        events: deserializeStructParam<ScheduleDtoStruct>(
          data['events'],
          ParamType.DataStruct,
          true,
          structBuilder: ScheduleDtoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ScheduleListDtoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ScheduleListDtoStruct &&
        listEquality.equals(events, other.events);
  }

  @override
  int get hashCode => const ListEquality().hash([events]);
}

ScheduleListDtoStruct createScheduleListDtoStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ScheduleListDtoStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ScheduleListDtoStruct? updateScheduleListDtoStruct(
  ScheduleListDtoStruct? scheduleListDto, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    scheduleListDto
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addScheduleListDtoStructData(
  Map<String, dynamic> firestoreData,
  ScheduleListDtoStruct? scheduleListDto,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (scheduleListDto == null) {
    return;
  }
  if (scheduleListDto.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && scheduleListDto.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final scheduleListDtoData =
      getScheduleListDtoFirestoreData(scheduleListDto, forFieldValue);
  final nestedData =
      scheduleListDtoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = scheduleListDto.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getScheduleListDtoFirestoreData(
  ScheduleListDtoStruct? scheduleListDto, [
  bool forFieldValue = false,
]) {
  if (scheduleListDto == null) {
    return {};
  }
  final firestoreData = mapToFirestore(scheduleListDto.toMap());

  // Add any Firestore field values
  scheduleListDto.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getScheduleListDtoListFirestoreData(
  List<ScheduleListDtoStruct>? scheduleListDtos,
) =>
    scheduleListDtos
        ?.map((e) => getScheduleListDtoFirestoreData(e, true))
        .toList() ??
    [];
