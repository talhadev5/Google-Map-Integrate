import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/chip/chip.dart';

class Maplogic extends GetxController {
  //  varibles..........

  late BitmapDescriptor customIcon;
  RxBool addinfo = false.obs;
  RxBool requestStatus = false.obs;
  infoBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true, // Allows dynamic height adjustment
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          return Container(
            // height: MediaQuery.of(context).size.height * 0.55, // Adjust height
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: AppColors.black),
                    child: Stack(
                      children: [
                        Image.asset('assets/svg/coverimage.png'),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.width * .02,
                              ),
                              Image.asset(
                                'assets/svg/Avatar-4.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: Get.width * .04,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sarah Roncaert',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(addinfo.value == false
                                          ? 'assets/svg/heart.png'
                                          : 'assets/svg/galas.png'),
                                      SizedBox(
                                        width: Get.width * .02,
                                      ),
                                      Text(
                                        addinfo.value == false
                                            ? '2 mutual friends'
                                            : 'Drinking at Yelloweston......',
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * .1,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          addinfo.value = !addinfo.value;
                                          update();
                                        },
                                        child: SvgPicture.asset(addinfo.value ==
                                                false
                                            ? 'assets/svg/personadd_iocn.svg'
                                            : 'assets/svg/personskip.svg'),
                                      ),
                                      SizedBox(
                                        width: Get.width * .04,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  addinfo.value == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/bio.svg'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Bio',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Text(
                                'Savor each minute of life and create pleasant memories with your loved ones.',
                                style: TextStyle(
                                  color: AppColors.grey,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Divider(
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/history.svg'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'History',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.geryColorLight,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: const TextSpan(children: [
                                              TextSpan(
                                                text: 'Gifted   ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              TextSpan(
                                                text: 'Cocktail Virgin Mojito',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.grey,
                                                ),
                                              ),
                                            ])),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Today at 1:25pm',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SvgPicture.asset(
                                                    'assets/svg/1x.svg'),
                                                SizedBox(
                                                  width: Get.width * .01,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/svg/Gold Chiip.svg')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .02,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.geryColorLight,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: const TextSpan(children: [
                                              TextSpan(
                                                text: 'Received  ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              TextSpan(
                                                text: 'Cocktail Virgin Mojito',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.grey,
                                                ),
                                              )
                                            ])),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Thursday 21 July',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SvgPicture.asset(
                                                    'assets/svg/1x.svg'),
                                                SizedBox(
                                                  width: Get.width * .01,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/svg/Gold Chiip.svg')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Divider(
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/svg/heart_balck.png'),
                                  SizedBox(
                                    width: Get.width * .01,
                                  ),
                                  const Text(
                                    'Mutual friends',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * .01),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/svg/Avatar.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: Get.width * .01,
                                  ),
                                  const Text(
                                    'Jeffrey',
                                    style: TextStyle(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .03,
                                  ),
                                  Image.asset(
                                    'assets/svg/Avatar-3.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: Get.width * .01,
                                  ),
                                  const Text(
                                    'Irem',
                                    style: TextStyle(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * .03,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(height: Get.height * .01),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.geryColorLight),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'You and Sarah and have 2 mutual friends',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/svg/Avatar.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: Get.width * .01,
                                          ),
                                          const Text(
                                            'Jeffrey',
                                            style: TextStyle(
                                              color: AppColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * .03,
                                          ),
                                          Image.asset(
                                            'assets/svg/Avatar-3.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: Get.width * .01,
                                          ),
                                          const Text(
                                            'Irem',
                                            style: TextStyle(
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                  SizedBox(
                    height: Get.height * .03,
                  ),
                  //actioon button
                  addinfo.value == false
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  requestStatus.value = !requestStatus.value;
                                  update();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.primaryBlue,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: AppColors.white,
                                  minimumSize: const Size(
                                      double.infinity, 50), // Full-width button
                                ),
                                child: Text(
                                  requestStatus.value == true
                                      ? 'Request for a drink pending...'
                                      : 'Request a drink',
                                  style: const TextStyle(
                                      color: AppColors.primaryBlue),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .04,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  // Action button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ChipPage());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.primaryBlue,
                        minimumSize: const Size(
                            double.infinity, 50), // Full-width button
                      ),
                      child: const Text(
                        'Send Chips (s)',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  // Cancel button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        side:
                            BorderSide(color: AppColors.grey.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.white,
                        minimumSize: const Size(
                            double.infinity, 50), // Full-width button
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
