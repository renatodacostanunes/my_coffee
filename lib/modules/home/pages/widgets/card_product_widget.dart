import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(width * .03),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  iconSize: width * .05,
                  icon: const Icon(
                    Icons.favorite_border,
                    color: AppColors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: height * .01),
                  height: width * .25,
                  width: width * .25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/arabica.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Arabica",
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: "Inter",
                          fontSize: width * .045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "\$18",
                        style: TextStyle(
                          color: AppColors.brown,
                          fontFamily: "Inter",
                          fontSize: width * .040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .01),
                Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  "Lorem ipsum dolor sit amet consLorem ipsum dolor sit amet cons",
                  style: TextStyle(
                    color: AppColors.brown,
                    fontFamily: "Inter",
                    fontSize: width * .02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
