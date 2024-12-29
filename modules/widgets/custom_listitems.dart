import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';

class CustomListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isVerified;
  final String rating;
  final String status;

  const CustomListItem({
    required this.imageUrl,
    required this.title,
    required this.isVerified,
    required this.rating,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Image/Icon
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 25,
          ),
          const SizedBox(width: 10),
          // Title and Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 3),
                    if (isVerified)
                      const Icon(Icons.verified, size: 16, color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: Get.width * .01),
                    Row(
                      children: List.generate(4, (index) {
                        return Icon(
                          Icons.star,
                          size: 12,
                          color: index < 4.2 ? Colors.orange : Colors.grey,
                        );
                      }),
                    ),
                    SizedBox(width: Get.width * .01),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: status == 'High'
                              ? AppColors.greencolor
                              : AppColors.secondaryblue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            children: [
                              Image.asset("assets/svg/fire_icon.png"),
                              SizedBox(
                                width: Get.width * .01,
                              ),
                              Text(
                                status,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
          // Status Label
          IconButton(onPressed: () {}, icon: const Icon(Icons.navigate_next))
        ],
      ),
    );
  }
}
