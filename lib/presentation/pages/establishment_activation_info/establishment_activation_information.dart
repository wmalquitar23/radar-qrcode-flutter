import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/estab_activation_info/estab_activation_info_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_with_icon_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/containers/card_information_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class EstablishmentActivationInformation extends StatefulWidget {
  final User user;

  const EstablishmentActivationInformation({Key key, this.user})
      : super(key: key);

  @override
  _EstablishmentActivationInformationState createState() =>
      _EstablishmentActivationInformationState();
}

class _EstablishmentActivationInformationState
    extends State<EstablishmentActivationInformation> {
  void _onLoad() async {
    BlocProvider.of<EstabActivationInfoBloc>(context).add(
      EstablishmentInfoOnLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Activation",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: BlocBuilder<EstabActivationInfoBloc, EstabActivationInfoState>(
            builder: (context, state) {
              if (state is EstabActivationInfoInitial) {
                _onLoad();
              }
              if (state is GetUserInformationFailure) {
                ToastUtil.showToast(context, state.error);
              }
              if (state is GetUserInformationSuccess) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: CircleImage(
                              imageUrl: state?.user?.profileImageUrl,
                              size: 140.0,
                              fromNetwork: true,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtil.primaryBackgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: state.user.isVerified
                                  ? Container(
                                      margin: EdgeInsets.all(3),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(3),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: HeaderText(
                          title: state.user.isVerified
                              ? "Your Establishment account is active"
                              : "Your Establishment account is inactive",
                          fontSize: 22,
                          color: ColorUtil.primaryColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          !state.user.isVerified
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: DescriptionText(
                                    title:
                                        "Please activate your account to access the full features and exclusive benefits of Radar.",
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: DescriptionText(
                                        title: "Thank you for using Radar.",
                                        fontWeight: FontWeight.w500,
                                        color: ColorUtil.primaryTextColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Column(
                                        children: <Widget>[
                                          DescriptionText(
                                            title:
                                                "If you have any concern please contact",
                                            fontWeight: FontWeight.w500,
                                            color: ColorUtil.primaryTextColor,
                                            fontSize: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, CONTACT_US_ROUTE);
                                            },
                                            child: DescriptionText(
                                              title: "contact us",
                                              fontWeight: FontWeight.w600,
                                              color: ColorUtil.primaryColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          !state.user.isVerified
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Divider(
                                        thickness: 0.3,
                                        color: ColorUtil.primarySubTextColor),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: HeaderText(
                                              title: "PHP500.00",
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: HeaderText(
                                              title: "PER YEAR",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildActivatedInformation(),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    _buildActivateInfoButton(),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActivatedInformation() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildChecklistItem("Unlimited scan"),
          _buildChecklistItem("No terminal fee"),
          _buildChecklistItem("Customer Support"),
          _buildChecklistItem("Establishment portal"),
        ],
      ),
    );
  }

  Widget _buildActivateInfoButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: PrimaryButtonWithIcon(
        onPressed: () {
          mainBottomSheet();
        },
        text: 'How to activate my account',
        color: ColorUtil.primaryColor,
        icon: Icon(
          Icons.info,
          color: ColorUtil.primaryBackgroundColor,
          size: 25,
        ),
      ),
    );
  }

  Container _buildChecklistItem(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              Icons.check_circle,
              color: ColorUtil.primaryColor,
              size: 17,
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  mainBottomSheet() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return _buildSheet();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height - 80,
            child: Card(
              elevation: 0.0,
              child: Container(
                child: MobileStatusMarginTop(
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                ),
                                Spacer(),
                                HeaderText(
                                  title: "Activation",
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                DescriptionText(
                                  title:
                                      "When paying your activation fee, please take a picture of your transaction slip.",
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtil.primaryTextColor,
                                  fontSize: 14,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DescriptionText(
                                  title: "Important Note: ",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                                DescriptionText(
                                  title:
                                      "Please include the establishment name and user id in your transaction slip and send a copy to",
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtil.primaryTextColor,
                                  fontSize: 14,
                                ),
                                DescriptionText(
                                  title: "phonradar@gmail.com",
                                  fontWeight: FontWeight.w600,
                                  color: ColorUtil.primaryColor,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CardInformationWidget(
                            icon: Icons.account_balance,
                            header: "via Bank Transfer (BPI)",
                            description:
                                "Account Name: Travelpud, Inc.\nAccount Number: 1085-2504-65",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CardInformationWidget(
                            icon: Icons.account_balance_wallet,
                            header: "via Pera Padala",
                            description:
                                "Recipient: Cupid Bercero\nMobile Number: 0921 627 4643",
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: <Widget>[
                            DescriptionText(
                              title: "For further information please contact",
                              fontWeight: FontWeight.w500,
                              color: ColorUtil.primaryTextColor,
                              fontSize: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, CONTACT_US_ROUTE);
                              },
                              child: DescriptionText(
                                title: "contact us",
                                fontWeight: FontWeight.w600,
                                color: ColorUtil.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
