import 'package:bloc_state_management/store/bloc/store_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/store_event.dart';
import '../bloc/store_state.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      home: BlocProvider(
        create: (context) => StoreBloc(),
        child: _storeAppView(
          title: 'Store App',
        ),
      ),
    );
  }
}

class _storeAppView extends StatefulWidget {
  String title;

  _storeAppView({Key? key, required this.title}) : super(key: key);

  @override
  State<_storeAppView> createState() => _storeAppViewState();
}

class _storeAppViewState extends State<_storeAppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            switch (state.productStatus) {
              case StoreRequest.requestInProgress:
                return const CircularProgressIndicator();
              case StoreRequest.requestSuccess:
                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          child: Column(
                            children: [
                              Flexible(child: Image.network(product.image)),
                              Text(
                                product.name,
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                                maxLines: 4,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Add to cart'),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              case StoreRequest.requestFailed:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Problem loading products'),
                    OutlinedButton(
                      onPressed: () {
                        context.read<StoreBloc>().add(StoreProductsRequested());
                      },
                      child: const Text('Try again'),
                    )
                  ],
                );
              case StoreRequest.unknown:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No products loaded'),
                    OutlinedButton(
                      onPressed: () {
                        context.read<StoreBloc>().add(StoreProductsRequested());
                      },
                      child: const Text('Load products'),
                    )
                  ],
                );
              default:
                return const Text('Switch case default case');
            }
          },
        ),
      ),
    );
  }

  addToCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductsAddedToCart(cartId: cartId));
  }

  removeFromCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductsRemovedFromCart(cartId: cartId));
  }
}
