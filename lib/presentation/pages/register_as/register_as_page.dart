import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/label_text.dart';

class RegisterAsPage extends StatefulWidget {
  @override
  _RegisterAsPageState createState() => _RegisterAsPageState();
}

class _RegisterAsPageState extends State<RegisterAsPage> {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70.0),
                    child: HeaderText(
                      title: "Register as...",
                      fontSize: 28,
                      color: ColorUtil.primaryColor,
                    ),
                  ),
                  SizedBox(height: 35.0),
                  BlocBuilder<RegisterAsBloc, RegisterAsState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              _buildRegistrationTypeContainer(
                                context,
                                child: CircleImage(
                                  size: 125.0,
                                  imageUrl:
                                      "assets/images/undraw/individual.png",
                                  fromNetwork: false,
                                  onClick: () =>
                                      _toggleSelectedRegistrationType(context,
                                          SelectedRegistrationType.Individual),
                                ),
                                selected:
                                    state is SelectIndividual ? true : false,
                              ),
                              SizedBox(
                                height: 23.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: LabelText(
                                  title: "Individual",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
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
                                      _toggleSelectedRegistrationType(
                                          context,
                                          SelectedRegistrationType
                                              .Establishment),
                                ),
                                selected:
                                    state is SelectEstablishment ? true : false,
                              ),
                              SizedBox(
                                height: 23.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: LabelText(
                                  title: "Establishment",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<RegisterAsBloc, RegisterAsState>(
                builder: (context, state) {
                  return PrimaryButton(
                    text: "CONTINUE",
                    fontSize: 14,
                    onPressed: () {
                      if (state is SelectIndividual) {
                        Navigator.pushNamed(context, BASIC_INFORMATION_ROUTE);
                      }
                      if (state is SelectEstablishment) {
                        Navigator.pushNamed(context, ESTABLISHMENT_INFO_ROUTE);
                      }
                      // final nextRoute = context.bloc<GettingstartedCubit>().state ==
                      //         SelectedRegistrationType.Individual
                      //     ? BASIC_INFORMATION_ROUTE
                      //     : ESTABLISHMENT_INFO_ROUTE;
                      // Navigator.pushNamed(context, nextRoute);
                    },
                  );
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
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(2.5),
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                  width: 3,
                  color:
                      selected ? ColorUtil.primaryColor : Colors.transparent),
            ),
          ),
          child: child,
        ),
        selected
            ? Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorUtil.successColor),
                  width: 40,
                  height: 40,
                  child: Container(
                    child: Icon(
                      Icons.check,
                      color: ColorUtil.primaryBackgroundColor,
                      size: 30,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  void _toggleSelectedRegistrationType(
      BuildContext context, SelectedRegistrationType type) async {
    BlocProvider.of<RegisterAsBloc>(context)
        .add(OnSelectRegistrationType(selectedRegistrationType: type));
  }
}
