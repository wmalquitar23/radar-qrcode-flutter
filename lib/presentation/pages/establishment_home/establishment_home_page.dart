import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_with_icon_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
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
        backgroundColor: Color(0xFFF8F8F8),
        // appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: screenSize.height * 0.66,
            decoration: BoxDecoration(
              color: ColorUtil.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34.0),
                  bottomRight: Radius.circular(34.0)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAppBar(),
              _buildEstablishmentDetails(),
              Text(
                "Please scan a QR Code to retrieve user's information.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              _buildScanQRCodeButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      icon: Icons.menu,
      iconColor: ColorUtil.primaryBackgroundColor,
      onTap: () {
        showNavigation(context);
      },
      imageAsset: 'assets/images/app/logo-white.png',
    );
  }

  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     backgroundColor: ColorUtil.primaryColor,
  //     centerTitle: true,
  //     elevation: 0.0,
  //     actions: [
  //       Container(
  //         margin: EdgeInsets.only(right: 20),
  //         child: Image.asset(
  //           'assets/images/app/logo-white.png',
  //           scale: 4,
  //           alignment: Alignment.centerRight,
  //         ),
  //       ),
  //     ],
  //     leading: GestureDetector(
  //       onTap: () {
  //         mainBottomSheet(context);
  //       },
  //       child: Icon(Icons.menu),
  //     ),
  //   );
  // }

  Container _buildEstablishmentDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorUtil.primaryBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/undraw/establishment.png',
                      scale: 2.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 7,
                    child: Container(
                      padding: EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: HeaderText(
                  title: "Lorem Company",
                  color: ColorUtil.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ..._buildTitleAndContentWithDivider(
                  'Address', 'Purok 123, Brgy 4, Bacolod Negros Occ.'),
              SizedBox(
                height: 10,
              ),
              ..._buildTitleAndContentWithDivider(
                  'Contact Number', '092112345678'),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildTitleAndContentWithDivider(String title, String content) {
    return [
      Text(
        title,
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: ColorUtil.primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      SizedBox(height: 5.0),
      Text(
        content,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      Divider(),
    ];
  }

  Widget _buildScanQRCodeButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: textFieldVerticalMargin,
        horizontal: textFieldHorizontalMargin,
      ),
      child: PrimaryButtonWithIcon(
        onPressed: () {
          Navigator.pushNamed(context, USER_DETAILS_ROUTE);
        },
        text: 'SCAN QR CODE',
      ),
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
