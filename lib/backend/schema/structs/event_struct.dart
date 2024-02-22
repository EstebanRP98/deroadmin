// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventStruct extends FFFirebaseStruct {
  EventStruct({
    String? title,
    bool? visible,
    String? description,
    String? location,
    String? alert,
    String? color,
    List<GuestStruct>? guests,
    String? startTime,
    String? endTime,
    String? scheduleId,
    String? status,
    String? ventureId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _visible = visible,
        _description = description,
        _location = location,
        _alert = alert,
        _color = color,
        _guests = guests,
        _startTime = startTime,
        _endTime = endTime,
        _scheduleId = scheduleId,
        _status = status,
        _ventureId = ventureId,
        super(firestoreUtilData);

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

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;
  bool hasColor() => _color != null;

  // "guests" field.
  List<GuestStruct>? _guests;
  List<GuestStruct> get guests => _guests ?? const [];
  set guests(List<GuestStruct>? val) => _guests = val;
  void updateGuests(Function(List<GuestStruct>) updateFn) =>
      updateFn(_guests ??= []);
  bool hasGuests() => _guests != null;

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

  static EventStruct fromMap(Map<String, dynamic> data) => EventStruct(
        title: data['title'] as String?,
        visible: data['visible'] as bool?,
        description: data['description'] as String?,
        location: data['location'] as String?,
        alert: data['alert'] as String?,
        color: data['color'] as String?,
        guests: getStructList(
          data['guests'],
          GuestStruct.fromMap,
        ),
        startTime: data['start_time'] as String?,
        endTime: data['end_time'] as String?,
        scheduleId: data['schedule_id'] as String?,
        status: data['status'] as String?,
        ventureId: data['venture_id'] as String?,
      );

  static EventStruct? maybeFromMap(dynamic data) =>
      data is Map ? EventStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'visible': _visible,
        'description': _description,
        'location': _location,
        'alert': _alert,
        'color': _color,
        'guests': _guests?.map((e) => e.toMap()).toList(),
        'start_time': _startTime,
        'end_time': _endTime,
        'schedule_id': _scheduleId,
        'status': _status,
        'venture_id': _ventureId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
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
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'alert': serializeParam(
          _alert,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'guests': serializeParam(
          _guests,
          ParamType.DataStruct,
          true,
        ),
        'start_time': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'end_time': serializeParam(
          _endTime,
          ParamType.String,
        ),
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
      }.withoutNulls;

  static EventStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventStruct(
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
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        guests: deserializeStructParam<GuestStruct>(
          data['guests'],
          ParamType.DataStruct,
          true,
          structBuilder: GuestStruct.fromSerializableMap,
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
      );

  @override
  String toString() => 'EventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventStruct &&
        title == other.title &&
        visible == other.visible &&
        description == other.description &&
        location == other.location &&
        alert == other.alert &&
        color == other.color &&
        listEquality.equals(guests, other.guests) &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        scheduleId == other.scheduleId &&
        status == other.status &&
        ventureId == other.ventureId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        visible,
        description,
        location,
        alert,
        color,
        guests,
        startTime,
        endTime,
        scheduleId,
        status,
        ventureId
      ]);
}

EventStruct createEventStruct({
  String? title,
  bool? visible,
  String? description,
  String? location,
  String? alert,
  String? color,
  String? startTime,
  String? endTime,
  String? scheduleId,
  String? status,
  String? ventureId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventStruct(
      title: title,
      visible: visible,
      description: description,
      location: location,
      alert: alert,
      color: color,
      startTime: startTime,
      endTime: endTime,
      scheduleId: scheduleId,
      status: status,
      ventureId: ventureId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventStruct? updateEventStruct(
  EventStruct? event, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    event
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventStructData(
  Map<String, dynamic> firestoreData,
  EventStruct? event,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (event == null) {
    return;
  }
  if (event.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && event.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventData = getEventFirestoreData(event, forFieldValue);
  final nestedData = eventData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = event.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventFirestoreData(
  EventStruct? event, [
  bool forFieldValue = false,
]) {
  if (event == null) {
    return {};
  }
  final firestoreData = mapToFirestore(event.toMap());

  // Add any Firestore field values
  event.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventListFirestoreData(
  List<EventStruct>? events,
) =>
    events?.map((e) => getEventFirestoreData(e, true)).toList() ?? [];
