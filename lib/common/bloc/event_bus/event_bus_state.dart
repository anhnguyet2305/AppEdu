abstract class EventBusState {}

class EventBusInitState extends EventBusState {}

class EventBusCheckCallState extends EventBusState {}

class EventBusShowCallState extends EventBusState {}

class EventBusRequestInitDataCartState extends EventBusState {}

class EventBusRequestInitDataNotificationState extends EventBusState {
  int? count;

  EventBusRequestInitDataNotificationState({this.count});
}

class EventBusRequestInitDataPersonalState extends EventBusState {}
