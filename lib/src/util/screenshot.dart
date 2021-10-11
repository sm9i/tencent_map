///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 07/30/21 5:29 PM
///
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Create an image from given [GlobalKey], which is attached to an exist
/// [RepaintBoundary].
///
/// [imageSize] can define what size the generated image will be (in pixels).
Future<Uint8List?> createImageFromRepaintBoundary(
    GlobalKey boundaryKey, {
      double? pixelRatio,
      Size? imageSize,
    }) async {
  assert(
  boundaryKey.currentContext?.findRenderObject() is RenderRepaintBoundary,
  );
  final RenderRepaintBoundary boundary =
  boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
  final BoxConstraints constraints = boundary.constraints;
  double? outputRatio = pixelRatio;
  if (imageSize != null) {
    outputRatio = imageSize.width / constraints.maxWidth;
  }
  final ui.Image image = await boundary.toImage(
    pixelRatio:
    outputRatio ?? MediaQueryData.fromWindow(ui.window).devicePixelRatio,
  );
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  final Uint8List? imageData = byteData?.buffer.asUint8List();
  return imageData;
}

/// Creates an image from the given widget by first spinning up a element and
/// render tree, then waiting for the given [wait] amount of time and then
/// creating an image via a [RepaintBoundary].
///
/// The final image will be of size [imageSize] and the the widget will be
/// layout, with the given [logicalSize].
Future<Uint8List?> createImageFromWidget(
    Widget widget, {
      Duration? wait,
      Size? logicalSize,
      Size? imageSize,
    }) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
  imageSize ??= ui.window.physicalSize;

  final RenderView renderView = RenderView(
    window: ui.window,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
    configuration: ViewConfiguration(size: logicalSize, devicePixelRatio: 1),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement =
  RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: widget,
    ),
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  if (wait != null) {
    await Future<void>.delayed(wait);
  }

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(
    pixelRatio: imageSize.width / logicalSize.width,
  );
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  return byteData?.buffer.asUint8List();
}