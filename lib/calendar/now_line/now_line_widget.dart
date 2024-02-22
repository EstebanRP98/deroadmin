import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'now_line_model.dart';
export 'now_line_model.dart';

class NowLineWidget extends StatefulWidget {
  const NowLineWidget({
    super.key,
    this.height,
  });

  final int? height;

  @override
  State<NowLineWidget> createState() => _NowLineWidgetState();
}

class _NowLineWidgetState extends State<NowLineWidget> {
  late NowLineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NowLineModel());

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
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.05,
              height: MediaQuery.sizeOf(context).width * 0.05,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: 2.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
