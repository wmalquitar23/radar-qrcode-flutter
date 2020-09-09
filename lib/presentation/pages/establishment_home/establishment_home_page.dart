import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment/establishment_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_with_icon_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

import '../../widgets/texts/description_text.dart';

class EstablishmentHomePage extends StatefulWidget {
  @override
  _EstablishmentHomePageState createState() => _EstablishmentHomePageState();
}

class _EstablishmentHomePageState extends State<EstablishmentHomePage> {
  String _imageUrl;
  void _onLoad() async {
    BlocProvider.of<EstablishmentBloc>(context).add(
      EstablishmentOnLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return MobileStatusMarginTop(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<EstablishmentBloc, EstablishmentState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is EstablishmentInitial) {
                _onLoad();
              }
              if (state is EstablishmentGetUserSuccess) {
                _imageUrl = state?.user?.profileImageUrl;
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      state is EstablishmentGetUserSuccess
                          ? _buildAppBar()
                          : Container(),
                      state is EstablishmentGetUserSuccess
                          ? _buildEstablishmentDetails(state)
                          : Container(),
                      state is EstablishmentGetUserSuccess
                          ? _buildHint()
                          : Container(),
                      state is EstablishmentGetUserSuccess
                          ? _buildScanQRCodeButton()
                          : Container(),
                    ],
                  )
                ],
              );
            },
          ),
        ),
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

  Container _buildEstablishmentDetails(EstablishmentGetUserSuccess state) {
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: CircleImage(
                      imageUrl: _imageUrl ?? "",
                      size: 120.0,
                      fromNetwork: true,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorUtil.primaryBackgroundColor,
                          shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () {
                          changeImage();
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: HeaderText(
                  title: state.user.firstName,
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
                  'Address', state.user.address),
              SizedBox(
                height: 10,
              ),
              ..._buildTitleAndContentWithDivider(
                  'Contact Number', state.user.contactNumber),
            ],
          )
        ],
      ),
    );
  }

  void changeImage() {
    ImageUtils.pickImage(
      context,
      (File file) async {
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: file.path,
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [CropAspectRatioPreset.square],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: "Change Profile Image",
                hideBottomControls: true,
                showCropGrid: true,
                toolbarColor: ColorUtil.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            iosUiSettings: IOSUiSettings(
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: true,
                aspectRatioPickerButtonHidden: true,
                title: "Profile Image"));

        BlocProvider.of<EstablishmentBloc>(context).add(
          ProfileImageOnUpload(croppedFile),
        );
      },
      maxWidth: 1024,
      maxHeight: 512,
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

  Widget _buildHint() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          DescriptionText(
            title: "Please scan a QR Code to retrieve user's information.",
            color: ColorUtil.primaryTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildScanQRCodeButton() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      child: PrimaryButtonWithIcon(
        onPressed: () {
          Navigator.pushNamed(context, SCAN_QRCODE_ROUTE);
        },
        text: 'SCAN QR CODE',
      ),
    );
  }
}
