import 'package:flutter/material.dart';

class GenderCustomDialog extends StatefulWidget {
  final String genderValue;

  GenderCustomDialog({this.genderValue});

  @override
  State<StatefulWidget> createState() {
    return GenderCustomDialogState();
  }
}

class GenderCustomDialogState extends State<GenderCustomDialog> {
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
                  "Indicate your gender",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'Female',
                    groupValue: widget.genderValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "Female",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'Male',
                    groupValue: widget.genderValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "Male",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }
}
