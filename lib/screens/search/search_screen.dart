import 'package:accessment/article/article_screen.dart';
import 'package:accessment/styles/app_text_style.dart';
import 'package:accessment/utils/get_util.dart';
import 'package:accessment/widgets/theme/theme_app_bar.dart';
import 'package:accessment/widgets/theme/theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../widgets/theme/theme_text.dart';

class SearchScreen extends BasePage {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseState<SearchScreen> with BasicPage {
  final _searchTec = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  PreferredSizeWidget? appBar() {
    return ThemeAppBar();
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(bottom: AppSize.standardSize),
        child: ThemeTextField(
          fillColor: Theme.of(context).colorScheme.tertiaryContainer,
          controller: _searchTec,
          focusNode: _searchFocusNode,
          hintText: 'search_articles'.translate(),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSize.size_16,
            vertical: AppSize.size_8,
          ),
          textCapitalization: TextCapitalization.characters,
          onTextChanged: (value) {
            // _searchVehicleViewModel.setPlateNumber(value);
          },
          maxLines: 1,
          inputBorderRadius: AppSize.size_24,
        ),
      );

  Widget _buildButton() => Container(
        margin: EdgeInsets.only(top: AppSize.standardSize),
        child: ThemeButton(
            fitType: FitType.fit,
            onPressed: () {
              _goToArticleScreen();
            },
            text: 'search'.translate()),
      );

  _goToArticleScreen() {
    GetUtil.navigateTo(ArticleScreen(
      articleType: ArticleType.search,
      keyword: _searchTec.text.trim(),
    ));
  }
}
