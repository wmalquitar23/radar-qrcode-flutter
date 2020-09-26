import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/dependency_instantiator.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/verification_identity/bloc/verification_id_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/dialogs/custom_alert_dialog.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/bar/custom_regular_app_bar.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/header_text.dart';

class UploadIDPage extends StatefulWidget {
  final File selectedImage;

  const UploadIDPage({Key key, this.selectedImage}) : super(key: key);
  @override
  _UploadIDPageState createState() => _UploadIDPageState();
}

class _UploadIDPageState extends State<UploadIDPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerificationIdBloc>(),
      child: MobileStatusMarginTop(
          child: Stack(
        alignment: Alignment.center,
        children: [
          CustomRegularAppBar(
            backgroundColor: Colors.transparent,
            title: "Upload ID",
            body: BlocConsumer<UploadIdBloc, UploadIdState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UploadIdInitial) {
                  BlocProvider.of<UploadIdBloc>(context).add(
                    UploadIDOnView(widget.selectedImage),
                  );
                }
                if (state.selectedImage != null) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildIDSection(state.selectedImage),
                        _buildTakeAnotherPhotoButton(context),
                        _buildGuidelines(),
                        _buildUploadButton(context, state.selectedImage),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          BlocConsumer<VerificationIdBloc, VerificationIdState>(
            listener: (context, state) {
              if (state is VerificationIdUploadingImageSuccess) {
                Navigator.of(context).pushNamed(UPLOAD_ID_RESULT_ROUTE);
              }
            },
            builder: (context, state) {
              if (state is VerificationIdUploadingImageLoading) {
                return CircularProgressIndicator();
              } else if (state is VerificationIdUploadingImageFailure) {
                return CustomAlertDialog(
                  title: "Uploading Id Failed",
                  message: state.error,
                  onPostivePressed: () {
                    Navigator.pop(context);
                  },
                  positiveBtnText: 'ok',
                );
              } else {
                return Container();
              }
            },
          )
        ],
      )),
    );
  }

  Widget _buildIDSection(File selectedImage) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD6D6D6)),
        color: Color(0xFFEFF1F3),
      ),
      child: selectedImage == null
          ? Container()
          : Container(
              child: AspectRatio(
                aspectRatio: 300 / 200,
                child: Image.file(selectedImage),
              ),
            ),
    );
  }

  void uploadID() {
    ImageUtils.pickImage(
      context,
      (File file) async {
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: file.path,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [CropAspectRatioPreset.ratio7x5],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: "Change Profile Image",
                hideBottomControls: true,
                showCropGrid: true,
                toolbarColor: ColorUtil.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio7x5,
                lockAspectRatio: true),
            iosUiSettings: IOSUiSettings(
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: true,
                aspectRatioPickerButtonHidden: true,
                title: "Profile Image"));

        BlocProvider.of<UploadIdBloc>(context).add(
          UploadIDOnView(croppedFile),
        );
      },
      maxWidth: 1024,
      maxHeight: 512,
    );
  }

  Widget _buildTakeAnotherPhotoButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: SecondaryButton(
        text: "Take another picture",
        fontSize: 12,
        height: 30,
        width: 170,
        radius: 12,
        onPressed: () {
          uploadID();
        },
      ),
    );
  }

  Widget _buildGuidelines() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: <Widget>[
          HeaderText(
            title: "Before uploading your ID image, check for the following:",
            fontSize: 18,
          ),
          SizedBox(height: 10),
          _buildChecklistItem("The photo is not blurry"),
          _buildChecklistItem("The image hasn't been manupulated in any way"),
          _buildChecklistItem(
              "There is a border area around your ID and all four corners should be visible"),
        ],
      ),
    );
  }

  Container _buildChecklistItem(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              Icons.check_circle,
              color: ColorUtil.primaryColor,
              size: 12,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context, File passedImage) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40),
      child: PrimaryButton(
          text: "UPLOAD",
          onPressed: () {
            BlocProvider.of<VerificationIdBloc>(context)
                .add(VerificationIdOnUpload(passedImage));
          }),
    );
  }
}
