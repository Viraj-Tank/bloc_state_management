import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_state_management/store/bloc/store_event.dart';
import 'package:bloc_state_management/store/bloc/store_state.dart';
import 'package:bloc_state_management/store/store_repository.dart';

import '../models/product.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StoreProductsRequested>(_handleStoreProductsRequested);
    on<StoreProductsAddedToCart>(_handleStoreProductsAddedToCart);
    on<StoreProductsRemovedFromCart>(_handleStoreProductsRemovedFromCart);
  }

  final StoreRepository api = StoreRepository();

  Future<void> _handleStoreProductsRequested(
    StoreProductsRequested event,
    Emitter<StoreState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: StoreRequest.requestInProgress));
      final response = await api.getProducts();
      if (response.isNotEmpty) {
        emit(state.copyWith(productStatus: StoreRequest.requestSuccess, products: response));
      } else {
        emit(state.copyWith(productStatus: StoreRequest.requestFailed));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.requestFailed));
    }
  }

  FutureOr<void> _handleStoreProductsAddedToCart(StoreProductsAddedToCart event, Emitter<StoreState> emit) {
    emit(state.copyWith(cartIds: {...state.cartIds, event.cartId}));
  }

  FutureOr<void> _handleStoreProductsRemovedFromCart(StoreProductsRemovedFromCart event, Emitter<StoreState> emit) {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.cartId)));
  }
}
