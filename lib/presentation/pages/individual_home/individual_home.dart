import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual/individual_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

import '../../../core/utils/routes/routes_list.dart';

class IndividualHomePage extends StatefulWidget {
  @override
  _IndividualHomePageState createState() => _IndividualHomePageState();
}

class _IndividualHomePageState extends State<IndividualHomePage> {
  void _onLoad() async {
    BlocProvider.of<IndividualBloc>(context).add(
      IndividualOnLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return MobileStatusMarginTop(
        child: Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<IndividualBloc, IndividualState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is IndividualInitial) {
              _onLoad();
            }
            return Stack(
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
                  children: [
                    _buildAppBar(),
                    state is IndividualGetUserSuccess
                        ? _buildPersonInfo(state)
                        : CupertinoActivityIndicator(),
                    state is IndividualGetUserSuccess
                        ? _buildQRInfo(screenSize, state)
                        : CupertinoActivityIndicator(),
                    state is IndividualGetUserSuccess
                        ? _buildHint()
                        : CupertinoActivityIndicator(),
                    state is IndividualGetUserSuccess
                        ? _buildVerifyIdentityButton()
                        : CupertinoActivityIndicator(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    ));
  }

  Widget _buildVerifyIdentityButton() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      child: PrimaryButton(
        text: "Verify Identity",
        onPressed: () =>
            Navigator.of(context).pushNamed(IDENTITY_VERIFICATION_ROUTE),
      ),
    );
  }

  Widget _generateQrCOde(Size screenSize, IndividualGetUserSuccess state) {
    return QrImage(
      data: state?.user?.id,
      foregroundColor: Colors.black,
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

  Widget _buildPersonInfo(IndividualGetUserSuccess state) {
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
                        title: state?.user?.fullName,
                        color: ColorUtil.primaryColor,
                        fontSize: 16,
                      ),
                      SizedBox(height: 3),
                      Text(
                        state?.user?.address,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 10.0,
                          color: ColorUtil.primarySubTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                      imageUrl: state?.user?.profileImageUrl,
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

  Widget _buildQRInfo(Size screenSize, IndividualGetUserSuccess state) {
    return ShadowWidget(
      child: Container(
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
                        title: '#${state?.user?.id}',
                        color: ColorUtil.primarySubTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  StatusWidget(
                    isVerified: state.user.isVerified,
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(thickness: 0.3, color: ColorUtil.primarySubTextColor),
              SizedBox(
                height: 10.0,
              ),
              _generateQrCOde(screenSize, state)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHint() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          DescriptionText(
            title:
                "In order to complete the verification, please take a picture of your valid government or company ID card.",
            color: ColorUtil.primaryTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
