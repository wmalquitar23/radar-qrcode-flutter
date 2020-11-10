import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/user_addresss_string.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/my_qrcode/my_qrcode_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class MyQRCodePage extends StatefulWidget {
  @override
  _MyQRCodePageState createState() => _MyQRCodePageState();
}

class _MyQRCodePageState extends State<MyQRCodePage> {
  String _encryptedQr;
  User _user;

  void _onLoad() async {
    BlocProvider.of<MyQRCodeBloc>(context).add(
      UserOnLoad(),
    );
  }

  void _requestMediaStoragePermissionFromAppSettings() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Radar needs to access your Storage"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "Please grant storage permission in App Settings.\n",
              ),
              Text(
                "To enable this feature, click App Settings below and enable storage under the Permissions menu.",
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
            },
          )
        ],
      ),
    );
  }

  void _downloadQR(QRDownloadType downloadType, BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      BlocProvider.of<MyQRCodeBloc>(context).add(
        OnDownloadButtonClick(
          downloadType: downloadType,
          user: _user,
          qrData: _encryptedQr,
          buildContext: context,
        ),
      );
    } else {
      if (await Permission.storage.isPermanentlyDenied) {
        _requestMediaStoragePermissionFromAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    final Size screenSize = MediaQuery.of(context).size;
    final double containerSize = screenSize.height * 0.60;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<MyQRCodeBloc, MyQRCodeState>(
          listener: (context, state) async {
            if (state.getUserSuccess != null) {
              _user = state.getUserSuccess.user;
              _encryptedQr = state.getUserSuccess.jsonQrCode;
            }

            if (state.getuserFailureMessage != null) {
              ToastUtil.showToast(context, state.getuserFailureMessage);
            }
            if (state.getUserSuccessMessage != null) {
              ToastUtil.showToast(context, state.getUserSuccessMessage);
            }
          },
          builder: (context, state) {
            if (state is MyQRCodeInitial) {
              _onLoad();
            }

            if (_user != null && _encryptedQr != null) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      height: containerSize,
                      decoration: BoxDecoration(
                        color: ColorUtil.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(34.0),
                            bottomRight: Radius.circular(34.0)),
                      ),
                    ),
                    Column(
                      children: [
                        if (_user != null && _encryptedQr != null) ...[
                          _buildAppBar(),
                          _buildUserInfo(),
                          _buildQRInfo(
                            screenSize,
                            containerSize,
                          ),
                          _buildNote(),
                          _buildButtons(context),
                        ],
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _generateQrCOde(Size screenSize) {
    return QrImage(
      data: _encryptedQr.toString() ?? "",
      foregroundColor: Colors.black,
      version: QrVersions.auto,
      size: screenSize.width * 0.70,
      embeddedImage: AssetImage('assets/images/app_icon/qr_icon.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(40, 40),
      ),
      errorStateBuilder: (cxt, err) {
        return Container(
          child: Center(
            child: Text(
              "Uh oh! Something went wrong...",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      icon: Icons.arrow_back,
      iconColor: ColorUtil.primaryBackgroundColor,
      onTap: () {
        Navigator.pop(context);
      },
      imageAsset: 'assets/images/app/logo-white.png',
    );
  }

  Widget _buildUserInfo() {
    return Container(
      child: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorUtil.primaryBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(21.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DescriptionText(
                        title: _user?.fullName,
                        color: ColorUtil.primaryColor,
                        fontSize: 16,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 3),
                      Text(
                        UserAddressString.getValue(_user?.address),
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 10.0,
                          color: ColorUtil.primarySubTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                Container(
                  width: 50.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: CircleImage(
                      imageUrl: _user?.profileImageUrl,
                      size: 50.0,
                      fromNetwork: true,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQRInfo(Size screenSize, double containerSize) {
    return ShadowWidget(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorUtil.primaryBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(21.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DescriptionText(
                      title: "My QR Code",
                      color: ColorUtil.primaryTextColor,
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    DescriptionText(
                      title: '#${_user?.displayId}',
                      color: ColorUtil.primarySubTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(thickness: 0.3, color: ColorUtil.primarySubTextColor),
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: _generateQrCOde(screenSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      child: Text(
        "Download your QR Code poster or sticker and display it somewhere visitors can see it and scan it when they arrive.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return BlocBuilder<MyQRCodeBloc, MyQRCodeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PrimaryButton(
                text: "DOWNLOAD POSTER (A4 SIZE)",
                onPressed: () => _downloadQR(QRDownloadType.poster, context),
                isLoading: state is QRDownloadInProgress &&
                    state.qrDownloadType == QRDownloadType.poster,
              ),
              // SizedBox(height: 20),
              // PrimaryButton(
              //   text: "DOWNLOAD STICKER (3.5in x 6in)",
              //   onPressed: () => _downloadQR(QRDownloadType.sticker, context),
              //   isLoading: state is QRDownloadInProgress &&
              //       state.qrDownloadType == QRDownloadType.sticker,
              // ),
            ],
          ),
        );
      },
    );
  }
}
