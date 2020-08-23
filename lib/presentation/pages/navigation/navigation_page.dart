import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/navigation_button_item.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/routes/routes_list.dart';

class NavigationPage extends StatelessWidget {
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
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
                    padding: EdgeInsets.all(sy(12)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NavigationItem(
                          iconAsset: "profile.png",
                          title: 'My Profile',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MY_PROFILE_ROUTE);
                          },
                        ),
                        SizedBox(height: sy(14)),
                        NavigationItem(
                          iconAsset: "change-pin.png",
                          title: 'Change PIN',
                          onPressed: onMyProfile ??
                              () {
                                Navigator.pushNamed(
                                    context, INDIVIDUAL_HOME_ROUTE);
                              },
                        ),
                        SizedBox(height: sy(14)),
                        NavigationItem(
                          iconAsset: "contact-us.png",
                          title: 'Contact us',
                          onPressed: onMyProfile ??
                              () {
                                Navigator.pushNamed(
                                    context, INDIVIDUAL_HOME_ROUTE);
                              },
                        ),
                        SizedBox(height: sy(14)),
                        NavigationItem(
                          iconAsset: "logout.png",
                          title: 'Logout',
                          onPressed: onMyProfile ??
                              () {
                                Navigator.pushNamed(
                                    context, INDIVIDUAL_HOME_ROUTE);
                              },
                        ),
                        SizedBox(height: sy(14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
