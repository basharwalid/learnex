import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:learnex/data/model/payment/Payment_intention_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_api_client.g.dart';

@RestApi(baseUrl: ApiConstants.payMobApiBaseRoute)
abstract class PaymentApiClient {
  @factoryMethod
  factory PaymentApiClient(Dio dio) = _PaymentApiClient;

  @POST(ApiConstants.paymentRoute)
  Future<void> paymentWebhook(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.payMobIntentionRoute)
  Future<PaymentIntentionDto> createPaymentIntention(
    @Body() Map<String, dynamic> body,
  );
}
