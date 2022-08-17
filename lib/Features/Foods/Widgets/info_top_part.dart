import 'package:flutter/material.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Commons/icon_and_text.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:foodies/Models/products_model.dart';

class InfoTop extends StatelessWidget {
  final ProductModel product;
  const InfoTop({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //

        // ****************** Text ******************

        BigText(
          text: product.name!,
          size: rValue(
            context: context,
            defaultValue: 20.0,
            whenSmaller: 17.0,
          ),
        ),
        SizedBox(
          height: rValue(
            context: context,
            defaultValue: 17.0,
            whenSmaller: 15.0,
          ),
        ),

        // ****************** Comment Section ******************

        Row(
          children: <Widget>[
            Wrap(
              children: List.generate(
                5,
                (int index) => Icon(
                  Icons.star,
                  color: AppColors.mainYellow,
                  size: rValue(
                    context: context,
                    defaultValue: 15.0,
                    whenSmaller: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            SmallText(
              text: "4.5",
              size: rValue(
                context: context,
                defaultValue: 15.0,
                whenSmaller: 12.0,
              ),
            ),
            const SizedBox(width: 10.0),
            SmallText(
              text: "1287",
              size: rValue(
                context: context,
                defaultValue: 15.0,
                whenSmaller: 12.0,
              ),
            ),
            const SizedBox(width: 10.0),
            SmallText(
              text: "comments",
              size: rValue(
                context: context,
                defaultValue: 15.0,
                whenSmaller: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: rValue(
            context: context,
            defaultValue: 20.0,
            whenSmaller: 15.0,
          ),
        ),

        // ****************** Time And Distance ******************

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconAndText(
              text: "Normal",
              icon: Icons.circle_sharp,
              iconColor: AppColors.mainYellow,
              iconSize: rValue(
                context: context,
                defaultValue: 20.0,
                whenSmaller: 17.0,
              ),
              textSize: rValue(
                context: context,
                defaultValue: 13.0,
                whenSmaller: 11.0,
              ),
            ),
            IconAndText(
              text: "1.7km",
              icon: Icons.location_on,
              iconColor: AppColors.mainGreen,
              iconSize: rValue(
                context: context,
                defaultValue: 20.0,
                whenSmaller: 17.0,
              ),
              textSize: rValue(
                context: context,
                defaultValue: 13.0,
                whenSmaller: 11.0,
              ),
            ),
            IconAndText(
              text: "32min",
              icon: Icons.access_time_rounded,
              iconColor: AppColors.mainRed,
              iconSize: rValue(
                context: context,
                defaultValue: 20.0,
                whenSmaller: 17.0,
              ),
              textSize: rValue(
                context: context,
                defaultValue: 13.0,
                whenSmaller: 11.0,
              ),
            ),
          ],
        ),

        //
      ],
    );
  }
}
