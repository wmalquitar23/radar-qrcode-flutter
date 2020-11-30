import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_util.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/user_addresss_string.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual/individual_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

import '../../../core/utils/routes/routes_list.dart';

class IndividualHomePage extends StatefulWidget {
  @override
  _IndividualHomePageState createState() => _IndividualHomePageState();
}

class _IndividualHomePageState extends State<IndividualHomePage> {
  final _snackBarDuration = Duration(seconds: 2);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _currentBackPressTime;
  var _encryptedQr;

  void _onLoad() async {
    BlocProvider.of<IndividualBloc>(context).add(
      IndividualOnLoad(),
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    final Size screenSize = MediaQuery.of(context).size;
    final double containerSize = screenSize.height * 0.60;
    return WillPopScope(
      onWillPop: onWillPop,
      child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<IndividualBloc>(context).add(
              OnRefresh(),
            );
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              body: SafeArea(
                child: BlocConsumer<IndividualBloc, IndividualState>(
                  listener: (context, state) async {
                    if (state.individualGetUserSuccess != null) {
                      _encryptedQr = state.individualGetUserSuccess.jsonQrCode;
                    }
                    if (state.syncDataFailureMessage != null) {
                      ToastUtil.showToast(
                          context, state.syncDataFailureMessage);
                    }
                    if (state.individualGetuserFailureMessage != null) {
                      ToastUtil.showToast(
                          context, state.individualGetuserFailureMessage);
                    }
                    if (state.individualGetuserSuccessMessage != null) {
                      ToastUtil.showToast(
                          context, state.individualGetuserSuccessMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is IndividualInitial) {
                      _onLoad();
                    }

                    if (state.individualGetUserSuccess != null) {
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
                                state.individualGetUserSuccess != null
                                    ? _buildAppBar()
                                    : Container(),
                                state.individualGetUserSuccess != null
                                    ? _buildPersonInfo(
                                        state.individualGetUserSuccess)
                                    : Container(),
                                state.individualGetUserSuccess != null
                                    ? _buildQRInfo(
                                        screenSize,
                                        state.individualGetUserSuccess,
                                        containerSize,
                                        state.localCheckInData,
                                        state.totalScannedCheckInData,
                                        state.syncDataProgress,
                                      )
                                    : Container(),
                                state.individualGetUserSuccess != null
                                    ? _buildHint(state.individualGetUserSuccess)
                                    : Container(),
                                state.individualGetUserSuccess != null
                                    ? _buildVerifyIdentityButton(
                                        state.individualGetUserSuccess)
                                    : Container(),
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
              ))),
    );
  }

  Widget _buildVerifyIdentityButton(IndividualGetUserSuccess state) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      child: !state.user.isVerified
          ? PrimaryButton(
              text: state.user.requirement.isSubmitted
                  ? "Pending Verification"
                  : "Submit Valid ID",
              color: state.user.requirement.isSubmitted
                  ? ColorUtil.disabledColor
                  : ColorUtil.primaryColor,
              onPressed: () {
                if (state.user.requirement.isSubmitted) {
                  return null;
                } else {
                  // set up the buttons
                  Widget cancelButton = FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  Widget continueButton = FlatButton(
                    child: Text("Proceed"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(IDENTITY_VERIFICATION_ROUTE);
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Important Note"),
                    content: DescriptionText(
                      title:
                          "Please change your profile image with your recent picture before sending your ID for validation. Note that you can no longer change your profile image once your account is validated.",
                      fontWeight: FontWeight.w500,
                      color: ColorUtil.primaryTextColor,
                      textAlign: TextAlign.left,
                    ),
                    actions: [
                      cancelButton,
                      continueButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              })
          : Column(
              children: [
                DescriptionText(
                  title: "For Profile updates and any other concerns, please ",
                  color: ColorUtil.primaryTextColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CONTACT_US_ROUTE);
                  },
                  child: DescriptionText(
                    title: "get in touch with us",
                    color: ColorUtil.primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _generateQrCOde(Size screenSize, IndividualGetUserSuccess state) {
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
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 3),
                    Text(
                      UserAddressString.getValue(state?.user?.address),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MY_PROFILE_ROUTE);
                },
                child: Container(
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQRInfo(
    Size screenSize,
    IndividualGetUserSuccess state,
    double containerSize,
    List<CheckIn> localCheckInData,
    List<CheckIn> totalScannedCheckInData,
    bool syncDataProgress,
  ) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 40.0),
          child: ShadowWidget(
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
                            title: '#${state?.user?.displayId}',
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
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: _generateQrCOde(screenSize, state),
                  ),
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
                                    BlocProvider.of<IndividualBloc>(context)
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
                                    child: syncDataProgress
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
                                      "You have ${localCheckInData.length} transactions saved from your local phone, please sync it to our server by pressing the sync icon.",
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
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ShadowWidget(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SCAN_QRCODE_ROUTE,
                    arguments: state.user.role,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorUtil.primaryBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: ColorUtil.primaryColor, shape: BoxShape.circle),
                    child: Image.asset('assets/images/app/qr-code.png'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHint(IndividualGetUserSuccess state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          DescriptionText(
            title: !state.user.isVerified
                ? (state.user.requirement.isSubmitted
                    ? "Your document has been successfully uploaded for review."
                    : "In order to complete the verification, please take a picture of your valid government or company ID card.")
                : "",
            color: ColorUtil.primaryTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
