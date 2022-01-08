import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = 'Reset']);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(50.0),
      title: Text(title, style: TextStyle(color: Colors.yellow)),
      content: Text(
        content,
      ),
      // backgroundColor: MainColor.secondaryColor,
      actions: [
        ElevatedButton.icon(
            icon: Icon(
              Icons.replay,
              color: Colors.red,
            ),
            onPressed: callback,
            label: Text(actionText, style: TextStyle(color: Colors.red)),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0)
                //padding: Material,StateProperty.all(EdgeInsets.all(50)),
                //  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))
                )),
      ],
    );
  }
}
