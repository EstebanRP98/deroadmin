// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServiceDtoStruct extends FFFirebaseStruct {
  ServiceDtoStruct({
    String? idService,
    String? nameService,
    int? minutesService,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _idService = idService,
        _nameService = nameService,
        _minutesService = minutesService,
        super(firestoreUtilData);

  // "id_service" field.
  String? _idService;
  String get idService => _idService ?? '';
  set idService(String? val) => _idService = val;
  bool hasIdService() => _idService != null;

  // "name_service" field.
  String? _nameService;
  String get nameService => _nameService ?? '';
  set nameService(String? val) => _nameService = val;
  bool hasNameService() => _nameService != null;

  // "minutes_service" field.
  int? _minutesService;
  int get minutesService => _minutesService ?? 0;
  set minutesService(int? val) => _minutesService = val;
  void incrementMinutesService(int amount) =>
      _minutesService = minutesService + amount;
  bool hasMinutesService() => _minutesService != null;

  static ServiceDtoStruct fromMap(Map<String, dynamic> data) =>
      ServiceDtoStruct(
        idService: data['id_service'] as String?,
        nameService: data['name_service'] as String?,
        minutesService: castToType<int>(data['minutes_service']),
      );

  static ServiceDtoStruct? maybeFromMap(dynamic data) => data is Map
      ? ServiceDtoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id_service': _idService,
        'name_service': _nameService,
        'minutes_service': _minutesService,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id_service': serializeParam(
          _idService,
          ParamType.String,
        ),
        'name_service': serializeParam(
          _nameService,
          ParamType.String,
        ),
        'minutes_service': serializeParam(
          _minutesService,
          ParamType.int,
        ),
      }.withoutNulls;

  static ServiceDtoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServiceDtoStruct(
        idService: deserializeParam(
          data['id_service'],
          ParamType.String,
          false,
        ),
        nameService: deserializeParam(
          data['name_service'],
          ParamType.String,
          false,
        ),
        minutesService: deserializeParam(
          data['minutes_service'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ServiceDtoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ServiceDtoStruct &&
        idService == other.idService &&
        nameService == other.nameService &&
        minutesService == other.minutesService;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([idService, nameService, minutesService]);
}

ServiceDtoStruct createServiceDtoStruct({
  String? idService,
  String? nameService,
  int? minutesService,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ServiceDtoStruct(
      idService: idService,
      nameService: nameService,
      minutesService: minutesService,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ServiceDtoStruct? updateServiceDtoStruct(
  ServiceDtoStruct? serviceDto, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    serviceDto
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addServiceDtoStructData(
  Map<String, dynamic> firestoreData,
  ServiceDtoStruct? serviceDto,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (serviceDto == null) {
    return;
  }
  if (serviceDto.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && serviceDto.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final serviceDtoData = getServiceDtoFirestoreData(serviceDto, forFieldValue);
  final nestedData = serviceDtoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = serviceDto.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getServiceDtoFirestoreData(
  ServiceDtoStruct? serviceDto, [
  bool forFieldValue = false,
]) {
  if (serviceDto == null) {
    return {};
  }
  final firestoreData = mapToFirestore(serviceDto.toMap());

  // Add any Firestore field values
  serviceDto.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getServiceDtoListFirestoreData(
  List<ServiceDtoStruct>? serviceDtos,
) =>
    serviceDtos?.map((e) => getServiceDtoFirestoreData(e, true)).toList() ?? [];
