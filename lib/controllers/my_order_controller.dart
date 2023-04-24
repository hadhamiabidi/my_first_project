import 'package:get/get.dart';
import 'package:pfe/models/claim_model.dart';

import '../models/all_orders_model.dart';



class MyOrderController extends GetxController {
  final List <Claim> orders = [
    Order(
      title: 'Order 1',
      description: 'Description for order 1',
      date: '2022-01-01',
    ),
    Order(
      title: 'Order 2',
      description: 'Description for Order 2',
      date: '2022-02-01',
    ),
    Order(
      title: 'Order 3',
      description: 'Description for Order 3',
      date: '2022-03-01',
    ),
  ].obs as List<Claim>;

}