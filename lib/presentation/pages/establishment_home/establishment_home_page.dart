import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/user_addresss_string.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment/establishment_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_with_icon_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

import '../../widgets/texts/description_text.dart';

class EstablishmentHomePage extends StatefulWidget {
  @override
  _EstablishmentHomePageState createState() => _EstablishmentHomePageState();
}

class _EstablishmentHomePageState extends State<EstablishmentHomePage> {
  final _snackBarDuration = Duration(seconds: 2);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _currentBackPressTime;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  void _onLoad() async {
    BlocProvider.of<EstablishmentBloc>(context).add(
      EstablishmentOnLoad(),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > _snackBarDuration) {
      _currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Press Back again to quit the App."),
        duration: _snackBarDuration,
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<EstablishmentBloc>(context).add(
            OnRefresh(),
          );
        },
        child: MobileStatusMarginTop(
          child: Scaffold(
            key: _scaffoldKey,
            body: BlocConsumer<EstablishmentBloc, EstablishmentState>(
              listener: (context, state) {
                if (state.syncDataFailureMessage != null) {
                  ToastUtil.showToast(context, state.syncDataFailureMessage);
                }
                if (state.establishementGetUserSuccessMessage != null) {
                  ToastUtil.showToast(
                      context, state.establishementGetUserSuccessMessage);
                }
              },
              builder: (context, state) {
                if (state is EstablishmentInitial) {
                  _onLoad();
                }

                if (state.user != null) {
                  _addressController.text =
                      UserAddressString.getValue(state.user.address);
                  _contactNumberController.text =
                      "+63${state?.user?.contactNumber}";
                }

                if (state.user != null) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                            state.user != null ? _buildAppBar() : Container(),
                            state.user != null
                                ? _buildEstablishmentDetails(
                                    state.user, state.localCheckInData, state)
                                : Container(),
                            state.user != null ? _buildHint() : Container(),
                            state.user != null
                                ? _buildScanQRCodeButton()
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
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

  Widget _buildEstablishmentDetails(
      User user, List<CheckIn> localCheckInData, EstablishmentState state) {
    return ShadowWidget(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
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
                        imageUrl: user.profileImageUrl,
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
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: HeaderText(
                    title: user.firstName,
                    color: ColorUtil.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAddressTextField(),
                _buildContactNumberTextField(),
                AnimatedOpacity(
                  opacity: localCheckInData.length != 0 ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<EstablishmentBloc>(context).add(
                              OnSyncDataPressed(),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: ColorUtil.primaryColor,
                                shape: BoxShape.circle),
                            child: state.syncDataProgress
                                ? CupertinoActivityIndicator()
                                : Icon(
                                    Icons.sync_problem,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: DescriptionText(
                          title:
                              "${localCheckInData.length} individual/s saved from your establishment phone, please sync it to our server by pressing the sync icon.",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          color: ColorUtil.primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
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

  Widget _buildAddressTextField() {
    return CustomTextField(
      label: "Address",
      isRichText: true,
      child: TextFormField(
        controller: _addressController,
        readOnly: true,
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return CustomTextField(
      label: "Contact Number",
      child: TextFormField(
        controller: _contactNumberController,
        readOnly: true,
      ),
    );
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
