import 'package:accessment/models/article_model.dart';
import 'package:accessment/styles/app_text_style.dart';
import 'package:accessment/utils/get_util.dart';
import 'package:flutter/cupertino.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';

class ItemArticle extends StatelessWidget {
  final ArticleModel? articleModel;

  const ItemArticle({super.key, this.articleModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.standardSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            articleModel?.title ?? '',
            style: AppTextStyle.customTextStyle(
              fontSize: AppSize.textSize_16,
              fontWeightType: FontWeightType.bold,
            ),
          ),
          SizedBox(height: AppSize.size_8),
          Text(
            '${'published_on'.translate()} ${articleModel?.publishedDate}',
            style: AppTextStyle.customTextStyle(
              fontSize: AppSize.textSize_14,
              color: AppColor.darkCharcoalColor,
            ),
          ),
        ],
      ),
    );
  }
}
