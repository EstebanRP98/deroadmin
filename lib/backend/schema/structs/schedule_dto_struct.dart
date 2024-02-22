// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScheduleDtoStruct extends FFFirebaseStruct {
  ScheduleDtoStruct({
    String? scheduleId,
    String? status,
    String? ventureId,
    List<ServiceDtoStruct>? services,
    ClientDtoStruct? client,
    String? title,
    bool? visible,
    String? description,
    String? color,
    String? location,
    String? alert,
    String? startTime,
    String? endTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _scheduleId = scheduleId,
        _status = status,
        _ventureId = ventureId,
        _services = services,
        _client = client,
        _title = title,
        _visible = visible,
        _description = description,
        _color = color,
        _location = location,
        _alert = alert,
        _startTime = startTime,
        _endTime = endTime,
        super(firestoreUtilData);

  // "schedule_id" field.
  String? _scheduleId;
  String get scheduleId => _scheduleId ?? '';
  set scheduleId(String? val) => _scheduleId = val;
  bool hasScheduleId() => _scheduleId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;
  bool hasStatus() => _status != null;

  // "venture_id" field.
  String? _ventureId;
  String get ventureId => _ventureId ?? '';
  set ventureId(String? val) => _ventureId = val;
  bool hasVentureId() => _ventureId != null;

  // "services" field.
  List<ServiceDtoStruct>? _services;
  List<ServiceDtoStruct> get services => _services ?? const [];
  set services(List<ServiceDtoStruct>? val) => _services = val;
  void updateServices(Function(List<ServiceDtoStruct>) updateFn) =>
      updateFn(_services ??= []);
  bool hasServices() => _services != null;

  // "client" field.
  ClientDtoStruct? _client;
  ClientDtoStruct get client => _client ?? ClientDtoStruct();
  set client(ClientDtoStruct? val) => _client = val;
  void updateClient(Function(ClientDtoStruct) updateFn) =>
      updateFn(_client ??= ClientDtoStruct());
  bool hasClient() => _client != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "visible" field.
  bool? _visible;
  bool get visible => _visible ?? false;
  set visible(bool? val) => _visible = val;
  bool hasVisible() => _visible != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;
  bool hasColor() => _color != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;
  bool hasLocation() => _location != null;

  // "alert" field.
  String? _alert;
  String get alert => _alert ?? '';
  set alert(String? val) => _alert = val;
  bool hasAlert() => _alert != null;

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

  static ScheduleDtoStruct fromMap(Map<String, dynamic> data) =>
      ScheduleDtoStruct(
        scheduleId: data['schedule_id'] as String?,
        status: data['status'] as String?,
        ventureId: data['venture_id'] as String?,
        services: getStructList(
          data['services'],
          ServiceDtoStruct.fromMap,
        ),
        client: ClientDtoStruct.maybeFromMap(data['client']),
        title: data['title'] as String?,
        visible: data['visible'] as bool?,
        description: data['description'] as String?,
        color: data['color'] as String?,
        location: data['location'] as String?,
        alert: data['alert'] as String?,
        startTime: data['start_time'] as String?,
        endTime: data['end_time'] as String?,
      );

  static ScheduleDtoStruct? maybeFromMap(dynamic data) => data is Map
      ? ScheduleDtoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'schedule_id': _scheduleId,
        'status': _status,
        'venture_id': _ventureId,
        'services': _services?.map((e) => e.toMap()).toList(),
        'client': _client?.toMap(),
        'title': _title,
        'visible': _visible,
        'description': _description,
        'color': _color,
        'location': _location,
        'alert': _alert,
        'start_time': _startTime,
        'end_time': _endTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'schedule_id': serializeParam(
          _scheduleId,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'venture_id': serializeParam(
          _ventureId,
          ParamType.String,
        ),
        'services': serializeParam(
          _services,
          ParamType.DataStruct,
          true,
        ),
        'client': serializeParam(
          _client,
          ParamType.DataStruct,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'visible': serializeParam(
          _visible,
          ParamType.bool,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'alert': serializeParam(
          _alert,
          ParamType.String,
        ),
        'start_time': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'end_time': serializeParam(
          _endTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static ScheduleDtoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ScheduleDtoStruct(
        scheduleId: deserializeParam(
          data['schedule_id'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        ventureId: deserializeParam(
          data['venture_id'],
          ParamType.String,
          false,
        ),
        services: deserializeStructParam<ServiceDtoStruct>(
          data['services'],
          ParamType.DataStruct,
          true,
          structBuilder: ServiceDtoStruct.fromSerializableMap,
        ),
        client: deserializeStructParam(
          data['client'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientDtoStruct.fromSerializableMap,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        visible: deserializeParam(
          data['visible'],
          ParamType.bool,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        alert: deserializeParam(
          data['alert'],
          ParamType.String,
          false,
        ),
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
  String toString() => 'ScheduleDtoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ScheduleDtoStruct &&
        scheduleId == other.scheduleId &&
        status == other.status &&
        ventureId == other.ventureId &&
        listEquality.equals(services, other.services) &&
        client == other.client &&
        title == other.title &&
        visible == other.visible &&
        description == other.description &&
        color == other.color &&
        location == other.location &&
        alert == other.alert &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        scheduleId,
        status,
        ventureId,
        services,
        client,
        title,
        visible,
        description,
        color,
        location,
        alert,
        startTime,
        endTime
      ]);
}

ScheduleDtoStruct createScheduleDtoStruct({
  String? scheduleId,
  String? status,
  String? ventureId,
  ClientDtoStruct? client,
  String? title,
  bool? visible,
  String? description,
  String? color,
  String? location,
  String? alert,
  String? startTime,
  String? endTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ScheduleDtoStruct(
      scheduleId: scheduleId,
      status: status,
      ventureId: ventureId,
      client: client ?? (clearUnsetFields ? ClientDtoStruct() : null),
      title: title,
      visible: visible,
      description: description,
      color: color,
      location: location,
      alert: alert,
      startTime: startTime,
      endTime: endTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ScheduleDtoStruct? updateScheduleDtoStruct(
  ScheduleDtoStruct? scheduleDto, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    scheduleDto
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addScheduleDtoStructData(
  Map<String, dynamic> firestoreData,
  ScheduleDtoStruct? scheduleDto,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (scheduleDto == null) {
    return;
  }
  if (scheduleDto.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && scheduleDto.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final scheduleDtoData =
      getScheduleDtoFirestoreData(scheduleDto, forFieldValue);
  final nestedData =
      scheduleDtoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = scheduleDto.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getScheduleDtoFirestoreData(
  ScheduleDtoStruct? scheduleDto, [
  bool forFieldValue = false,
]) {
  if (scheduleDto == null) {
    return {};
  }
  final firestoreData = mapToFirestore(scheduleDto.toMap());

  // Handle nested data for "client" field.
  addClientDtoStructData(
    firestoreData,
    scheduleDto.hasClient() ? scheduleDto.client : null,
    'client',
    forFieldValue,
  );

  // Add any Firestore field values
  scheduleDto.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getScheduleDtoListFirestoreData(
  List<ScheduleDtoStruct>? scheduleDtos,
) =>
    scheduleDtos?.map((e) => getScheduleDtoFirestoreData(e, true)).toList() ??
    [];
