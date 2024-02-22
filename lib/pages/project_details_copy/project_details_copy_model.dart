import '/backend/backend.dart';
import '/components/modal_sections/project_details_alt/project_details_alt_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'project_details_copy_widget.dart' show ProjectDetailsCopyWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectDetailsCopyModel
    extends FlutterFlowModel<ProjectDetailsCopyWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for projectDetails_alt component.
  late ProjectDetailsAltModel projectDetailsAltModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    projectDetailsAltModel =
        createModel(context, () => ProjectDetailsAltModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    projectDetailsAltModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
