import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/date_utils.dart';
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
import 'package:radar_qrcode_flutter/presentation/widgets/dialogs/designated_area_dialog.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

import '../../widgets/texts/description_text.dart';

class EstablishmentHomePage extends StatefulWidget {
  @override
  _EstablishmentHomePageState createState() => _EstablishmentHomePageState();
}

class _EstablishmentHomePageState extends State<EstablishmentHomePage> {
  final int limitScanNumber = 501;
  final _snackBarDuration = Duration(seconds: 2);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _currentBackPressTime;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _designatedAreaController = TextEditingController();

  void _onLoad() async {
    BlocProvider.of<EstablishmentBloc>(context).add(
      EstablishmentOnLoad(),
    );
  }

  void _onDesignatedAreaSubmit(String value) async {
    BlocProvider.of<EstablishmentBloc>(context).add(
      OnDesignatedAreaSubmit(value),
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
    final double containerSize = screenSize.height * 0.60;
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
                  _designatedAreaController.text =
                      "${state?.user?.designatedAreaToUpperCase}";

                  print("name: ${state.user?.fullName}");
                }

                if (state.user != null) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            state.user != null ? _buildAppBar() : Container(),
                            state.user != null
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: _buildEstablishmentDetails(
                                        state.user,
                                        state.localCheckInData,
                                        state.totalScannedCheckInData,
                                        state),
                                  )
                                : Container(),
                            state.user != null
                                ? _buildHint(
                                    state.user, state.totalScannedCheckInData)
                                : Container(),
                            state.user != null
                                ? _buildScanQRCodeButton(
                                    state.user, state.totalScannedCheckInData)
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

  Widget _buildEstablishmentDetails(User user, List<CheckIn> localCheckInData,
      List<CheckIn> totalScannedCheckInData, EstablishmentState state) {
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                HeaderText(
                  title: user.firstName,
                  color: ColorUtil.primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusWidget(
                      isVerified: user?.isVerified,
                      iconOnly: true,
                    ),
                    DescriptionText(
                      title: "#${user.displayId}",
                      color: ColorUtil.primaryTextColor,
                    ),
                  ],
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
                _buildDesignatedAreaTextField(state),
                localCheckInData.length != 0
                    ? AnimatedOpacity(
                        opacity: localCheckInData.length != 0 ? 1.0 : 0.0,
                        duration: Duration(seconds: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<EstablishmentBloc>(context)
                                      .add(
                                    OnSyncDataPressed(),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
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
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                !DateUtils.isSubscribing(
                  user?.verification?.expirationDate,
                  user?.isVerified,
                  user?.createdAt,
                )
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: _buildWarningNote(),
                          ),
                        ],
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWarningNote() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border(
          left: BorderSide(
            width: 8,
            color: Colors.red,
          ),
        ),
      ),
      child: Text(
        "Upgrade your account now to have unlimited access, check your activation menu for more details, Thank you.",
        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
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

        if (croppedFile != null) {
          BlocProvider.of<EstablishmentBloc>(context).add(
            ProfileImageOnUpload(croppedFile),
          );
        }
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

  Widget _buildDesignatedAreaTextField(EstablishmentState state) {
    return CustomTextField(
      label: "Designated Area",
      child: TextFormField(
        controller: _designatedAreaController,
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              _showDesignatedAreaDialog();
            },
            child: Container(
              child: Center(
                widthFactor: 0,
                child: state.updateDesignatedAreaProgress
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CupertinoActivityIndicator())
                    : Icon(
                        Icons.mode_edit,
                        size: 16,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDesignatedAreaDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DesignatedAreaCustomDialog(
            designatedAreaValue: _designatedAreaController.text,
          );
        }).then(
      (value) {
        if (value != null) {
          _onDesignatedAreaSubmit(value);
        }
      },
    );
  }

  Widget _buildHint(User user, List<CheckIn> totalScannedCheckInData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          DescriptionText(
            title: DateUtils.isSubscribing(
              user?.verification?.expirationDate,
              user?.isVerified,
              user?.createdAt,
            )
                ? "Please scan a QR Code to retrieve user's information."
                : "Please activate your account to continue using Radar.",
            color: ColorUtil.primaryTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DescriptionText(
                title: user.isVerified
                    ? ""
                    : DateUtils.isSubscribing(
                        user?.verification?.expirationDate,
                        user?.isVerified,
                        user?.createdAt,
                      )
                        ? "Activate your account to scan unlimited users."
                        : "Click ",
                color: ColorUtil.primaryTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, ESTABLISHMENT_ACTIVATION_INFORMATION_ROUTE);
                },
                child: DescriptionText(
                  title: DateUtils.isSubscribing(
                    user?.verification?.expirationDate,
                    user?.isVerified,
                    user?.createdAt,
                  )
                      ? ""
                      : "here ",
                  color: ColorUtil.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DescriptionText(
                title: DateUtils.isSubscribing(
                  user?.verification?.expirationDate,
                  user?.isVerified,
                  user?.createdAt,
                )
                    ? ""
                    : "to activate.",
                color: ColorUtil.primaryTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanQRCodeButton(
      User user, List<CheckIn> totalScannedCheckInData) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      child: PrimaryButtonWithIcon(
        onPressed: () {
          if (DateUtils.isSubscribing(
            user?.verification?.expirationDate,
            user?.isVerified,
            user?.createdAt,
          )) {
            Navigator.pushNamed(
              context,
              SCAN_QRCODE_ROUTE,
              arguments: user.role,
            );
          } else {
            return null;
          }
        },
        text: 'SCAN QR CODE',
        color: DateUtils.isSubscribing(
          user?.verification?.expirationDate,
          user?.isVerified,
          user?.createdAt,
        )
            ? ColorUtil.primaryColor
            : ColorUtil.disabledColor,
      ),
    );
  }
}
