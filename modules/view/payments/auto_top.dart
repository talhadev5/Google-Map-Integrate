import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/payments/sueesespage.dart';
import 'package:tophotels/modules/viewmodel/paymentlogic.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class AutoToppage extends StatelessWidget {
  AutoToppage({super.key});
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      controller.status.value == 'setup'
                          ? 'Setup auto top up'
                          : 'Edit auto top up',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/frequenty.svg'),
                        SizedBox(
                          width: Get.width * .02,
                        ),
                        const Text(
                          'Frequenty',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller
                                .selectIndex(0), // Select first container
                            child: Obx(() {
                              return Container(
                                height: Get.height * .07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.selectedIndex.value == 0
                                      ? AppColors.primaryBlue.withOpacity(0.1)
                                      : AppColors.white,
                                  border: Border.all(
                                    color: controller.selectedIndex.value == 0
                                        ? AppColors.primaryBlue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Each week',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(width: Get.width * .02),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller
                                .selectIndex(1), // Select second container
                            child: Obx(() {
                              return Container(
                                height: Get.height * .07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.selectedIndex.value == 1
                                      ? AppColors.primaryBlue.withOpacity(0.1)
                                      : AppColors.white,
                                  border: Border.all(
                                    color: controller.selectedIndex.value == 1
                                        ? AppColors.primaryBlue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Each month',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.paid_outlined,
                          color: AppColors.primaryBlue,
                        ),
                        SizedBox(
                          width: Get.width * .02,
                        ),
                        const Text(
                          'Amount',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.amounts.asMap().entries.map((entry) {
                        int index = entry.key;
                        String amount = entry.value;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.selectAmount(index);
                              controller.update();
                            },
                            child: Obx(() {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: Get.height * .07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.selectedAmount.value ==
                                          index
                                      ? AppColors.primaryBlue.withOpacity(0.1)
                                      : AppColors.white,
                                  border: Border.all(
                                    color:
                                        controller.selectedAmount.value == index
                                            ? AppColors.primaryBlue
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    amount,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Get.height * .03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/selcet_payment.svg'),
                        SizedBox(
                          width: Get.width * .02,
                        ),
                        const Text(
                          'Select a payment method',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                      title: controller.status.value == 'setup'
                          ? 'Complete auto top up'
                          : 'Update auto top up',
                      backgroundColor: AppColors.primaryBlue,
                      onTap: () {
                        controller.status.value == 'setup'
                            ? controller.toggleStatus()
                            : Get.to(() => SuccessPage(
                                  auto: 'auto',
                                ));
                        controller.update();
                      },
                      textColor: AppColors.black,
                      borderSideColor: Colors.transparent,
                    ),
                  ),
                  controller.status.value == 'setup'
                      ? const SizedBox()
                      : Center(
                          child: TextButton(
                            onPressed: () {
                              controller.toggleStatus();
                              controller.update();
                            },
                            child: const Text(
                              'Delete auto top up',
                              style: TextStyle(color: AppColors.red),
                            ),
                          ),
                        )
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
