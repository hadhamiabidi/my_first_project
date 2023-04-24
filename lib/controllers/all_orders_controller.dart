import 'package:get/get.dart';
import 'package:pfe/models/claim_model.dart';

import '../models/all_orders_model.dart';



class AllOrdersController extends GetxController {
  final List <Claim> orders = [
    Order(
      title: 'Colis 1',
      description: 'Description for order 1',
      date: '2022-01-01',
    ),
    Order(
      title: 'Colis 2',
      description: 'Description for Order 2',
      date: '2022-02-01',
    ),
    Order(
      title: 'Colis 3',
      description: 'Description for Order 3',
      date: '2022-03-01',
    ),
  ].obs as List<Claim>;

}