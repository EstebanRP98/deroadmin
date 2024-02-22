import '/calendar/overlapping_events_row/overlapping_events_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'events_model.dart';
export 'events_model.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({
    super.key,
    this.height,
    required this.listEvents,
  });

  final int? height;
  final dynamic listEvents;

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  late EventsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventsModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: widget.height?.toDouble(),
          decoration: BoxDecoration(),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 0.0, 0.0),
              child: Builder(
                builder: (context) {
                  final overlappingEvents = functions
                      .insertBlankRows(
                          functions
                              .rowsFromEvents(
                                  widget.listEvents!, FFAppState().selectedDay!)
                              .toList(),
                          FFAppState().selectedDay!,
                          FFAppState().hourInitCalendar)
                      .toList();
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(overlappingEvents.length,
                        (overlappingEventsIndex) {
                      final overlappingEventsItem =
                          overlappingEvents[overlappingEventsIndex];
                      return Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: OverlappingEventsRowWidget(
                          key: Key(
                              'Keyl76_${overlappingEventsIndex}_of_${overlappingEvents.length}'),
                          overlappingEvents: overlappingEventsItem,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
