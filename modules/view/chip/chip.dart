import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/viewmodel/chip_logic.dart';

class ChipPage extends StatelessWidget {
  ChipPage({super.key});
  final controller = Get.put(ChipLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChipLogic>(builder: (controller) {
      return Scaffold(
        backgroundColor: const Color(0xFFEFFAFF),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.asset(
                  'assets/svg/bacground_image.png',
                  height: Get.height * .175,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.share))
                      ],
                    ),
                    const Text(
                      'Send Chiip to',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/svg/Avatar-4.png',
                          height: 45,
                          width: 45,
                        ),
                        SizedBox(
                          width: Get.width * .02,
                        ),
                        const Text(
                          'Sarah Roncaert',
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                    const Text(
                      'Select Chiip',
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.chipData.length,
                        itemBuilder: (context, index) {
                          final chip = controller.chipData[index];

                          return GestureDetector(
                            onTap: () {
                              controller.selectedChipIndex = index;
                              controller.update();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 08),
                              decoration: BoxDecoration(
                                color: controller.selectedChipIndex == index
                                    ? AppColors.primaryBlue.withOpacity(
                                        0.1) // Selected background color
                                    : AppColors
                                        .white, // Default background color
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.selectedChipIndex == index
                                      ? AppColors
                                          .primaryBlue // Selected border color
                                      : AppColors.white, // Default border color
                                  width: 2,
                                ),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                leading: SvgPicture.asset(chip['image']!),
                                title: Text(
                                  chip['title']!,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  chip['subtitle']!,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                  ),
                                ),
                                trailing: Text(
                                  chip['price']!,
                                  style: const TextStyle(
                                      color: AppColors.green, fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        }),
                    const Text(
                      'Amount',
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Row(
                      children: [
                        // TextField for displaying and modifying quantity
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              controller.updateMessageText(
                                  value); // Update the controller
                            },
                            controller: TextEditingController(
                                text: controller.quantity.toString()),
                            readOnly: true, // Make it read-only
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18, color: AppColors.black),
                            decoration: const InputDecoration(
                              enabled: false,
                              filled: true,
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Subtract Button
                        GestureDetector(
                          onTap: () {
                            if (controller.quantity > 0) {
                              controller.quantity--; // Decrement quantity
                            }
                            controller.update();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.geryColorLight),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.remove, color: AppColors.black),
                              )),
                        ),
                        SizedBox(
                          width: Get.width * .02,
                        ),
                        // Add Button
                        GestureDetector(
                          onTap: () {
                            controller.quantity++; // Increment quantity
                            controller.update();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primaryBlue),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.add, color: AppColors.black),
                              )),
                        ),
                      ],
                    ),
                    // Send Now Button (Enabled only when a chip is selected)
                  ],
                ),
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          height: Get.height * .15,
          elevation: 0,
          child: Column(
            children: [
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isSendNowEnabled
                      ? () {
                          controller.openMessageSheet();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send Now',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
