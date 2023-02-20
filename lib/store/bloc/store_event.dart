
abstract class StoreEvent {
  const StoreEvent();
}

class StoreProductsRequested extends StoreEvent {}

class StoreProductsAddedToCart extends StoreEvent {
  final int cartId;
  StoreProductsAddedToCart({required this.cartId});
}

class StoreProductsRemovedFromCart extends StoreEvent {
  final int cartId;

  StoreProductsRemovedFromCart({required this.cartId});
}
