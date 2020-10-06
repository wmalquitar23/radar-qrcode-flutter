import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class RedAlertPage extends StatefulWidget {
  final dynamic qrInformation;

  const RedAlertPage({Key key, this.qrInformation}) : super(key: key);
  @override
  _RedAlertPageState createState() => _RedAlertPageState();
}

class _RedAlertPageState extends State<RedAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 43,
            child: buildImageLayer(),
          ),
          Flexible(
            flex: 43,
            child: buildDetailsLayer(),
          ),
          Flexible(
            flex: 14,
            child: buildButtonLayer(),
          )
        ],
      ),
    ));
  }

  Widget buildImageLayer() {
    return Container(
      color: ColorUtil.lightBlueBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 20,
            child: _buildHeaderTitle(),
          ),
          Flexible(
            flex: 40,
            child: _buildHeaderImage(),
          ),
          Flexible(
            flex: 20,
            child: _buildHeaderImageTitle(),
          ),
          Flexible(
            flex: 20,
            child: _buildImageDescription(),
          )
        ],
      ),
    );
  }

  Widget buildDetailsLayer() {
    return Column(
      children: [
        Flexible(
          flex: 30,
          child: _buildDetailStatus(),
        ),
        Flexible(
          flex: 70,
          child: _buildUserDetails(),
        )
      ],
    );
  }

  Widget _buildDetailStatus() {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 50,
                    child: HeaderText(
                      fontSize: 20,
                      title: "Person Status:",
                    ),
                  ),
                  Flexible(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: HeaderText(
                        fontSize: 20,
                        title: "PUI",
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 50,
                    child: HeaderText(
                      fontSize: 20,
                      title: "Advisory From:",
                    ),
                  ),
                  Flexible(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: HeaderText(
                        fontSize: 20,
                        title: "PNP Bacolod",
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 10,
            child: _builUserDetailsTitle(),
          ),
          Flexible(
            flex: 30,
            child: _buildFullNameTextField(),
          ),
          Flexible(
            flex: 30,
            child: _buildAddressTextField(),
          ),
          Flexible(
            flex: 30,
            child: _buildAgeTextField(),
          ),
        ],
      ),
    ));
  }

  Widget _builUserDetailsTitle() {
    return Container(
      child: HeaderText(
        fontSize: 20,
        title: "User Details:",
      ),
    );
  }

  Widget _buildFullNameTextField() {
    return CustomTextField(
      label: "Full Name",
      isRichText: true,
      child: TextFormField(
        controller: TextEditingController(text: "Fausto Lorem Macabantog"),
        readOnly: true,
      ),
    );
  }

  Widget _buildAddressTextField() {
    return CustomTextField(
      label: "Address",
      isRichText: true,
      child: TextFormField(
        readOnly: true,
      ),
    );
  }

  Widget _buildAgeTextField() {
    return CustomTextField(
      label: "Age",
      isRichText: true,
      child: TextFormField(
        readOnly: true,
      ),
    );
  }

  Widget buildButtonLayer() {
    return Center(
      child: PrimaryButton(
        width: 280,
        text: "REPORT",
        color: Colors.red,
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Center(
      child: HeaderText(title: "Alert", fontSize: 26, color: Colors.black),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: Container(
        alignment: Alignment(-0.05, 0),
        child: ExtendedImage.asset(
          'assets/images/undraw/virus_alert@3x.png',
          width: 150,
        ),
      ),
    );
  }

  Widget _buildHeaderImageTitle() {
    return Center(
      child: HeaderText(
        title: "RED ALERT!",
        fontSize: 40,
        color: Colors.red,
      ),
    );
  }

  Widget _buildImageDescription() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: DescriptionText(
          fontSize: 18,
          color: Colors.black,
          title: "Please read the information below and act accordingly.",
        ),
      ),
    );
  }
}
