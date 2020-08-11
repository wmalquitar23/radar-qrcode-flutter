import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/secondary_button.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class EstablishmentHomePage extends StatefulWidget {
  @override
  _EstablishmentHomePageState createState() => _EstablishmentHomePageState();
}

class _EstablishmentHomePageState extends State<EstablishmentHomePage> {
  final double textFieldVerticalMargin = 10.0;
  final double textFieldHorizontalMargin = 50.0;

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.primaryColor,
        title: Text("Scan Code"),
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
                      size: 200.0,
                      fromNetwork: false,
                    ),
                  ),
                ],
              ),
              HeaderText(title: "NCCC MALL"),
              SizedBox(height: 8.0),
              DescriptionText(
                title: "#TG2351E2121",
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildScanQRCodeButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildScanQRCodeButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: textFieldVerticalMargin,
        horizontal: textFieldHorizontalMargin,
      ),
      child: SecondaryButton(text: 'Scan QR Code'),
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
      },
    );
  }
}
