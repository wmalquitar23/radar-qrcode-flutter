import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class UserDetailsPage extends StatefulWidget {
  final dynamic qrInformation;

  const UserDetailsPage({Key key, this.qrInformation}) : super(key: key);
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRegularAppBar(
        onBackTap: () {
          Navigator.pushReplacementNamed(context, ESTABLISHMENT_HOME_ROUTE);
        },
        backgroundColor: Colors.transparent,
        title: "User Details",
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: BlocConsumer<UserDetailsBloc, UserDetailsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UserDetailsInitial) {
                  BlocProvider.of<UserDetailsBloc>(context).add(
                    OnLoadUserDetail(widget.qrInformation),
                  );
                }
                if (state.userInformation != null) {
                  _addressController.text = state?.userInformation?.address;
                  _ageController.text = state?.userInformation?.age?.toString();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildImage(state.userInformation),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: HeaderText(
                          title: state?.userInformation?.fullName,
                          fontSize: 18,
                          color: ColorUtil.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatusWidget(
                            isVerified: state?.userInformation?.isVerified,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildAddressTextField(),
                      _buildAgeTextField(),
                    ],
                  );
                }
                return Container();
              },
            ),
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

  Widget _buildImage(User state) {
    return Center(
      child: Container(
        width: 120.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CircleImage(
                imageUrl: state?.profileImageUrl,
                size: 120.0,
                fromNetwork: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressTextField() {
    return CustomTextField(
        label: "Address",
        child: TextFormField(
          controller: _addressController,
          readOnly: true,
          validator: (value) {
            if (value.isEmpty) {
              return "Empty field";
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
        ));
  }

  Widget _buildAgeTextField() {
    return CustomTextField(
        label: "Age",
        child: TextFormField(
          controller: _ageController,
          readOnly: true,
          validator: (value) {
            if (value.isEmpty) {
              return "Empty field";
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
        ));
  }

  Widget _buildDecisionButtons() {
    return BlocConsumer<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        if (state.userApproveDone) {
          Navigator.pushReplacementNamed(context, ESTABLISHMENT_HOME_ROUTE);
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
                    text: 'APPROVE',
                    color: Colors.green,
                    isLoading: state.userApproveLoading,
                    onPressed: state.userInformation != null
                        ? () {
                            BlocProvider.of<UserDetailsBloc>(context).add(
                              OnUserApprove(state.userInformation),
                            );
                          }
                        : null,
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
