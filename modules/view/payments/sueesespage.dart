import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/payments/auto_top.dart';
import 'package:tophotels/modules/widgets/custom_navbar.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class SuccessPage extends StatelessWidget {
  String? auto;
  SuccessPage({super.key, this.auto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset('assets/svg/suess_icon.svg')),
            SizedBox(
              height: Get.height * .03,
            ),
            Text(
              auto == 'auto' ? 'Auto top up complete' : 'Topup successful',
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * .02,
            ),
            Center(
              child: Text(
                auto == 'auto'
                    ? 'Your auto top-up has been set up.'
                    : 'Your balance has been successfully\n updated from \$10 to \$45.',
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: auto == 'auto' ? 'Go to my wallet' : 'Go to balance',
                backgroundColor: AppColors.primaryBlue,
                onTap: () {
                  auto == 'auto'
                      ? Get.to(() => const CustomNavBar())
                      : Get.to(() => const CustomNavBar());
                },
                textColor: AppColors.black,
                borderSideColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
