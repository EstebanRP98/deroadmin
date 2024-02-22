import '/calendar/day_picker/day_picker_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'week_days_model.dart';
export 'week_days_model.dart';

class WeekDaysWidget extends StatefulWidget {
  const WeekDaysWidget({
    super.key,
    this.callback,
  });

  final Future Function()? callback;

  @override
  State<WeekDaysWidget> createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget>
    with TickerProviderStateMixin {
  late WeekDaysModel _model;

  final animationsMap = {
    'rowOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeekDaysModel());

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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        final day = functions
            .generateSurroundingDays(FFAppState().selectedDay)
            .toList();
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(day.length, (dayIndex) {
            final dayItem = day[dayIndex];
            return Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('WEEK_DAYS_COMP_Container_ukouqdrc_ON_TAP');
                  if (dayItem != FFAppState().selectedDay) {
                    setState(() {
                      FFAppState().selectedDayIndicator =
                          FFAppState().selectedDay;
                    });
                    await Future.delayed(const Duration(milliseconds: 200));
                    setState(() {
                      FFAppState().selectedDay = dayItem;
                    });
                    await widget.callback?.call();
                  }
                },
                child: DayPickerWidget(
                  key: Key('Keyuko_${dayIndex}_of_${day.length}'),
                  day: getJsonField(
                    functions.dateInfo(dayItem),
                    r'''$.day''',
                  ),
                  weekday: getJsonField(
                    functions.dateInfo(dayItem),
                    r'''$.weekday''',
                  ).toString(),
                  selected: dayItem == FFAppState().selectedDay,
                  tapped: dayItem == FFAppState().selectedDayIndicator,
                ),
              ),
            );
          }),
        ).animateOnActionTrigger(
          animationsMap['rowOnActionTriggerAnimation']!,
        );
      },
    );
  }
}
