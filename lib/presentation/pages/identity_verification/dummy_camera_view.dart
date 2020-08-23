import 'package:flutter/material.dart';

import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/light_text.dart';

class DummyCameraViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF393939),
          centerTitle: true,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Submit your ID",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.camera),
          backgroundColor: Colors.grey,
          onPressed: () => Navigator.of(context).pushNamed(UPLOAD_ID_ROUTE),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      color: Color(0xFF393939),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LightText(text: "Place your ID within the frame"),
          _buildCamPreview(context),
        ],
      ),
    );
  }

  Widget _buildCamPreview(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/undraw/dummy-background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/images/undraw/sample-id.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
