import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signally/models_services/firestore_service.dart';

import '../models/announcement.dart';
import '../models/app_control.dart';
import '../models/signal.dart';
import 'auth_provider.dart';

class AppProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /* -------------------------------- NOTE Init ------------------------------- */
  bool _isInitializedAuthProvider = false;

  AuthProvider? _authProvider;
  AuthProvider? get authProvider => _authProvider;
  set authProvider(AuthProvider? authProvider) {
    _authProvider = authProvider;

    if (_authProvider?.authUser != null && !_isInitializedAuthProvider) {
      streamAppControl();
      streamSignals();
      streamAnnouncements();
      _isInitializedAuthProvider = true;
    }

    if (_authProvider?.authUser == null) {
      _isInitializedAuthProvider = false;
    }
  }

  /* ---------------------------- NOTE APP CONTROLL --------------------------- */
  AppControl _appControl = AppControl();
  AppControl get appControl => _appControl;
  StreamSubscription<AppControl>? _streamSubscriptionAppControl;

  void streamAppControl() {
    var res = FirestoreService.streamAppControl();
    _streamSubscriptionAppControl = res.listen((event) async {
      _appControl = event;
    });
  }

  void cancleStreamAppControl() {
    _streamSubscriptionAppControl?.cancel();
  }

  /* ----------------------------- NOTE SIGNALS ---------------------------- */
  List<Signal> _signals = [];
  List<Signal> get signals => _signals;

  void streamSignals() {
    var res = FirestoreService.streamSignals();
    res.listen((event) {
      _signals = event;
      notifyListeners();
    });
  }

  /* ---------------------------- NOTE ANNOUCEMENTS --------------------------- */
  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  void streamAnnouncements() {
    var res = FirestoreService.streamAnnouncements();
    res.listen((event) {
      _announcements = event;
      notifyListeners();
    });
  }
}
