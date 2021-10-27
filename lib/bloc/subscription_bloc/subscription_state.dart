part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionPriceLoadingState extends SubscriptionState{}

class SubscriptionPriceLoadedState extends SubscriptionState{
  final PriceModel? priceModel;

  SubscriptionPriceLoadedState({@required this.priceModel});
}

class SubscriptionPayingState extends SubscriptionState{}

class SubscriptionPaidState extends SubscriptionState{
  final PaynowResponseModel paynowResponseModel;

  SubscriptionPaidState({required this.paynowResponseModel});
}

class SubscriptionErrorState extends SubscriptionState{
  final String message;

  SubscriptionErrorState({required this.message});
}

class CheckingPaymentState extends SubscriptionState{
}


class PaymentCheckedState extends SubscriptionState{
  final PaymentCheckModel paymentCheckModel;

  PaymentCheckedState({required this.paymentCheckModel});
}