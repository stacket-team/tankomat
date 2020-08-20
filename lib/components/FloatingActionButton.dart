import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class AddInfoButton extends StatefulWidget {
  final Function handleFabButtonPress;
  AddInfoButton({
    this.handleFabButtonPress,
  });

  @override
  _AddInfoButtonState createState() =>
      _AddInfoButtonState(handleFabButtonPress);
}

class _AddInfoButtonState extends State<AddInfoButton> {
  final Function handleFabButtonPress;
  _AddInfoButtonState(this.handleFabButtonPress);

  bool showFabButton = true;

  void handleShowFabButton(bool value) {
    setState(() {
      showFabButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showFabButton
        ? FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: PRIMARY_COLOR,
            onPressed: () {
              PersistentBottomSheetController bottomSheetController =
                  handleFabButtonPress(context);
              handleShowFabButton(false);
              bottomSheetController.closed.then((value) {
                handleShowFabButton(true);
              });
            },
          )
        : Container();
  }
}
