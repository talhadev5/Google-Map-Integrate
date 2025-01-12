import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/payments/auto_top.dart';
import 'package:tophotels/modules/view/payments/paypal_payment.dart';
import 'package:tophotels/modules/viewmodel/paymentlogic.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});
  final controller = Get.put(Paymentlogic());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Paymentlogic>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
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
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Payments',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/svg/Frame_back.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '15.25',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Available to spend ',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    title: 'Topup Chiip balance',
                    backgroundColor: AppColors.primaryBlue,
                    onTap: () {
                      Get.to(() => PaypalPayment());
                    },
                    textColor: AppColors.black,
                    borderSideColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    title: 'Configure auto topup',
                    backgroundColor: AppColors.white,
                    onTap: () {
                      Get.to(() => AutoToppage());
                    },
                    textColor: AppColors.grey,
                    borderSideColor: AppColors.grey.withOpacity(0.3),
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'History',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.cardata.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = controller.cardata[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: ListTile(
                        onTap: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: AppColors.white,
                        leading: Image.asset(data['image'].toString()),
                        title: Text(
                          data['title'].toString(),
                          style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text(
                          '02/02/2023',
                          style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          data['tralling'].toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.green,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
