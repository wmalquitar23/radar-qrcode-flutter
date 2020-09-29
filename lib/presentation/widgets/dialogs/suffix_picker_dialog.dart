import 'package:flutter/material.dart';

class SuffixPickerDialog extends StatefulWidget {
  final String selectedValue;

  SuffixPickerDialog({this.selectedValue});

  @override
  State<StatefulWidget> createState() {
    return SuffixPickerDialogState();
  }
}

class SuffixPickerDialogState extends State<SuffixPickerDialog> {
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
                  "Select suffix (Name)",
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
                    value: '',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "None",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'I',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "I",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'II',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "II",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'III',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "III",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'JR',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "JR",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'SR',
                    groupValue: widget.selectedValue,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                  Text(
                    "SR",
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
