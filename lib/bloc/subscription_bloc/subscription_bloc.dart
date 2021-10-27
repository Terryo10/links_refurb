import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:link_refurb/models/payments_model/payment_check_model.dart';
import 'package:link_refurb/models/payments_model/payments_model.dart';
import 'package:link_refurb/models/price_model/price_model.dart';
import 'package:link_refurb/repositories/subscription_repository/subscription_repository.dart';

import 'package:meta/meta.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;
  SubscriptionBloc({required this.subscriptionRepository})
      : super(SubscriptionInitial());

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is GetPriceEvent) {
      yield SubscriptionPriceLoadingState();
      try {
        print('getting prices');
        var data = await subscriptionRepository.getPrice();
        yield SubscriptionPriceLoadedState(priceModel: data);
      } catch (e) {
        yield SubscriptionErrorState(message: e.toString());
      }
    }

    if (event is SubscribeEvent) {
      yield SubscriptionPayingState();
      try {
        print('making payment');
        var data = await subscriptionRepository.makePayment(
            phoneNumber: event.phoneNumber, method: event.method);
        yield SubscriptionPaidState(paynowResponseModel: data);
      } catch (e) {
        yield SubscriptionErrorState(message: e.toString());
      }
    }

    if (event is CheckPaymentEvent) {
      yield CheckingPaymentState();
      try {
        print('checking payment');
        var data =
            await subscriptionRepository.checkPayment(orderId: event.orderId);
        yield PaymentCheckedState(paymentCheckModel: data);
      } catch (e) {
        yield SubscriptionErrorState(message: e.toString());
      }
    }

    if (event is ResetSubscription) {
      yield SubscriptionInitial();
    }
  }
}
