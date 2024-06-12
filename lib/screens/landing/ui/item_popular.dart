import 'package:accessment/styles/app_size.dart';
import 'package:accessment/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemPopular extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onClicked;

  const ItemPopular({
    required this.title,
    required this.image,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClicked.call(),
      child: Container(
        width: AppSize.getScreenWidth(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.standardSize,
          vertical: AppSize.size_16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSize.size_16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildImage(),
                  _buildTitle(),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: AppSize.size_18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: AppTextStyle.customTextStyle(
        fontSize: AppSize.textSize_16,
        fontWeightType: FontWeightType.medium,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.size_16),
      child: SvgPicture.asset(
        image,
        width: AppSize.getScreenWidth(percent: 30),
        height: AppSize.getScreenHeight(percent: 10),
      ),
    );
  }
}
