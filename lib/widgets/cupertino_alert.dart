   import 'package:flutter/cupertino.dart';

Future showAlertDialog(
  { @required BuildContext? context,
  @required String? title,
  @required String? content,
  String? cancelActionText,
  @required String? defaultActionText,}
){
   return showCupertinoDialog(
    context: context!,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText!),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}