import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/payments/sueesespage.dart';
import 'package:tophotels/modules/viewmodel/paymentlogic.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class PaypalPayment extends StatelessWidget {
  PaypalPayment({super.key});

  final controller = Get.put(Paymentlogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Paymentlogic>(builder: (controller) {
      return Scaffold(
        body: Scaffold(
          backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.navigate_before),
                                Text(
                                  'Go back',
                                  style: TextStyle(color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Topup balance',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Image.asset(
                          'assets/svg/Frame_back.png',
                          width: double.infinity,
                        ),
                      ),
                      const Positioned(
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '\$',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '15.25',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Current balance ',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.grey,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * .02),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Choose amount to add',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      tileColor: AppColors.white,
                      title: Text(
                        '\$',
                        style: TextStyle(color: AppColors.black),
                      ),
                      subtitle: Text(
                        '25',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .03),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Select a payment method',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  _buildPaymentTile(
                    'Paypal',
                    'assets/svg/paypal.png',
                    'Paypal',
                    controller,
                  ),
                  _buildPaymentTile(
                    'Credit Card',
                    'assets/svg/master_pay.png',
                    'Credit Card',
                    controller,
                  ),
                  _buildPaymentTile(
                    'App Card',
                    'assets/svg/apple_pay.png',
                    'App Card',
                    controller,
                  ),
                  SizedBox(
                    height: Get.height * .06,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      title: 'Go to payment page',
                      backgroundColor: AppColors.primaryBlue,
                      onTap: () {
                        Get.to(() => SuccessPage());
                      },
                      textColor: AppColors.black,
                      borderSideColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPaymentTile(
      String method, String assetPath, String title, Paymentlogic controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: GestureDetector(
        onTap: () {
          controller.selectedPaymentMethod = method;
          controller.update();
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: controller.selectedPaymentMethod == method
                  ? AppColors.primaryBlue
                  : Colors.transparent,
              width: 1,
            ),
          ),
          tileColor: controller.selectedPaymentMethod == method
              ? AppColors.primaryBlue.withOpacity(0.1)
              : Colors.white,
          leading: Image.asset(assetPath),
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

}
