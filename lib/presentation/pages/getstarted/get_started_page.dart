import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/cubit/get_started_page_cubit.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/label_text.dart';

import '../../../core/utils/routes/routes_list.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: HeaderText(
                  title: "Let\'s Get Started!",
                  fontSize: 24,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: LabelText(
                  fontSize: 16.0,
                  title: "Register As",
                  color: ColorUtil.primarySubTextColor,
                ),
              ),
              BlocBuilder<GettingstartedCubit, SelectedRegistrationType>(
                builder: (_, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          _buildRegistrationTypeContainer(
                            context,
                            child: CircleImage(
                              size: 125.0,
                              imageUrl: "assets/images/undraw/individual.png",
                              fromNetwork: false,
                              onClick: () =>
                                  _toggleSelectedRegistrationType(context),
                            ),
                            selected:
                                state == SelectedRegistrationType.Individual
                                    ? true
                                    : false,
                          ),
                          SizedBox(
                            height: 23.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: LabelText(title: "Individual"),
                          ),
                          Container(
                            width: 125,
                            child: DescriptionText(
                                title:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          _buildRegistrationTypeContainer(
                            context,
                            child: CircleImage(
                              size: 125.0,
                              imageUrl:
                                  "assets/images/undraw/establishment.png",
                              fromNetwork: false,
                              onClick: () =>
                                  _toggleSelectedRegistrationType(context),
                            ),
                            selected:
                                state == SelectedRegistrationType.Establishment
                                    ? true
                                    : false,
                          ),
                          SizedBox(
                            height: 23.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: LabelText(title: "Establishment"),
                          ),
                          Container(
                            width: 125,
                            child: DescriptionText(
                                title:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              PrimaryButton(
                text: "Register",
                fontSize: 14,
                onPressed: () {
                  final nextRoute = context.bloc<GettingstartedCubit>().state ==
                          SelectedRegistrationType.Individual
                      ? BASIC_INFORMATION_ROUTE
                      : ESTABLISHMENT_INFO_ROUTE;
                  Navigator.pushNamed(context, nextRoute);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildRegistrationTypeContainer(BuildContext context,
      {@required Widget child, bool selected = false}) {
    return Container(
      padding: EdgeInsets.all(2.5),
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
              width: 2.5,
              color: selected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
        ),
      ),
      child: child,
    );
  }

  _toggleSelectedRegistrationType(BuildContext context) {
    context.bloc<GettingstartedCubit>().toggleSelectedRegistrationType();
  }
}
