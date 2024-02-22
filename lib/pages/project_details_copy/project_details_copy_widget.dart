import '/backend/backend.dart';
import '/components/modal_sections/project_details_alt/project_details_alt_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'project_details_copy_model.dart';
export 'project_details_copy_model.dart';

class ProjectDetailsCopyWidget extends StatefulWidget {
  const ProjectDetailsCopyWidget({
    super.key,
    required this.calendar,
    required this.venture,
  });

  final CalendarRecord? calendar;
  final VentureRecord? venture;

  @override
  State<ProjectDetailsCopyWidget> createState() =>
      _ProjectDetailsCopyWidgetState();
}

class _ProjectDetailsCopyWidgetState extends State<ProjectDetailsCopyWidget> {
  late ProjectDetailsCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProjectDetailsCopyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'projectDetailsCopy'});
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('PROJECT_DETAILS_COPY_arrow_back_rounded_');
              context.pop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.projectDetailsAltModel,
            updateCallback: () => setState(() {}),
            child: ProjectDetailsAltWidget(
              calendar: widget.calendar!,
              venture: widget.venture!,
            ),
          ),
        ),
      ),
    );
  }
}
