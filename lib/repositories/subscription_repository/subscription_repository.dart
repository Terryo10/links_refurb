import 'package:link_refurb/models/payments_model/payment_check_model.dart';
import 'package:link_refurb/models/payments_model/payments_model.dart';
import 'package:link_refurb/models/price_model/price_model.dart';
import 'package:link_refurb/repositories/subscription_repository/subscription_provider.dart';

class SubscriptionRepository{
  final SubscriptionProvider subscriptionProvider;

  SubscriptionRepository({required this.subscriptionProvider});

  Future<PriceModel> getPrice()async{
    var data = await subscriptionProvider.getPrice();

    return priceModelFromJson(data);
  }

  Future<PaynowResponseModel> makePayment({required String phoneNumber, required String method})async{
    var data = await subscriptionProvider.makePayment(phoneNumber: phoneNumber, method: method);
    return paynowResponseModelFromJson(data);
  }

  Future<PaymentCheckModel> checkPayment({required num orderId})async{
    var data = await subscriptionProvider.checkPayment(orderId: orderId);
    return paymentCheckModelFromJson(data);
  }
  
}