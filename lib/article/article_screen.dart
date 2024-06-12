import 'package:accessment/article/article_view_model.dart';
import 'package:accessment/article/ui/item_article.dart';
import 'package:accessment/models/article_model.dart';
import 'package:accessment/widgets/no_data_widget.dart';
import 'package:accessment/widgets/theme/theme_app_bar.dart';
import 'package:flutter/material.dart';

import '../base/base_page.dart';
import '../styles/app_color.dart';
import '../styles/app_size.dart';
import '../utils/get_util.dart';

enum ArticleType {
  mostViewed,
  mostShared,
  mostEmailed,
  search
}

class ArticleScreen extends BasePage {
  final ArticleType articleType;
  final String? keyword;

  const ArticleScreen({super.key, required this.articleType, this.keyword});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends BaseState<ArticleScreen> with BasicPage {
  final ArticleViewModel _articleViewModel = GetUtil.put(ArticleViewModel());
  final ScrollController _scrollController = ScrollController();
  late String title = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    switch (widget.articleType) {
      case ArticleType.mostViewed:
        title = 'most_viewed'.translate();
        _articleViewModel.getArticles(ArticleType.mostViewed);
        break;
      case ArticleType.mostShared:
        title = 'most_shared'.translate();
        _articleViewModel.getArticles(ArticleType.mostShared);
        break;
      case ArticleType.mostEmailed:
        title = 'most_emailed'.translate();
        _articleViewModel.getArticles(ArticleType.mostEmailed);
        break;
      case ArticleType.search:
        title = 'search_result'.translate();
        _articleViewModel.searchArticles(widget.keyword ?? '');
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_articleViewModel.isLoadingStream.value) {
      _articleViewModel.loadMoreArticles();
    }
  }

  @override
  PreferredSizeWidget? appBar() {
    return ThemeAppBar(
      titleName: title,
    );
  }

  @override
  Widget body() {
    return Container(
      child: GetUtil.getX<ArticleViewModel>(
        builder: (vm) {
          List<ArticleModel> articleList = vm.displayArticleListStream;
          bool isLoading = vm.isLoadingStream.value;

          return Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ItemArticle(articleModel: articleList[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: AppSize.size_16);
                },
                itemCount: articleList.length,
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  width: AppSize.getScreenWidth(),
                  height: AppSize.getScreenHeight(),
                  color: AppColor.offWhiteColor.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
