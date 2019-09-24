import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:cached_network_image/cached_network_image.dart';

class LoadingIndicator extends StatelessWidget {
  
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: ManageDeviceInfo.resolutionHeight * .25,
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class BuildAlertDialog extends StatelessWidget {
  BuildAlertDialog(this.textMessage);
  final String textMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new BuildAboutText(textMessage),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}

class BuildAboutText extends StatelessWidget {
  BuildAboutText(this.textMessage);
  final String textMessage;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: new TextSpan(
        text: textMessage == null ? 'This feature is coming soon.\n\n' : textMessage,
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: ' '),
          new TextSpan(
            text: ' ',
          ),
          const TextSpan(
            text: ' ',
          ),
          new TextSpan(
            text: '- by Sparky Toons',
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
