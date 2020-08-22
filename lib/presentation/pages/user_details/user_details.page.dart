import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/containers/title_and_content_with_divider_wrapper.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'User Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile/lalisa.jpeg'),
                      fit: BoxFit.cover)),
              width: 155,
              height: 155,
            ),
            SizedBox(height: 10),
            Text(
              'Fausto Lorem Macabantog',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: ColorUtil.primaryColor,
                  ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 10,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'VERIFIED',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 50),
            TitleAndContentWithDividerWrapper(
                title: 'Address',
                content:
                    'Purok 123, Brgy 4 Ipsum 123, Bacolod Negros Occidental'),
            TitleAndContentWithDividerWrapper(
              title: 'Age',
              content: '24',
            ),
            Spacer(),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
