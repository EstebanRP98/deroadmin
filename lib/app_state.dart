import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  DocumentReference? _comboBoxVenture;
  DocumentReference? get comboBoxVenture => _comboBoxVenture;
  set comboBoxVenture(DocumentReference? _value) {
    _comboBoxVenture = _value;
  }

  List<ScheduleDtoStruct> _listScheduledApp = [];
  List<ScheduleDtoStruct> get listScheduledApp => _listScheduledApp;
  set listScheduledApp(List<ScheduleDtoStruct> _value) {
    _listScheduledApp = _value;
  }

  void addToListScheduledApp(ScheduleDtoStruct _value) {
    _listScheduledApp.add(_value);
  }

  void removeFromListScheduledApp(ScheduleDtoStruct _value) {
    _listScheduledApp.remove(_value);
  }

  void removeAtIndexFromListScheduledApp(int _index) {
    _listScheduledApp.removeAt(_index);
  }

  void updateListScheduledAppAtIndex(
    int _index,
    ScheduleDtoStruct Function(ScheduleDtoStruct) updateFn,
  ) {
    _listScheduledApp[_index] = updateFn(_listScheduledApp[_index]);
  }

  void insertAtIndexInListScheduledApp(int _index, ScheduleDtoStruct _value) {
    _listScheduledApp.insert(_index, _value);
  }

  String _ventureUUid = '';
  String get ventureUUid => _ventureUUid;
  set ventureUUid(String _value) {
    _ventureUUid = _value;
  }

  ScheduleDtoStruct _selectedScheduled = ScheduleDtoStruct();
  ScheduleDtoStruct get selectedScheduled => _selectedScheduled;
  set selectedScheduled(ScheduleDtoStruct _value) {
    _selectedScheduled = _value;
  }

  void updateSelectedScheduledStruct(Function(ScheduleDtoStruct) updateFn) {
    updateFn(_selectedScheduled);
  }

  int _hourHeight = 100;
  int get hourHeight => _hourHeight;
  set hourHeight(int _value) {
    _hourHeight = _value;
  }

  bool _trueValue = true;
  bool get trueValue => _trueValue;
  set trueValue(bool _value) {
    _trueValue = _value;
  }

  DateTime? _selectedDay = DateTime.fromMillisecondsSinceEpoch(1708054320000);
  DateTime? get selectedDay => _selectedDay;
  set selectedDay(DateTime? _value) {
    _selectedDay = _value;
  }

  DateTime? _selectedDayIndicator =
      DateTime.fromMillisecondsSinceEpoch(1708054380000);
  DateTime? get selectedDayIndicator => _selectedDayIndicator;
  set selectedDayIndicator(DateTime? _value) {
    _selectedDayIndicator = _value;
  }

  List<RangesStruct> _listRanges = [];
  List<RangesStruct> get listRanges => _listRanges;
  set listRanges(List<RangesStruct> _value) {
    _listRanges = _value;
  }

  void addToListRanges(RangesStruct _value) {
    _listRanges.add(_value);
  }

  void removeFromListRanges(RangesStruct _value) {
    _listRanges.remove(_value);
  }

  void removeAtIndexFromListRanges(int _index) {
    _listRanges.removeAt(_index);
  }

  void updateListRangesAtIndex(
    int _index,
    RangesStruct Function(RangesStruct) updateFn,
  ) {
    _listRanges[_index] = updateFn(_listRanges[_index]);
  }

  void insertAtIndexInListRanges(int _index, RangesStruct _value) {
    _listRanges.insert(_index, _value);
  }

  VentureTimeStruct _ventureTimeCache = VentureTimeStruct();
  VentureTimeStruct get ventureTimeCache => _ventureTimeCache;
  set ventureTimeCache(VentureTimeStruct _value) {
    _ventureTimeCache = _value;
  }

  void updateVentureTimeCacheStruct(Function(VentureTimeStruct) updateFn) {
    updateFn(_ventureTimeCache);
  }

  int _numHours = 24;
  int get numHours => _numHours;
  set numHours(int _value) {
    _numHours = _value;
  }

  int _hourInitCalendar = 0;
  int get hourInitCalendar => _hourInitCalendar;
  set hourInitCalendar(int _value) {
    _hourInitCalendar = _value;
  }

  dynamic _getEventJson = jsonDecode('{\"events\":[]}');
  dynamic get getEventJson => _getEventJson;
  set getEventJson(dynamic _value) {
    _getEventJson = _value;
  }

  Color _randomColor = Colors.transparent;
  Color get randomColor => _randomColor;
  set randomColor(Color _value) {
    _randomColor = _value;
  }

  List<ServiceDtoStruct> _listServiceDto = [];
  List<ServiceDtoStruct> get listServiceDto => _listServiceDto;
  set listServiceDto(List<ServiceDtoStruct> _value) {
    _listServiceDto = _value;
  }

  void addToListServiceDto(ServiceDtoStruct _value) {
    _listServiceDto.add(_value);
  }

  void removeFromListServiceDto(ServiceDtoStruct _value) {
    _listServiceDto.remove(_value);
  }

  void removeAtIndexFromListServiceDto(int _index) {
    _listServiceDto.removeAt(_index);
  }

  void updateListServiceDtoAtIndex(
    int _index,
    ServiceDtoStruct Function(ServiceDtoStruct) updateFn,
  ) {
    _listServiceDto[_index] = updateFn(_listServiceDto[_index]);
  }

  void insertAtIndexInListServiceDto(int _index, ServiceDtoStruct _value) {
    _listServiceDto.insert(_index, _value);
  }
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
