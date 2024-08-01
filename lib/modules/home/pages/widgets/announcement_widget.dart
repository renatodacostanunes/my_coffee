import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .2,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(.5),
        borderRadius: BorderRadius.circular(width * .03),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Text(
                  "Get 20% Discount On your First Order!",
                  style: TextStyle(
                    fontSize: width * 0.045,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * .015),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Vestibulum eget blandit mattis",
                  style: TextStyle(
                    fontSize: width * 0.02,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: width * .3,
              width: width * .3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/announcement.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
