import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBottomSheet {
  static void showBottomSheet(BuildContext context, List<ActionSheet> actions) {
    if (Platform.isAndroid) {
      showModalBottomSheet(
          context: context,
          builder: (buildContext) {
            return MaterialActionSheetWidget(actions);
          });
    } else {
      showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheetWidget(actions),
      );
    }
  }
}

class ActionSheet {
  final Function onPressed;
  final String title;

  final bool defaultAction;

  final bool destructive;

  final Widget leading;
  final popAutomatically;

  ActionSheet(this.title, this.onPressed,
      {this.defaultAction = true,
      this.popAutomatically = true,
      this.leading,
      this.destructive});
}

abstract class ActionSheetWidget extends StatelessWidget {
  final hasCancel;

  const ActionSheetWidget({Key key, this.hasCancel = true}) : super(key: key);
}

class CupertinoActionSheetWidget extends ActionSheetWidget {
  const CupertinoActionSheetWidget(
    this.actions, {
    hasCancel = true,
  }) : super(hasCancel: hasCancel);

  final List<ActionSheet> actions;

  @override
  Widget build(BuildContext context) {
    return _buildIOSActionSheet(context);
  }

  Widget _buildCupertinoLeading(Widget leading) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 35),
      child: leading,
    );
  }

  Widget _buildIOSActionSheet(BuildContext context) {
    List<CupertinoActionSheetAction> children = List();
    for (var action in actions) {
      children.add(
        CupertinoActionSheetAction(
          child: Row(
            children: <Widget>[
              action.leading != null
                  ? _buildCupertinoLeading(action.leading)
                  : SizedBox(),
              Text(
                action.title,
              )
            ],
          ),
          onPressed: () {
            if (action.popAutomatically) {
              Navigator.pop(context);
            }
            action.onPressed();
          },
          isDefaultAction: action.defaultAction,
        ),
      );
    }
    return Container(
      child: CupertinoActionSheet(
        actions: children,
        cancelButton: hasCancel
            ? CupertinoActionSheetAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
              )
            : null,
      ),
    );
  }
}

class MaterialActionSheetWidget extends ActionSheetWidget {
  const MaterialActionSheetWidget(
    this.actions, {
    hasCancel,
  }) : super(hasCancel: hasCancel);

  final List<ActionSheet> actions;

  @override
  Widget build(BuildContext context) {
    return _buildAndroidActionSheet(context);
  }

  Container _buildAndroidActionSheet(BuildContext context) {
    List<ListTile> children = List();
    for (var action in actions) {
      children.add(
        ListTile(
          leading: action.leading,
          title: new Text(
            action.title,
          ),
          onTap: () {
            if (action.popAutomatically) {
              Navigator.pop(context);
            }
            action.onPressed();
          },
        ),
      );
    }
    return Container(
      child: new Wrap(
        children: children,
      ),
    );
  }
}
