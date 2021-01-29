
import 'package:GitHubSearch/shared/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

displayDialog({BuildContext context, String heading, String body, String type, String navigateTo}){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => CustomDialog(heading: heading, body: body, dialogType: type, navigateTo: navigateTo)
    );
}
 