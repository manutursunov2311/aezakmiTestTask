import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart' show ConnectivityResult, Connectivity;
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore(this._connectivity);

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivityStream;

  @observable
  bool isOffline = false;

  @action
  Future<void> start() async {
    final results = await _connectivity.checkConnectivity();
    isOffline = results.contains(ConnectivityResult.none);

    _connectivityStream = _connectivity.onConnectivityChanged.listen((results) {
      isOffline = results.contains(ConnectivityResult.none);
    });
  }

  Future<void> stop() async {
    await _connectivityStream?.cancel();
    _connectivityStream = null;
  }

  Future<void> dispose() => stop();
}
