import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/navigation_button_item.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/routes/routes_list.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key key,
    this.onMyProfile,
    this.onChangePIN,
    this.onContactUs,
    this.onLogout,
  }) : super(key: key);

  final VoidCallback onMyProfile;
  final VoidCallback onChangePIN;
  final VoidCallback onContactUs;
  final VoidCallback onLogout;

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  void _onLogout() async {
    BlocProvider.of<NavigationBloc>(context).add(
      OnLogout(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MobileStatusMarginTop(
            backgroundColor: Colors.transparent,
            child: Container(
                color: Colors.transparent,
                child: BlocConsumer<NavigationBloc, NavigationState>(
                  listener: (context, state) {
                    if (state is NavigationLogoutSuccess) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ONBOARD_ROUTE, (Route<dynamic> route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is NavigationInitial) {
                      BlocProvider.of<NavigationBloc>(context).add(
                        OnNavigationLoad(),
                      );
                    }
                    return Column(
                      children: [
                        CustomAppBar(
                          icon: Icons.close,
                          iconColor: ColorUtil.primaryTextColor,
                          backgroundColor: ColorUtil.primaryBackgroundColor,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          imageAsset: 'assets/images/app/logo-black.png',
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                state is NavigationCheckUserRole
                                    ? state.isIndividual
                                        ? NavigationItem(
                                            iconAsset: "profile.png",
                                            title: 'My Profile',
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, MY_PROFILE_ROUTE);
                                            },
                                          )
                                        : Container()
                                    : Container(),
                                NavigationItem(
                                  iconAsset: "change-pin.png",
                                  title: 'Change PIN',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, CHANGE_PIN_ROUTE);
                                  },
                                ),
                                NavigationItem(
                                  iconAsset: "contact-us.png",
                                  title: 'Contact us',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, CONTACT_US_ROUTE);
                                  },
                                ),
                                NavigationItem(
                                  iconAsset: "logout.png",
                                  title: 'Logout',
                                  onPressed: () {
                                    _onLogout();
                                  },
                                ),
                                SizedBox(height: sy(14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
          );
        },
      ),
    );
  }
}
