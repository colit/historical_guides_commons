import 'dart:async';

import 'package:flutter/material.dart';

class ModalViewService {
  late Function(Widget) _showDialogListener;
  late Function() _closeDialogListener;
  late Completer _dialogCompleter;

  void registerViewListener({
    required Function(Widget) opener,
    required Function() completer,
  }) {
    _showDialogListener = opener;
    _closeDialogListener = completer;
  }

  Future show(Widget content) {
    _showDialogListener(content);
    _dialogCompleter = Completer();
    return _dialogCompleter.future;
  }

  void close() {
    _closeDialogListener();
    _dialogCompleter.complete();
    // _dialogCompleter = null;
  }
}
