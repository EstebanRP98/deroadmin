// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientDtoStruct extends FFFirebaseStruct {
  ClientDtoStruct({
    String? name,
    String? celular,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _celular = celular,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "celular" field.
  String? _celular;
  String get celular => _celular ?? '';
  set celular(String? val) => _celular = val;
  bool hasCelular() => _celular != null;

  static ClientDtoStruct fromMap(Map<String, dynamic> data) => ClientDtoStruct(
        name: data['name'] as String?,
        celular: data['celular'] as String?,
      );

  static ClientDtoStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientDtoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'celular': _celular,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'celular': serializeParam(
          _celular,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientDtoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClientDtoStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        celular: deserializeParam(
          data['celular'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientDtoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientDtoStruct &&
        name == other.name &&
        celular == other.celular;
  }

  @override
  int get hashCode => const ListEquality().hash([name, celular]);
}

ClientDtoStruct createClientDtoStruct({
  String? name,
  String? celular,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClientDtoStruct(
      name: name,
      celular: celular,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClientDtoStruct? updateClientDtoStruct(
  ClientDtoStruct? clientDto, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    clientDto
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClientDtoStructData(
  Map<String, dynamic> firestoreData,
  ClientDtoStruct? clientDto,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (clientDto == null) {
    return;
  }
  if (clientDto.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && clientDto.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final clientDtoData = getClientDtoFirestoreData(clientDto, forFieldValue);
  final nestedData = clientDtoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = clientDto.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClientDtoFirestoreData(
  ClientDtoStruct? clientDto, [
  bool forFieldValue = false,
]) {
  if (clientDto == null) {
    return {};
  }
  final firestoreData = mapToFirestore(clientDto.toMap());

  // Add any Firestore field values
  clientDto.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClientDtoListFirestoreData(
  List<ClientDtoStruct>? clientDtos,
) =>
    clientDtos?.map((e) => getClientDtoFirestoreData(e, true)).toList() ?? [];
