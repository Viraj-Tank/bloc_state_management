import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_state_management/store/store_repository.dart';

import '../models/product.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StoreEvent>((event, emit) {});
  }

  final StoreRepository api = StoreRepository();

  _handleStoreProductsRequested(
    StoreProductsRequested event,
    Emitter<StoreState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: StoreRequest.requestInProgress));
      final response = await api.getProducts();
      if (response.isNotEmpty) {
        emit(state.copyWith(productStatus: StoreRequest.requestSuccess,products: response));
      } else {
        emit(state.copyWith(productStatus: StoreRequest.requestFailed));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.requestFailed));
    }
  }
}
