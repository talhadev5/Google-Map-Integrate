import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/card_screen/card_page.dart';
import 'package:tophotels/modules/widgets/custom_navbar.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class ChipLogic extends GetxController {
  // variable.........
  int selectedChipIndex = -1;
  int quantity = 0;
  String messageText = ""; // Holds the text entered by the user

  bool get isSendNowEnabled => selectedChipIndex != -1 && quantity > 0;

  void updateMessageText(String text) {
    messageText = text;
    update(); // Notify the UI to rebuild
  }

  void selectChip(int index) {
    selectedChipIndex = index;
    update();
  }

  final List<Map<String, String>> chipData = [
    {
      'title': 'Silver Chiip',
      'subtitle': '1 Silver Chiip is equivalent to \$1.',
      'image': 'assets/svg/Silver Chiip.svg',
      'price': '1\$',
    },
    {
      'title': 'Gold Chiip',
      'subtitle': '1 Gold Chiip is equivalent to \$2.',
      'image': 'assets/svg/Gold Chiip.svg',
      'price': '2\$',
    },
    {
      'title': 'Diamond Chiip',
      'subtitle': '1 Diamond Chiip is equivalent to \$5.',
      'image': 'assets/svg/Diamond Chiip.svg',
      'price': '5\$',
    },
  ];

  openMessageSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      isScrollControlled: true, // Makes the bottom sheet height flexible
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedPadding(
                padding: MediaQuery.of(context)
                    .viewInsets, // Dynamically adjust for keyboard
                duration: const Duration(milliseconds: 300), // Smooth animation
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/svg/dots_icon.png')),
                        // Header Section
                        const Text(
                          'Personalize Message',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'It seems that you are sending Chiip(s) to a person who is not in your friend list.',
                          style: TextStyle(fontSize: 14, color: AppColors.grey),
                        ),
                        const SizedBox(height: 16),
                        // Note to Receiver Section
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.white),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  color: AppColors.grey.withOpacity(0.5),
                                )
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/svg/file_icon.png'),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Note to receiver',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'optional',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                maxLines: 2,
                                maxLength: 160,
                                decoration: InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Action Buttons
                        CustomButton(
                          title: 'Send Chip(s)',
                          backgroundColor: AppColors.primaryBlue,
                          onTap: () {
                            Get.to(() => CustomNavBar());
                          },
                          textColor: AppColors.black,
                          borderSideColor: Colors.transparent,
                        ),

                        const SizedBox(height: 12),
                        CustomButton(
                          title: 'Go Back',
                          backgroundColor: AppColors.white,
                          onTap: () {
                            Get.back();
                          },
                          textColor: AppColors.grey,
                          borderSideColor: AppColors.grey.withOpacity(0.3),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  //  recive chiip bottom shet........
  reciveChiipSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      isScrollControlled: true, // Makes the bottom sheet height flexible
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedPadding(
                padding: MediaQuery.of(context)
                    .viewInsets, // Dynamically adjust for keyboard
                duration: const Duration(milliseconds: 300), // Smooth animation
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      gradient: RadialGradient(
                          radius: 0.7,
                          center: Alignment.topCenter,
                          colors: [
                            AppColors.primaryBlue.withOpacity(0.3),
                            AppColors.white
                          ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Section
                          Align(
                              alignment: Alignment.center,
                              child: Image.asset('assets/svg/dots_icon.png')),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          Image.asset('assets/svg/read_chiip.png'),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          const Text(
                            'You received a Chiip ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Talha sent you 2 gold Chiips to redeem. Don't forget to thank Talha for the gift",
                            style:
                                TextStyle(fontSize: 14, color: AppColors.black),
                          ),
                          SizedBox(
                            height: Get.height * .05,
                          ),
                          // Action Buttons
                          CustomButton(
                            title: 'Redeem Chiip',
                            backgroundColor: AppColors.primaryBlue,
                            onTap: () {
                              requestDrinkSheet();
                            },
                            textColor: AppColors.black,
                            borderSideColor: Colors.transparent,
                          ),

                          const SizedBox(height: 12),
                          CustomButton(
                            title: 'Decline Chiip',
                            backgroundColor: AppColors.white,
                            onTap: () {
                              Get.back();
                            },
                            textColor: AppColors.grey,
                            borderSideColor: AppColors.grey.withOpacity(0.3),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  //  request drink chiip bottom shet........
  requestDrinkSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      isScrollControlled: true, // Makes the bottom sheet height flexible
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedPadding(
                padding: MediaQuery.of(context)
                    .viewInsets, // Dynamically adjust for keyboard
                duration: const Duration(milliseconds: 300), // Smooth animation
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                          radius: 0.7,
                          center: Alignment.topCenter,
                          colors: [
                            AppColors.primaryBlue.withOpacity(0.3),
                            AppColors.white
                          ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Section
                          Align(
                              alignment: Alignment.center,
                              child: Image.asset('assets/svg/dots_icon.png')),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          Image.asset('assets/svg/read_chiip.png'),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          const Text(
                            'Talha requested a drink',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Talha has requested a drink. This is an excellent way to initiate a conversation.",
                            style:
                                TextStyle(fontSize: 16, color: AppColors.black),
                          ),
                          SizedBox(
                            height: Get.height * .05,
                          ),
                          // Action Buttons
                          CustomButton(
                            title: 'Gift drink(s)',
                            backgroundColor: AppColors.primaryBlue,
                            onTap: () {
                              Get.to(() => CardPage());
                            },
                            textColor: AppColors.black,
                            borderSideColor: Colors.transparent,
                          ),

                          const SizedBox(height: 12),
                          CustomButton(
                            title: 'Decline',
                            backgroundColor: AppColors.white,
                            onTap: () {
                              Get.back();
                            },
                            textColor: AppColors.grey,
                            borderSideColor: AppColors.grey.withOpacity(0.3),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

// merchent ...........
  merchentSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      isScrollControlled: true, // Makes the bottom sheet height flexible
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedPadding(
                padding: MediaQuery.of(context)
                    .viewInsets, // Dynamically adjust for keyboard
                duration: const Duration(milliseconds: 300), // Smooth animation
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                          radius: 0.7,
                          center: Alignment.topCenter,
                          colors: [
                            AppColors.primaryBlue.withOpacity(0.3),
                            AppColors.white
                          ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Section
                          Align(
                              alignment: Alignment.center,
                              child: Image.asset('assets/svg/dots_icon.png')),
                          SizedBox(
                            height: Get.height * .03,
                          ),

                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Merchant is not using chiip',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "You have paid with a virtual VISA that we generated because the merchant does not have Chiip. Recommend them to use Chiip to benefit from all the functionalities.",
                            style:
                                TextStyle(fontSize: 16, color: AppColors.black),
                          ),
                          SizedBox(
                            height: Get.height * .05,
                          ),
                          // Action Buttons
                          CustomButton(
                            title: 'OK, close',
                            backgroundColor: AppColors.primaryBlue,
                            onTap: () {
                              Get.back();
                            },
                            textColor: AppColors.black,
                            borderSideColor: Colors.transparent,
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
