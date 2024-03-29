import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/user_addresss_string.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/profile/profile_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/status/status_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

import 'package:intl/intl.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateBirthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  void _onLoad() async {
    BlocProvider.of<ProfileBloc>(context).add(
      ProfileOnLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "My Profile",
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProfileInitial) {
                  _onLoad();
                }

                if (state is ProfileGetDataSuccess) {
                  DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");
                  
                  _addressController.text =
                      UserAddressString.getValue(state?.user?.address);
                  _dateBirthController.text = state?.user?.birthDate != null ? 
                      birthdayFormatter.format(state?.user?.birthDate) : "";
                  _genderController.text = state?.user?.genderToString();
                  _contactNumberController.text =
                      "+63${state?.user?.contactNumber}";

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildImage(
                          state?.user?.profileImageUrl,
                          state?.user?.isVerified,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: HeaderText(
                            title: state is ProfileGetDataSuccess
                                ? state?.user?.fullName
                                : "",
                            fontSize: 18,
                            color: ColorUtil.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        state is ProfileGetDataSuccess
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StatusWidget(
                                    isVerified: state.user.isVerified,
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildAddressTextField(),
                        _buildDateOfBirthTextField(),
                        _buildGenderTextField(),
                        _buildContactNumberTextField()
                      ],
                    ),
                  );
                }

                return Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            )),
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
              title: "Profile Image"),
        );
        if (croppedFile != null) {
          BlocProvider.of<ProfileBloc>(context).add(
            ProfileImageOnUpload(croppedFile),
          );
        }
      },
      maxWidth: 1024,
      maxHeight: 512,
    );
  }

  Widget _buildImage(String image, bool isVerified) {
    return Center(
      child: Container(
        width: 120.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CircleImage(
                imageUrl: image,
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
                child: !isVerified
                    ? GestureDetector(
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
                      )
                    : Container(),
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
        isRichText: true,
        child: TextFormField(
          controller: _addressController,
          readOnly: true,
        ));
  }

  Widget _buildDateOfBirthTextField() {
    return CustomTextField(
        label: "Date of Birth",
        child: TextFormField(
          controller: _dateBirthController,
          readOnly: true,
        ));
  }

  Widget _buildGenderTextField() {
    return CustomTextField(
        label: "Gender",
        child: TextFormField(
          controller: _genderController,
          readOnly: true,
        ));
  }

  Widget _buildContactNumberTextField() {
    return CustomTextField(
        label: "Contact Number",
        child: TextFormField(
          controller: _contactNumberController,
          readOnly: true,
        ));
  }
}
