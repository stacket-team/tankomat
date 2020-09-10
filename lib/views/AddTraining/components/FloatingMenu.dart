import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class FloatingMenu extends StatelessWidget {
  final int show;
  final Function onGroup;
  final Function onRemove;

  FloatingMenu(this.show, this.onGroup, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return show > 0
        ? Stack(
            children: <Widget>[
              show > 1
                  ? Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: FloatingActionButton(
                        heroTag: null,
                        onPressed: onGroup,
                        child: Icon(Icons.link),
                        backgroundColor: PRIMARY_COLOR,
                      ),
                    )
                  : Container(),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                bottom: show > 1 ? 80.0 : 10.0,
                right: 10.0,
                child: FloatingActionButton(
                  heroTag: null,
                  mini: show > 1,
                  onPressed: onRemove,
                  child: Icon(Icons.delete),
                  backgroundColor: PRIMARY_COLOR,
                ),
              ),
            ],
          )
        : Container();
  }
}
