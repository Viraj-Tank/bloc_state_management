# bloc_state_management

Bloc State Management

add Bloc generic class
Bloc<Event,ReceiverSide>

Event -> these event we can invoke and set business login accordingly
ReceiverSide -> state which we can read/watch on the receiver side (it will return that data type)

// it will change the data inside the bloc or and we can read its property
context.read<CounterBloc>().state

// it will change the data inside the bloc or and it will also update property at the receiver side
// watch detects the changes and rebuild the widget with updated value
context.watch<CounterBloc>().state

BlocBuilder widget is used to render only the particular widget and not the whole screen
