import 'dart:async';
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
        size: Size(80, 80),
      ),
    );
  }

  Future<ui.Image> _generateQRImage(QrPainter paintedQR) async {
    ByteBuffer byteBuffer =
        await paintedQR.toImageData(687).then((value) => value.buffer);
    return await loadUIImage(Uint8List.view(byteBuffer));
  }

  Future<ui.Image> getImageFromURL(String url) async {
    Completer<ImageInfo> completer = Completer();
    var img = new NetworkImage(url);
    img
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Future<ui.Image> _generateProfileImage(String url) async {
    final profileSize = 274.0;

    final profileImage = await getImageFromURL(url);

    final recorder = ui.PictureRecorder();
    final canvas = _createCanvas(recorder);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, profileSize, profileSize),
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill
        ..strokeWidth = 7,
    );

    canvas.drawImageRect(
      profileImage,
      Rect.fromCenter(
        center: Offset(profileImage.width / 2, profileImage.height / 2),
        width: (profileImage.height > profileImage.width
                ? profileImage.height
                : profileImage.width)
            .toDouble(),
        height: (profileImage.height > profileImage.width
                ? profileImage.height
                : profileImage.width)
            .toDouble(),
      ),
      Rect.fromLTWH(0, 0, profileSize, profileSize),
      Paint(),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(
        _imageSize.width.toInt(), _imageSize.height.toInt());
    final data = await image.toByteData(format: ImageByteFormat.png);
    return await loadUIImage(Uint8List.view(data.buffer));
  }

  void _writeIndividualDetail({
    @required Canvas canvas,
    @required String name,
    @required String displayId,
    @required String address,
    @required String number,
  }) {
    final labelXOffset = 605.0;
    final maxWidth = 380.0;

    final textPainterName = TextPainter(
      text: TextSpan(
        text: name.toUpperCase(),
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          // backgroundColor: Colors.black
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
    textPainterName.paint(
      canvas,
      Offset(
        labelXOffset,
        115 - (textPainterName.height / 2),
      ),
    );

    final textPainterCode = TextPainter(
      text: TextSpan(
        text: displayId.toUpperCase(),
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          // backgroundColor: Colors.black
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
    textPainterCode.paint(
      canvas,
      Offset(
        labelXOffset,
        200,
      ),
    );

    final textPainterAddress = TextPainter(
      text: TextSpan(
        text: "$address ".toUpperCase(),
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
    textPainterAddress.paint(
      canvas,
      Offset(labelXOffset, 287),
    );

    final textPainterNumber = TextPainter(
      text: TextSpan(
        text: "0$number",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );

    textPainterNumber.paint(
      canvas,
      Offset(
        labelXOffset,
        325,
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
    final profileImage = await _generateProfileImage(user.profileImageUrl);

    final recorder = ui.PictureRecorder();
    final canvas = _createCanvas(recorder);

    canvas.drawImage(profileImage, Offset(228.0, 183.0), Paint());
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
      name: user.fullName,
      displayId: user.displayId,
      address:
          "${user.address.brgyName}, ${user.address.citymunName}, ${user.address.provName}",
      number: user.contactNumber,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(
        _imageSize.width.toInt(), _imageSize.height.toInt());
    return await image.toByteData(format: ImageByteFormat.png);
  }
}
