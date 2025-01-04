import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';

class ChipLogic extends GetxController {
  // variable.........
  int selectedChipIndex = 0;
  int quantity = 1;
  final List<Map<String, String>> chipData = [
    {
      'title': 'Silver Chiip',
      'subtitle': '1 Silver Chiip is equivalent to \$1.',
      'image': 'assets/svg/Gold Chiip.svg',
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
      'image': 'assets/svg/Gold Chiip.svg',
      'price': '5\$',
    },
  ];
  // openMessageSheet() {
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       context: Get.context!,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // First section: Personalized Message and Description
  //                 const Text(
  //                   'Personalize Message',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 18,
  //                     color: AppColors.black,
  //                   ),
  //                 ),
  //                 // Second section: Text area with character limit and remaining characters display
  //                 const Text(
  //                   'It seems that you are sending Chiip(s) to a person who is not in your friend list.',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: AppColors.grey,
  //                   ),
  //                 ),
  //                 Column(
  //                   children: [
  //                     Container(
  //                       color: AppColors.white,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Image.asset('assets/svg/file_icon.png'),
  //                                 SizedBox(
  //                                   width: Get.width * .02,
  //                                 ),
  //                                 const Text(
  //                                   'Note to receiver',
  //                                   style: TextStyle(color: AppColors.grey),
  //                                 ),
  //                                 const Spacer(),
  //                                 const Text(
  //                                   'optional',
  //                                   style: TextStyle(color: AppColors.grey),
  //                                 )
  //                               ],
  //                             ),
  //                             TextField(
  //                               maxLines: 2,
  //                               maxLength: 160, // Limit to 160 characters
  //                               decoration: InputDecoration(
  //                                 hintText: '',
  //                                 border: OutlineInputBorder(
  //                                   borderSide: BorderSide.none,
  //                                   borderRadius: BorderRadius.circular(10),
  //                                 ),
  //                                 filled: true,
  //                                 fillColor: AppColors.white,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 8),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 20),
  //                 // Action button
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       // Get.to(() => ChipPage());
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10)),
  //                       backgroundColor: AppColors.primaryBlue,
  //                       minimumSize: const Size(
  //                           double.infinity, 50), // Full-width button
  //                     ),
  //                     child: const Text(
  //                       'Send Chips (s)',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * .01),
  //                 // Cancel button
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context); // Close the bottom sheet
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       side:
  //                           BorderSide(color: AppColors.grey.withOpacity(0.3)),
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10)),
  //                       backgroundColor: AppColors.white,
  //                       minimumSize: const Size(
  //                           double.infinity, 50), // Full-width button
  //                     ),
  //                     child: const Text(
  //                       'Go back',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * .02),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  openMessageSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: Get.context!,
      isScrollControlled: true, // Makes the height of the bottom sheet flexible
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (BuildContext context) {
              // Get the current height of the screen to adjust for the keyboard
              double screenHeight = MediaQuery.of(context).size.height;
              double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

              // Calculate the remaining available space after keyboard is open
              double availableHeight = screenHeight - keyboardHeight;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // First section: Personalized Message and Description
                    const Text(
                      'Personalize Message',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                    ),
                    // Second section: Text area with character limit and remaining characters display
                    const Text(
                      'It seems that you are sending Chiip(s) to a person who is not in your friend list.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/svg/file_icon.png'),
                                    SizedBox(
                                      width: Get.width * .02,
                                    ),
                                    const Text(
                                      'Note to receiver',
                                      style: TextStyle(color: AppColors.grey),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'optional',
                                      style: TextStyle(color: AppColors.grey),
                                    )
                                  ],
                                ),
                                TextField(
                                  maxLines: 2,
                                  maxLength: 160, // Limit to 160 characters
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
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Action button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Get.to(() => ChipPage());
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
                          side: BorderSide(
                              color: AppColors.grey.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.white,
                          minimumSize: const Size(
                              double.infinity, 50), // Full-width button
                        ),
                        child: const Text(
                          'Go back',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * .02),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
