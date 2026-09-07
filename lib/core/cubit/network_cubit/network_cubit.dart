import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';

import '../../services/network_services.dart';

part 'network_state.dart';


class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkInitial()) {
    _listenToConnection();
  }

  final NetworkService _networkService = NetworkService();

  StreamSubscription<bool>? _subscription;

  Future<void> _listenToConnection() async {
    final hasInternet = await _networkService.hasInternet();

    emit(
      hasInternet
          ? NetworkConnected()
          : NetworkDisconnected(),
    );

    _subscription = _networkService.onStatusChange.listen((hasInternet) {
      emit(
        hasInternet
            ? NetworkConnected()
            : NetworkDisconnected(),
      );
    });
  }

  Future<void> checkConnection() async {
    emit(NetworkLoading());

    final hasInternet = await _networkService.hasInternet();

    emit(
      hasInternet
          ?  NetworkConnected()
          :  NetworkDisconnected(),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}