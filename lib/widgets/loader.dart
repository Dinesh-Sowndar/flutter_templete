import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {
  start(context) {
    Loader.show(context!,
        progressIndicator: SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: 70.0,

        ));
  }

  stop() {
    Loader.hide();
  }
}
