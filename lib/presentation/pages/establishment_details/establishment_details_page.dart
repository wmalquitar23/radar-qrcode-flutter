import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/string_util.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/user_addresss_string.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment_details/establishment_details_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/cards/primary_card_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:intl/intl.dart';

class EstablishmentDetailsPage extends StatefulWidget {
  final dynamic qrInformation;

  const EstablishmentDetailsPage({Key key, this.qrInformation})
      : super(key: key);
  @override
  _EstablishmentDetailsPageState createState() =>
      _EstablishmentDetailsPageState();
}

class _EstablishmentDetailsPageState extends State<EstablishmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRegularAppBar(
        onBackTap: () {
          Navigator.pushReplacementNamed(context, INDIVIDUAL_HOME_ROUTE);
        },
        backgroundColor: Colors.transparent,
        title: "Scan Details",
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              BlocConsumer<EstablishmentDetailsBloc, EstablishmentDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is EstablishmentDetailsInitial) {
                BlocProvider.of<EstablishmentDetailsBloc>(context).add(
                  OnLoadUserDetail(widget.qrInformation),
                );
              }

              if (state.establishmentInformation != null &&
                  state.getCurrentUser != null) {
                return Column(
                  children: [
                    PrimaryCardWidget(
                      child: Column(
                        children: <Widget>[
                          _buildUserInformation(state.getCurrentUser),
                          _buildEstablishmentInformation(
                              state.establishmentInformation),
                        ],
                      ),
                    ),
                    PrimaryCardWidget(
                      backgroundColor: ColorUtil.disabledBackgroundColor,
                      child: Column(
                        children: <Widget>[
                          _buildUserTimeScanned(state.dateTime),
                        ],
                      ),
                    )
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: _buildDecisionButtons(),
      ),
    );
  }

  Widget _buildUserTimeScanned(DateTime dateTime) {
    String dateFormat = DateFormat.yMMMEd().format(dateTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          size: 60,
          color: ColorUtil.blackFadedColor,
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DescriptionText(
                    title: new DateFormat.jm()
                        .format(DateTime.parse(dateTime.toString())),
                    color: ColorUtil.primaryTextColor,
                    fontSize: 30,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Text(
                dateFormat,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 12.0,
                  color: ColorUtil.primaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInformation(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50.0,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: CircleImage(
              imageUrl: user?.profileImageUrl,
              size: 50.0,
              fromNetwork: true,
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DescriptionText(
                      title: user?.fullName,
                      color: ColorUtil.primaryColor,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  StatusWidget(
                    isVerified: user?.isVerified,
                    iconOnly: true,
                  )
                ],
              ),
              Text(
                UserAddressString.getValue(user?.address),
                style: TextStyle(
                  height: 1.5,
                  fontSize: 12.0,
                  color: ColorUtil.primaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstablishmentInformation(User user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50.0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CircleImage(
                imageUrl: user?.profileImageUrl,
                size: 50.0,
                fromNetwork: true,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionText(
                  title: user?.fullName,
                  color: ColorUtil.primaryColor,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: ColorUtil.tagBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(21.0)),
                  ),
                  child: DescriptionText(
                    title: user?.designatedArea,
                    color: ColorUtil.primaryTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
                Text(
                  UserAddressString.getValue(user?.address),
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 12.0,
                    color: ColorUtil.primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionButtons() {
    return BlocConsumer<EstablishmentDetailsBloc, EstablishmentDetailsState>(
      listener: (context, state) {
        if (state.establishmentApproveDone) {
          Navigator.pushReplacementNamed(context, INDIVIDUAL_HOME_ROUTE);
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: PrimaryButton(
                    text: 'IN',
                    fontSize: 18,
                    color: state.establishmentApproveLoading
                        ? ColorUtil.disabledBackgroundColor
                        : ColorUtil.primaryColor,
                    isLoading: state.establishmentApproveLoading,
                    onPressed: state.establishmentInformation != null
                        ? () {
                            BlocProvider.of<EstablishmentDetailsBloc>(context)
                                .add(
                              OnUserApprove(
                                state.establishmentInformation,
                                IN,
                                state.dateTime,
                              ),
                            );
                          }
                        : null,
                    hasIcon: true,
                    icon: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset("assets/images/svg/in.svg",
                          width: 25, height: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: PrimaryButton(
                    text: 'OUT',
                    fontSize: 18,
                    color: state.establishmentApproveLoading
                        ? ColorUtil.disabledBackgroundColor
                        : ColorUtil.primaryColor,
                    isLoading: state.establishmentApproveLoading,
                    onPressed: state.establishmentInformation != null
                        ? () {
                            BlocProvider.of<EstablishmentDetailsBloc>(context)
                                .add(
                              OnUserApprove(
                                state.establishmentInformation,
                                OUT,
                                state.dateTime,
                              ),
                            );
                          }
                        : null,
                    hasIcon: true,
                    icon: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset("assets/images/svg/out.svg",
                          width: 25, height: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
