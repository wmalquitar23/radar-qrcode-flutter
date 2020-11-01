import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/fields/custom_textfield.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class DesignatedAreaCustomDialog extends StatefulWidget {
  final String designatedAreaValue;

  DesignatedAreaCustomDialog({this.designatedAreaValue});

  @override
  State<StatefulWidget> createState() {
    return DesignatedAreaCustomDialogState();
  }
}

class DesignatedAreaCustomDialogState
    extends State<DesignatedAreaCustomDialog> {
  TextEditingController _designatedAreaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(),
    );
  }

  dialogContent() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 66.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Text(
                  "Designated Area",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                label: "",
                child: TextFormField(
                  controller: _designatedAreaController,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: DescriptionText(
                            title: "Cancel",
                            color: ColorUtil.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop(_designatedAreaController.text);
                          },
                          child: DescriptionText(
                            title: "Save",
                            color: ColorUtil.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ],
    );
  }
}
