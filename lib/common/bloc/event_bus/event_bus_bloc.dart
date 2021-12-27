import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_bus_event.dart';
import 'event_bus_state.dart';

class EventBusBloc extends Bloc<EventBusEvent, EventBusState> {
  EventBusBloc() : super(EventBusInitState());

  @override
  Stream<EventBusState> mapEventToState(EventBusEvent event) async* {
    switch (event.runtimeType) {
      case EventBusCheckCallEvent:
        yield EventBusCheckCallState();
        break;
      case EventBusShowCallEvent:
        yield EventBusShowCallState();
        break;
      case EventBusRequestInitDataCartEvent:
        yield EventBusRequestInitDataCartState();
        break;
      case EventBusRequestInitDataNotificationEvent:
        yield EventBusRequestInitDataNotificationState(
            count: (event as EventBusRequestInitDataNotificationEvent).count);
        break;
      case EventBusRequestInitDataPersonalEvent:
        yield EventBusRequestInitDataPersonalState();
        break;
    }
  }
}
