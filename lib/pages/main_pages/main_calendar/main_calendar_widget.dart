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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_calendar_model.dart';
export 'main_calendar_model.dart';

class MainCalendarWidget extends StatefulWidget {
  const MainCalendarWidget({super.key});

  @override
  State<MainCalendarWidget> createState() => _MainCalendarWidgetState();
}

class _MainCalendarWidgetState extends State<MainCalendarWidget>
    with TickerProviderStateMixin {
  late MainCalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'eventsOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.elasticOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(47.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainCalendarModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Main_Calendar'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MAIN_CALENDAR_Main_Calendar_ON_INIT_STAT');
      setState(() {
        FFAppState().selectedDay = getCurrentTimestamp;
      });
      if (animationsMap['eventsOnActionTriggerAnimation'] != null) {
        await animationsMap['eventsOnActionTriggerAnimation']!
            .controller
            .forward(from: 0.0);
      }
      _model.getCalendarAPI = await DeroApisGroup.getScheduledCall.call(
        status: 'ACEPTADO',
        ventureId: FFAppState().ventureUUid,
        date: dateTimeFormat(
          'd/M/y',
          FFAppState().selectedDay,
          locale: FFLocalizations.of(context).languageCode,
        ),
      );
      if ((_model.getCalendarAPI?.succeeded ?? true)) {
        setState(() {
          FFAppState().listScheduledApp = ScheduleListDtoStruct.maybeFromMap(
                  (_model.getCalendarAPI?.jsonBody ?? ''))!
              .events
              .toList()
              .cast<ScheduleDtoStruct>();
          FFAppState().getEventJson = (_model.getCalendarAPI?.jsonBody ?? '');
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'ok',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 1350),
            backgroundColor: FlutterFlowTheme.of(context).primary,
          ),
        );
      } else {
        if ((_model.getCalendarAPI?.statusCode ?? 200) == 503) {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: ModalMessageWidget(
                    titulo: 'Oh! Tenemos Problemas',
                    mensaje:
                        'Estamos teniendo inconvenientes, vuelve a intentarlo mas tarde.',
                    color: FlutterFlowTheme.of(context).error,
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        } else {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: ModalMessageWidget(
                    titulo: 'Oh! Ocurrio un error',
                    mensaje: 'Tenemos problemas para encontrar tu infromacion.',
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            logFirebaseEvent('MAIN_CALENDAR_FloatingActionButton_uhzfu');
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: CreateAdminCalendarWidget(),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
        appBar: !isWeb
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                title: Text(
                  FFLocalizations.of(context).getText(
                    'brs1tx0v' /* Contracts */,
                  ),
                  style: FlutterFlowTheme.of(context).displaySmall,
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    wrapWithModel(
                      model: _model.webNavModel,
                      updateCallback: () => setState(() {}),
                      child: WebNavWidget(
                        selectedNav: 3,
                      ),
                    ),
                  Expanded(
                    child: Container(
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 235.0, 0.0, 0.0),
                            child: SingleChildScrollView(
                              controller: _model.scrollableColumn,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.backgroundModel,
                                          updateCallback: () => setState(() {}),
                                          child: BackgroundWidget(
                                            height: functions.multiply(
                                                FFAppState().hourHeight,
                                                FFAppState().numHours),
                                            ranges: FFAppState().listRanges,
                                          ),
                                        ),
                                      ),
                                      if (dateTimeFormat(
                                            'd/M/y',
                                            FFAppState().selectedDay,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ) ==
                                          dateTimeFormat(
                                            'd/M/y',
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ))
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.9,
                                          decoration: BoxDecoration(),
                                          child: wrapWithModel(
                                            model: _model.nowLineModel,
                                            updateCallback: () =>
                                                setState(() {}),
                                            child: NowLineWidget(
                                              height: functions.nowHeight(
                                                  FFAppState().hourHeight),
                                            ),
                                          ),
                                        ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 15.0, 0.0, 0.0),
                                            child: wrapWithModel(
                                              model: _model.eventsModel,
                                              updateCallback: () =>
                                                  setState(() {}),
                                              child: EventsWidget(
                                                height: functions.multiply(
                                                    FFAppState().hourHeight,
                                                    valueOrDefault<int>(
                                                      FFAppState().numHours,
                                                      24,
                                                    )),
                                                listEvents:
                                                    FFAppState().getEventJson,
                                              ),
                                            ).animateOnActionTrigger(
                                              animationsMap[
                                                  'eventsOnActionTriggerAnimation']!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 235.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 6.0),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 35.0,
                                        height: 35.0,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Container(
                                                  width: 35.0,
                                                  height: 35.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    currentUserPhoto,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'MAIN_CALENDAR_calendar_today_ICN_ON_TAP');
                                          FFAppState().update(() {
                                            FFAppState().selectedDay =
                                                getCurrentTimestamp;
                                          });
                                          if (animationsMap[
                                                  'eventsOnActionTriggerAnimation'] !=
                                              null) {
                                            await animationsMap[
                                                    'eventsOnActionTriggerAnimation']!
                                                .controller
                                                .forward(from: 0.0);
                                          }
                                          _model.getCalendarDayActualAPI =
                                              await DeroApisGroup
                                                  .getScheduledCall
                                                  .call(
                                            status: 'ACEPTADO',
                                            ventureId: FFAppState().ventureUUid,
                                            date: dateTimeFormat(
                                              'd/M/y',
                                              FFAppState().selectedDay,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                          );
                                          if ((_model.getCalendarDayActualAPI
                                                  ?.succeeded ??
                                              true)) {
                                            setState(() {
                                              FFAppState().listScheduledApp =
                                                  ScheduleListDtoStruct
                                                          .maybeFromMap((_model
                                                                  .getCalendarDayActualAPI
                                                                  ?.jsonBody ??
                                                              ''))!
                                                      .events
                                                      .toList()
                                                      .cast<
                                                          ScheduleDtoStruct>();
                                              FFAppState()
                                                  .getEventJson = (_model
                                                      .getCalendarDayActualAPI
                                                      ?.jsonBody ??
                                                  '');
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'ok',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 1250),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            );
                                          } else {
                                            if ((_model.getCalendarDayActualAPI
                                                        ?.statusCode ??
                                                    200) ==
                                                503) {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: ModalMessageWidget(
                                                        titulo:
                                                            'Oh! Tenemos Problemas',
                                                        mensaje:
                                                            'Estamos teniendo inconvenientes, vuelve a intentarlo mas tarde.',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            } else {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: ModalMessageWidget(
                                                        titulo:
                                                            'Oh! Ocurrio un error',
                                                        mensaje:
                                                            'Tenemos problemas para encontrar tu infromacion.',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            }
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SelectionArea(
                                            child: Text(
                                          getJsonField(
                                            functions.dateInfo(
                                                FFAppState().selectedDay!),
                                            r'''$.month''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0x7A57636C),
                                                fontSize: 32.0,
                                              ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 30.0),
                                      child: wrapWithModel(
                                        model: _model.weekDaysModel,
                                        updateCallback: () => setState(() {}),
                                        child: WeekDaysWidget(
                                          callback: () async {
                                            logFirebaseEvent(
                                                'MAIN_CALENDAR_Container_pq0no8em_CALLBAC');
                                            setState(() {
                                              FFAppState().selectedDay =
                                                  FFAppState().selectedDay;
                                            });
                                            if (animationsMap[
                                                    'eventsOnActionTriggerAnimation'] !=
                                                null) {
                                              await animationsMap[
                                                      'eventsOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                            _model.getCalendarDayAPI =
                                                await DeroApisGroup
                                                    .getScheduledCall
                                                    .call(
                                              status: 'ACEPTADO',
                                              ventureId:
                                                  FFAppState().ventureUUid,
                                              date: dateTimeFormat(
                                                'd/M/y',
                                                FFAppState().selectedDay,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                            );
                                            if ((_model.getCalendarDayAPI
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {
                                                FFAppState().listScheduledApp =
                                                    ScheduleListDtoStruct
                                                            .maybeFromMap((_model
                                                                    .getCalendarDayAPI
                                                                    ?.jsonBody ??
                                                                ''))!
                                                        .events
                                                        .toList()
                                                        .cast<
                                                            ScheduleDtoStruct>();
                                                FFAppState().getEventJson =
                                                    (_model.getCalendarDayAPI
                                                            ?.jsonBody ??
                                                        '');
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'ok',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 1250),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                ),
                                              );
                                            } else {
                                              if ((_model.getCalendarDayAPI
                                                          ?.statusCode ??
                                                      200) ==
                                                  503) {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => _model
                                                              .unfocusNode
                                                              .canRequestFocus
                                                          ? FocusScope.of(
                                                                  context)
                                                              .requestFocus(_model
                                                                  .unfocusNode)
                                                          : FocusScope.of(
                                                                  context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            ModalMessageWidget(
                                                          titulo:
                                                              'Oh! Tenemos Problemas',
                                                          mensaje:
                                                              'Estamos teniendo inconvenientes, vuelve a intentarlo mas tarde.',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              } else {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => _model
                                                              .unfocusNode
                                                              .canRequestFocus
                                                          ? FocusScope.of(
                                                                  context)
                                                              .requestFocus(_model
                                                                  .unfocusNode)
                                                          : FocusScope.of(
                                                                  context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            ModalMessageWidget(
                                                          titulo:
                                                              'Oh! Ocurrio un error',
                                                          mensaje:
                                                              'Tenemos problemas para encontrar tu infromacion.',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              }
                                            }

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 15.0),
                                      child: Stack(
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              Icons.arrow_downward,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'MAIN_CALENDAR_arrow_downward_ICN_ON_TAP');
                                              await _model.scrollableColumn
                                                  ?.animateTo(
                                                _model.scrollableColumn!
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                curve: Curves.ease,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.85, 0.95),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 4.0,
                                  sigmaY: 4.0,
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .overlayWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        borderWidth: 1.0,
                                        buttonSize: 50.0,
                                        icon: FaIcon(
                                          FontAwesomeIcons.minus,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 10.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'MAIN_CALENDAR_PAGE_minus_ICN_ON_TAP');
                                          FFAppState().update(() {
                                            FFAppState().hourHeight =
                                                FFAppState().hourHeight + -10;
                                          });
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        borderWidth: 1.0,
                                        buttonSize: 50.0,
                                        icon: Icon(
                                          Icons.add,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 15.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'MAIN_CALENDAR_PAGE_add_ICN_ON_TAP');
                                          FFAppState().update(() {
                                            FFAppState().hourHeight =
                                                FFAppState().hourHeight + 10;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
