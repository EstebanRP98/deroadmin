import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Dero Apis Group Code

class DeroApisGroup {
  static String baseUrl = 'https://deroappec.com';
  static Map<String, String> headers = {};
  static DeroGetCall deroGetCall = DeroGetCall();
  static GetScheduledCall getScheduledCall = GetScheduledCall();
  static PostScheduledCall postScheduledCall = PostScheduledCall();
  static PruebaCall pruebaCall = PruebaCall();
  static PruebaLolCall pruebaLolCall = PruebaLolCall();
  static PruebaiiiCall pruebaiiiCall = PruebaiiiCall();
  static GetTimeVentureCall getTimeVentureCall = GetTimeVentureCall();
  static GetCalendarVentureCall getCalendarVentureCall =
      GetCalendarVentureCall();
}

class DeroGetCall {
  Future<ApiCallResponse> call({
    String? bearer = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'dero get',
      apiUrl: '${DeroApisGroup.baseUrl}/book',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearer}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetScheduledCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    String? date = '',
    String? status = '',
    String? ventureId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get scheduled',
      apiUrl:
          '${DeroApisGroup.baseUrl}/myapp/schedule-venture/?date=23/01/2024&status=Active&venture_id=IxILhkqbarViwQhGadWl',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'date': date,
        'status': status,
        'venture_id': ventureId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostScheduledCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    dynamic? scheduleJson,
  }) async {
    final schedule = _serializeJson(scheduleJson);
    final ffApiRequestBody = '''
${schedule}''';
    return ApiManager.instance.makeApiCall(
      callName: 'post scheduled',
      apiUrl: '${DeroApisGroup.baseUrl}/myapp/save-schedule-venture/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class PruebaCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'prueba',
      apiUrl: '${DeroApisGroup.baseUrl}/health',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PruebaLolCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'prueba lol',
      apiUrl: '${DeroApisGroup.baseUrl}/health',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PruebaiiiCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'pruebaiii',
      apiUrl: '${DeroApisGroup.baseUrl}/health',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTimeVentureCall {
  Future<ApiCallResponse> call({
    String? ventureUuid = '',
    String? day = '',
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getTimeVenture',
      apiUrl: '${DeroApisGroup.baseUrl}/myapp/get-time-venture/${ventureUuid}/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'day': day,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCalendarVentureCall {
  Future<ApiCallResponse> call({
    String? ventureUuid = '',
    String? date = '',
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getCalendarVenture',
      apiUrl: '${DeroApisGroup.baseUrl}/myapp/schedule-venture/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'date': date,
        'venture_id': ventureUuid,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Dero Apis Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
