import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

class QRIDUtil {
  final Size _imageSize = Size(1013, 638);

  Future<ui.Image> _getFrontTemplateImage() async {
    final ByteData data =
        await rootBundle.load('assets/images/template/id-front.png');
    return await loadUIImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> _getBackTemplateImage() async {
    final ByteData data =
        await rootBundle.load('assets/images/template/id-back.png');
    return await loadUIImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> _getQRIcon() async {
    final ByteData data =
        await rootBundle.load('assets/images/app_icon/qr_icon.png');
    return await loadUIImage(Uint8List.view(data.buffer));
  }

  Canvas _createCanvas(ui.PictureRecorder recorder) {
    return Canvas(
      recorder,
      Rect.fromPoints(
        Offset(0.0, 0.0),
        Offset(_imageSize.width, _imageSize.height),
      ),
    );
  }

  QrPainter _paintQR(ui.Image qrIcon, String qrData) {
    return QrPainter(
      data: qrData,
      version: QrVersions.auto,
      embeddedImage: qrIcon,
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(70, 70),
      ),
    );
  }

  Future<ui.Image> _generateQRImage(QrPainter paintedQR) async {
    ByteBuffer byteBuffer =
        await paintedQR.toImageData(687).then((value) => value.buffer);
    return await loadUIImage(Uint8List.view(byteBuffer));
  }

  Future<ui.Image> _generateProfileImage(String url) async {
    final image = Image.network(url);
  }

  void _writeIndividualDetail({
    @required Canvas canvas,
    @required String name,
    @required String displayId,
    @required String designatedArea,
  }) {
    final textPainterName = TextPainter(
      text: TextSpan(
        text: name.toUpperCase(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          // backgroundColor: Colors.black
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 0,
        maxWidth: 573,
      );
    textPainterName.paint(
      canvas,
      Offset(
        225 + ((573 - textPainterName.width) / 2),
        995,
      ),
    );

    final textPainterCode = TextPainter(
      text: TextSpan(
        text: displayId.toUpperCase(),
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          // backgroundColor: Colors.black
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 0,
        maxWidth: 573,
      );
    textPainterCode.paint(
      canvas,
      Offset(
        225 + ((573 - textPainterCode.width) / 2),
        995 + textPainterName.height + 15,
      ),
    );

    final textPainterDesignatedArea = TextPainter(
      text: TextSpan(
        text: " $designatedArea ".toUpperCase(),
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          backgroundColor: Color(0xFFcedfe7),
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 0,
        maxWidth: 573,
      );
    textPainterDesignatedArea.paint(
      canvas,
      Offset(
        225 + ((573 - textPainterDesignatedArea.width) / 2),
        (995 + textPainterName.height + textPainterCode.height) + 30,
      ),
    );
  }

  Future<ByteData> generateFrontIDByteData() async {
    final templateImage = await _getFrontTemplateImage();

    final recorder = ui.PictureRecorder();
    final canvas = _createCanvas(recorder);

    canvas.drawImage(templateImage, Offset(0.0, 0.0), Paint());

    final picture = recorder.endRecording();
    final image = await picture.toImage(
        _imageSize.width.toInt(), _imageSize.height.toInt());
    return await image.toByteData(format: ImageByteFormat.png);
  }

  Future<ByteData> generateBackIDByteData({
    @required User user,
    @required String qrData,
  }) async {
    final templateImage = await _getBackTemplateImage();
    final qrIcon = await _getQRIcon();

    final recorder = ui.PictureRecorder();
    final canvas = _createCanvas(recorder);

    canvas.drawImage(templateImage, Offset(0.0, 0.0), Paint());

    final paintedQR = _paintQR(qrIcon, qrData);
    final qrImage = await _generateQRImage(paintedQR);

    canvas.drawImageRect(
      qrImage,
      Rect.fromLTWH(0, 0, qrImage.width.toDouble(), qrImage.height.toDouble()),
      Rect.fromLTWH(687, 407, 200, 200),
      Paint(),
    );

    _writeIndividualDetail(
      canvas: canvas,
      name: user.firstName,
      displayId: user.displayId,
      designatedArea: user.designatedArea,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(
        _imageSize.width.toInt(), _imageSize.height.toInt());
    return await image.toByteData(format: ImageByteFormat.png);
  }
}