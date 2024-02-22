import '/calendar/event/event_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'overlapping_events_row_model.dart';
export 'overlapping_events_row_model.dart';

class OverlappingEventsRowWidget extends StatefulWidget {
  const OverlappingEventsRowWidget({
    super.key,
    this.overlappingEvents,
  });

  final dynamic overlappingEvents;

  @override
  State<OverlappingEventsRowWidget> createState() =>
      _OverlappingEventsRowWidgetState();
}

class _OverlappingEventsRowWidgetState
    extends State<OverlappingEventsRowWidget> {
  late OverlappingEventsRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OverlappingEventsRowModel());

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

    return ClipRRect(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: functions
            .overlappingDuration(
                widget.overlappingEvents, FFAppState().hourHeight)
            .toDouble(),
        decoration: BoxDecoration(),
        child: Builder(
          builder: (context) {
            final event =
                (widget.overlappingEvents?.toList() ?? []).take(5).toList();
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(event.length, (eventIndex) {
                final eventItem = event[eventIndex];
                return Visibility(
                  visible: EventStruct.maybeFromMap(eventItem)?.visible == true,
                  child: Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: EventWidget(
                          key: Key('Keyozk_${eventIndex}_of_${event.length}'),
                          start: functions.startOffset(widget.overlappingEvents,
                              FFAppState().hourHeight, eventItem),
                          duration: functions.eventDuration(
                              eventItem, FFAppState().hourHeight),
                          title: getJsonField(
                            eventItem,
                            r'''$.title''',
                          ).toString(),
                          color: colorFromCssString(
                            getJsonField(
                              eventItem,
                              r'''$.color''',
                            ).toString(),
                            defaultColor: FlutterFlowTheme.of(context).tertiary,
                          ),
                          description: getJsonField(
                            eventItem,
                            r'''$.description''',
                          ).toString(),
                          alert: getJsonField(
                            eventItem,
                            r'''$.alert''',
                          ).toString(),
                          location: getJsonField(
                            eventItem,
                            r'''$.location''',
                          ).toString(),
                          attendees: getJsonField(
                            eventItem,
                            r'''$.guests''',
                          ),
                          startTimestamp:
                              functions.timestampFromString(getJsonField(
                            eventItem,
                            r'''$.start_time''',
                          ).toString()),
                          endTimestamp:
                              functions.timestampFromString(getJsonField(
                            eventItem,
                            r'''$.end_time''',
                          ).toString()),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
