import 'dart:convert';

import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/bar/custom_regular_app_bar_v2.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';

class ScanQrcodePage extends StatefulWidget {
  final String currentRole;
  ScanQrcodePage({Key key, this.currentRole}) : super(key: key);

  @override
  _ScanQrcodePageState createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage>
    with WidgetsBindingObserver {
  ScannerController _scannerController;

  bool _cameraPermissionGranted = false;
  bool _fromAppSettings = false;

  @override
  void initState() {
    _requestCameraPermission();
    _scannerController = ScannerController(
      scannerResult: (result) {
        _validateQrCode(result);
      },
      scannerViewCreated: () => _startScanning(),
    );

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_fromAppSettings) {
        _requestCameraPermission();
        _fromAppSettings = false;
      }
      _startCameraPreview();
    } else if (state == AppLifecycleState.paused) {
      _stopCameraPreview();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void deactivate() {
    super.deactivate();

    _toggleCameraPreview();
  }

  @override
  void dispose() {
    _stopScanning();
    _scannerController = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      setState(() => _cameraPermissionGranted = true);
    } else {
      setState(() => _cameraPermissionGranted = false);
    }
  }

  void _requestCameraPermissionLevel2() async {
    if (await Permission.camera.request().isGranted) {
      setState(() => _cameraPermissionGranted = true);
    } else {
      setState(() => _cameraPermissionGranted = false);

      if (await Permission.camera.isPermanentlyDenied) {
        _requestCameraPermissionFromAppSettings();
      }
    }
  }

  void _requestCameraPermissionFromAppSettings() async {
    _fromAppSettings = false;
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Radar needs to access your Camera"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "Please grant camera permission in App Settings.\n",
              ),
              Text(
                "To enable this feature, click App Settings below and enable camera under the Permissions menu.",
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("App Settings"),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
              _fromAppSettings = true;
            },
          )
        ],
      ),
    );
  }

  void _startScanning() {
    if (_cameraPermissionGranted) {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        Future.delayed(Duration(seconds: 1), () {
          _scannerController.startCamera();
          _scannerController.startCameraPreview();
        });
      } else {
        _scannerController.startCamera();
        _scannerController.startCameraPreview();
      }
    }
  }

  void _startCameraPreview() {
    if (_cameraPermissionGranted) {
      _scannerController.startCameraPreview();
    }
  }

  void _stopCameraPreview() {
    if (_cameraPermissionGranted) {
      _scannerController.stopCameraPreview();
    }
  }

  void _stopCamera() {
    if (_cameraPermissionGranted) {
      _scannerController.stopCamera();
    }
  }

  void _stopScanning() {
    _stopCameraPreview();
    _stopCamera();
  }

  bool _isFlashOpen() {
    if (_cameraPermissionGranted) {
      return _scannerController.isOpenFlash;
    } else {
      return false;
    }
  }

  void _toggleFlash() {
    if (_cameraPermissionGranted) {
      _scannerController.toggleFlash();
    }
  }

  _toggleCameraPreview() {
    if (_cameraPermissionGranted) {
      if (_scannerController.isStartCameraPreview) {
        _scannerController.stopCameraPreview();
      } else {
        _scannerController.startCameraPreview();
      }
    }
  }

  void _validateQrCode(String qrData) async {
    try {
      dynamic decrypted = await decryptAESCryptoJS(qrData);

      dynamic jsonDecrypt = jsonDecode(decrypted);

      User qrcode = UserMapper().fromMap(jsonDecrypt);
      if (widget.currentRole != qrcode.role) {
        if (qrcode.role == "individual") {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(
            USER_DETAILS_ROUTE,
            arguments: jsonDecrypt,
          );
        } else {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(
            ESTABLISHMENT_DETAILS_ROUTE,
            arguments: jsonDecrypt,
          );
        }
      } else{
        throw Exception("Feature not available.");
      }
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _userNotFoundDialog(e.message.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBarV2(
        backgroundColor: Colors.transparent,
        title: "Scan QR Code",
        body: _buildScannerView(),
      ),
    );
  }

  Container _buildScannerView() {
    return Container(
      color: Colors.black,
      child: _cameraPermissionGranted
          ? _buildQRCodeScanner()
          : _buildCamerePermissonDeniedView(),
    );
  }

  Widget _buildQRCodeScanner() {
    return Stack(
      children: <Widget>[
        Container(
          child: PlatformAiBarcodeScannerWidget(
            platformScannerController: _scannerController,
            unsupportedDescription: "Uh oh! feature not supported...",
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildHintMessage(),
        ),
      ],
    );
  }

  Widget _buildHintMessage() {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Text(
        "Align the QR Code within the frame to start Scanning.",
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ignore: unused_element
  Widget _buildFlashButton() {
    return IconButton(
      padding: const EdgeInsets.all(36.0),
      icon: Icon(_isFlashOpen() ? Icons.flash_on : Icons.flash_off,
          color: Colors.white),
      onPressed: () => setState(() => _toggleFlash()),
    );
  }

  Widget _buildCamerePermissonDeniedView() {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.12),
          child: Text(
            "Radar needs to access your camera to scan QR Code.",
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: OutlineButton(
            onPressed: () {
              _requestCameraPermissionLevel2();
            },
            borderSide: BorderSide(color: Colors.white),
            child: Text(
              "Enable Camera Access",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        )
      ],
    );
  }

  AlertDialog _userNotFoundDialog(String message) {
    return AlertDialog(
      title: Text("Invalid QR Code"),
      content: Container(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            _startCameraPreview();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}
