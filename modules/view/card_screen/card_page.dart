import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/widgets/custom_navbar.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool cardTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CustomNavBar());
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/svg/menu_icon.svg'),
                ],
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              cardTap == false
                  ? Container(
                      height: Get.height * .25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryBlue,
                                Color(0xFF007AFF),
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset('assets/svg/Logo_chip.svg'),
                                const Spacer(),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/Gold Chiip.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: Get.width * .01,
                                    ),
                                    const Text(
                                      '2',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Available',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const Column(
                              children: [
                                Text(
                                  'Pay with balance',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height * .25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryBlue,
                                Color(0xFF007AFF),
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset('assets/svg/Logo_chip.svg'),
                                const Spacer(),
                                const Text(
                                  '4112**',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Virtual VISA',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const Column(
                              children: [
                                Text(
                                  'Virtual VISA',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
              cardTap == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          cardTap = true;
                        });
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * .04,
                            ),
                            SvgPicture.asset('assets/svg/pay_Icon.svg'),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            const Text(
                              'Tap to pay',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          cardTap = false;
                        });
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * .04,
                            ),
                            SvgPicture.asset('assets/svg/pay_unavible.svg'),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            const Text(
                              'Tap to pay unavailable',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
