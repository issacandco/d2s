import 'package:accessment/article/article_screen.dart';
import 'package:accessment/screens/landing/ui/item_popular.dart';
import 'package:accessment/styles/app_text_style.dart';
import 'package:accessment/utils/get_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../search/search_screen.dart';

class LandingScreen extends BasePage {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends BaseState<LandingScreen> with BasicPage, WidgetsBindingObserver {
  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleBar(),
              _buildSearchBar(),
              _buildPopular(),
              _buildPopularList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() => Container(
        margin: EdgeInsets.only(bottom: AppSize.standardSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'nyt'.translate(),
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_32,
                    fontWeightType: FontWeightType.bold,
                  ),
                ),
                Text(
                  'welcome'.translate(),
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_18,
                    fontWeightType: FontWeightType.medium,
                  ),
                ),
              ],
            ),
            _buildNotificationBell(),
          ],
        ),
      );

  Widget _buildNotificationBell() => Container(
        padding: EdgeInsets.all(AppSize.size_8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.gray),
        ),
        child: Icon(
          Icons.notifications,
        ),
      );

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(bottom: AppSize.standardSize),
        child: InkWell(
          onTap: () {
            _goToSearchScreen();
          },
          child: Container(
            padding: EdgeInsets.all(AppSize.size_12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSize.size_24),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(width: AppSize.size_12),
                Text(
                  'search_articles'.translate(),
                  style: AppTextStyle.customTextStyle(
                    color: AppColor.eerieBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildPopular() => Container(
        margin: EdgeInsets.only(bottom: AppSize.standardSize),
        child: Text(
          'popular'.translate(),
          style: AppTextStyle.customTextStyle(
            fontWeightType: FontWeightType.bold,
            fontSize: AppSize.textSize_20,
          ),
        ),
      );

  Widget _buildPopularList() => Wrap(
        runSpacing: AppSize.standardSize,
        children: [
          ItemPopular(
              title: 'most_viewed'.translate(),
              image: 'assets/images/most_viewed.svg',
              onClicked: () {
                GetUtil.navigateTo(const ArticleScreen(
                  articleType: ArticleType.mostViewed,
                ));
              }),
          ItemPopular(
              title: 'most_shared'.translate(),
              image: 'assets/images/most_shared.svg',
              onClicked: () {
                GetUtil.navigateTo(const ArticleScreen(
                  articleType: ArticleType.mostShared,
                ));
              }),
          ItemPopular(
              title: 'most_emailed'.translate(),
              image: 'assets/images/most_emailed.svg',
              onClicked: () {
                GetUtil.navigateTo(const ArticleScreen(
                  articleType: ArticleType.mostEmailed,
                ));
              }),
        ],
      );

  _goToSearchScreen() {
    GetUtil.navigateTo(const SearchScreen(), transitionType: TransitionType.fadeIn);
  }
}
