import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return MobileStatusMarginTop(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.primaryColor,
        title: Text("My QR Code"),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              mainBottomSheet(context);
            },
            child: Icon(Icons.menu)),
        elevation: 0.0,
      ),
      body: Container(
        color: ColorUtil.primaryColor,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.all(20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorUtil.primaryBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    child: CircleImage(
                      imageUrl: "assets/images/profile/lalisa.jpeg",
                      size: 125.0,
                      fromNetwork: false,
                    ),
                  ),
                ],
              ),
              HeaderText(title: "LALISA MANOBAN"),
              SizedBox(height: 8.0),
              DescriptionText(
                title: "#TG2351E2121",
              ),
              SizedBox(
                height: 10.0,
              ),
              _generateQrCOde(screenSize)
            ],
          ),
        ),
      ),
    ));
  }

  Widget _generateQrCOde(Size screenSize) {
    return QrImage(
      data: "Jonel Dominic Tapang",
      foregroundColor: ColorUtil.primaryTextColor,
      version: QrVersions.auto,
      size: screenSize.width * 0.55,
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

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.all(15),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact Us'),
                ),
                ListTile(
                  leading: Icon(Icons.label_important),
                  title: Text('Logout'),
                ),
              ],
            ),
          );
        });
  }
}
