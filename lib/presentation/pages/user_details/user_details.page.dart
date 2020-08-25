import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    _addressController.text = "Purok 123, Brgy 4, Bacolod Negros Occ.";
    _ageController.text = "24";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "User Details",
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImage(),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: HeaderText(
                    title: "Lalisa Manoban",
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
                    Container(
                      child: ExtendedImage.asset(
                        'assets/images/undraw/success.png',
                        width: 15,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    DescriptionText(
                      title: "VERIFIED",
                      color: ColorUtil.primaryTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                _buildAddressTextField(),
                _buildAgeTextField(),
              ],
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

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 120.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CircleImage(
                imageUrl: "assets/images/profile/lalisa.jpeg",
                size: 120.0,
                fromNetwork: false,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorUtil.primaryBackgroundColor,
                    shape: BoxShape.circle),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PrimaryButton(
              text: 'APPROVE',
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PrimaryButton(
              text: 'DECLINE',
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
