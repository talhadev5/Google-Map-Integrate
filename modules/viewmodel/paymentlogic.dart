import 'package:get/get.dart';

class Paymentlogic extends GetxController {
  final List<Map<String, String>> cardata = [
    {
      'title': 'Topup',
      'image': 'assets/svg/paypal.png',
      'tralling': '+15\$',
    },
    {
      'title': 'Topup',
      'image': 'assets/svg/master_pay.png',
      'tralling': '+15\$',
    },
    {
      'title': 'Topup',
      'image': 'assets/svg/master_pay.png',
      'tralling': '+15\$',
    },
    {
      'title': 'Topup',
      'image': 'assets/svg/apple_pay.png',
      'tralling': '+15\$',
    },
  ];
  String selectedPaymentMethod = '';
    // List of options
  final List<String> amounts = ['\$5', '\$10', '\$20', '\$40', '\$50'];
  RxInt selectedIndex = (0).obs;

  // Update the selected index
  void selectIndex(int index) {
    selectedIndex.value = index;
  }
  RxInt selectedAmount = (0).obs;

  // Update the selected index
  void selectAmount(int index) {
  selectedAmount.value = index;
  }
  var status = 'setup'.obs; 
    void toggleStatus() {
    if (status.value == 'setup') {
      status.value = 'update'; // Switch to "Update auto top up" mode
    } else {
      status.value = 'setup'; // Switch back to "Setup auto top up" mode
    }
  }
}
