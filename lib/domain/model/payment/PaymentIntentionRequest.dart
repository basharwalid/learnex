import 'package:learnex/domain/model/payment/bailling_address.dart';
import 'package:learnex/domain/model/payment/payment_item.dart';

class PaymentIntentionRequest {
  final int amount;
  final String currency;
  final List<int> paymentMethods;
  final List<PaymentItem> items;
  final BillingData billingData;
  final String specialReference;
  final int expiration;
  final String notificationUrl;
  final String redirectionUrl;

  PaymentIntentionRequest({
    required this.amount,
    required this.currency,
    required this.paymentMethods,
    required this.items,
    required this.billingData,
    required this.specialReference,
    required this.expiration,
    required this.notificationUrl,
    required this.redirectionUrl,
  });

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'currency': currency,
    'payment_methods': paymentMethods,
    'items': items.map((e) => e.toJson()).toList(),
    'billing_data': billingData.toJson(),
    'special_reference': specialReference,
    'expiration': expiration,
    'notification_url': notificationUrl,
    'redirection_url': redirectionUrl,
  };
}



