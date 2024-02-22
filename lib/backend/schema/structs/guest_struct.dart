// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GuestStruct extends FFFirebaseStruct {
  GuestStruct({
    String? name,
    bool? attending,
    String? img,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _attending = attending,
        _img = img,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "attending" field.
  bool? _attending;
  bool get attending => _attending ?? false;
  set attending(bool? val) => _attending = val;
  bool hasAttending() => _attending != null;

  // "img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;
  bool hasImg() => _img != null;

  static GuestStruct fromMap(Map<String, dynamic> data) => GuestStruct(
        name: data['name'] as String?,
        attending: data['attending'] as bool?,
        img: data['img'] as String?,
      );

  static GuestStruct? maybeFromMap(dynamic data) =>
      data is Map ? GuestStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'attending': _attending,
        'img': _img,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'attending': serializeParam(
          _attending,
          ParamType.bool,
        ),
        'img': serializeParam(
          _img,
          ParamType.String,
        ),
      }.withoutNulls;

  static GuestStruct fromSerializableMap(Map<String, dynamic> data) =>
      GuestStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        attending: deserializeParam(
          data['attending'],
          ParamType.bool,
          false,
        ),
        img: deserializeParam(
          data['img'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GuestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GuestStruct &&
        name == other.name &&
        attending == other.attending &&
        img == other.img;
  }

  @override
  int get hashCode => const ListEquality().hash([name, attending, img]);
}

GuestStruct createGuestStruct({
  String? name,
  bool? attending,
  String? img,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GuestStruct(
      name: name,
      attending: attending,
      img: img,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GuestStruct? updateGuestStruct(
  GuestStruct? guest, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    guest
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGuestStructData(
  Map<String, dynamic> firestoreData,
  GuestStruct? guest,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (guest == null) {
    return;
  }
  if (guest.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && guest.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final guestData = getGuestFirestoreData(guest, forFieldValue);
  final nestedData = guestData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = guest.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGuestFirestoreData(
  GuestStruct? guest, [
  bool forFieldValue = false,
]) {
  if (guest == null) {
    return {};
  }
  final firestoreData = mapToFirestore(guest.toMap());

  // Add any Firestore field values
  guest.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGuestListFirestoreData(
  List<GuestStruct>? guests,
) =>
    guests?.map((e) => getGuestFirestoreData(e, true)).toList() ?? [];
