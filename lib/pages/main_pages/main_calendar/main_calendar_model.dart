import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/calendar/background/background_widget.dart';
import '/calendar/events/events_widget.dart';
import '/calendar/now_line/now_line_widget.dart';
import '/calendar/week_days/week_days_widget.dart';
import '/components/modals/modal_message/modal_message_widget.dart';
import '/components/modals_extra/create_admin_calendar/create_admin_calendar_widget.dart';
import '/components/web_nav/web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'main_calendar_widget.dart' show MainCalendarWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainCalendarModel extends FlutterFlowModel<MainCalendarWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (get scheduled)] action in Main_Calendar widget.
  ApiCallResponse? getCalendarAPI;
  // Model for webNav component.
  late WebNavModel webNavModel;
  // State field(s) for ScrollableColumn widget.
  ScrollController? scrollableColumn;
  // Model for Background component.
  late BackgroundModel backgroundModel;
  // Model for NowLine component.
  late NowLineModel nowLineModel;
  // Model for Events component.
  late EventsModel eventsModel;
  // Stores action output result for [Backend Call - API (get scheduled)] action in IconButton widget.
  ApiCallResponse? getCalendarDayActualAPI;
  // Model for WeekDays component.
  late WeekDaysModel weekDaysModel;
  // Stores action output result for [Backend Call - API (get scheduled)] action in WeekDays widget.
  ApiCallResponse? getCalendarDayAPI;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    webNavModel = createModel(context, () => WebNavModel());
    scrollableColumn = ScrollController();
    backgroundModel = createModel(context, () => BackgroundModel());
    nowLineModel = createModel(context, () => NowLineModel());
    eventsModel = createModel(context, () => EventsModel());
    weekDaysModel = createModel(context, () => WeekDaysModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    webNavModel.dispose();
    scrollableColumn?.dispose();
    backgroundModel.dispose();
    nowLineModel.dispose();
    eventsModel.dispose();
    weekDaysModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
