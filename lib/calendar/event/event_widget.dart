import '/calendar/event_details/event_details_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'event_model.dart';
export 'event_model.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    this.start,
    this.duration,
    this.title,
    this.color,
    this.attendees,
    this.description,
    this.startTimestamp,
    this.endTimestamp,
    this.alert,
    this.location,
  });

  final int? start;
  final int? duration;
  final String? title;
  final Color? color;
  final dynamic attendees;
  final String? description;
  final DateTime? startTimestamp;
  final DateTime? endTimestamp;
  final String? alert;
  final String? location;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  late EventModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      constraints: BoxConstraints(
        maxHeight: functions.add(widget.start!, widget.duration!).toDouble(),
      ),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: widget.start?.toDouble(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('EVENT_COMP_EventTile_ON_TAP');
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Color(0x00000000),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: EventDetailsWidget(
                      attendees: widget.attendees,
                      title: widget.title,
                      description: widget.description,
                      start: widget.startTimestamp,
                      end: widget.endTimestamp,
                      alert: widget.alert,
                      color: widget.color,
                      location: widget.location,
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: widget.duration?.toDouble(),
                constraints: BoxConstraints(
                  maxWidth: 250.0,
                ),
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget.color,
                    Color(0xFFCAD2C5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (widget.duration! > 40)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    widget.title!,
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 14.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          if (widget.duration! > 50)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${dateTimeFormat(
                                      'jm',
                                      widget.startTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )} - ${dateTimeFormat(
                                      'jm',
                                      widget.endTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )}',
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      if (widget.duration! > 100)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100.0,
                              child: Stack(
                                children: [
                                  if (getJsonField(
                                        widget.attendees,
                                        r'''$[0]''',
                                      ) !=
                                      null)
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            getJsonField(
                                              widget.attendees,
                                              r'''$[0].img''',
                                            ).toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (getJsonField(
                                        widget.attendees,
                                        r'''$[1]''',
                                      ) !=
                                      null)
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.45, 0.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              getJsonField(
                                                widget.attendees,
                                                r'''$[1].img''',
                                              ).toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (getJsonField(
                                        widget.attendees,
                                        r'''$[2]''',
                                      ) !=
                                      null)
                                    Align(
                                      alignment: AlignmentDirectional(0.1, 0.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              getJsonField(
                                                widget.attendees,
                                                r'''$[2].img''',
                                              ).toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
