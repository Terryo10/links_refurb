part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionEvent {}

class GetPriceEvent extends SubscriptionEvent{}

class SubscribeEvent extends SubscriptionEvent{
  final String phoneNumber;
  final String method;

  SubscribeEvent({required this.phoneNumber, required this.method});
}

class UpdateSubscription extends SubscriptionEvent{
  final String phoneNumber;
  final String method;

  UpdateSubscription({required this.phoneNumber, required this.method});
}

class CheckPaymentEvent extends  SubscriptionEvent{
  final num orderId;

  CheckPaymentEvent(this.orderId);
}

class ResetSubscription extends SubscriptionEvent{

}