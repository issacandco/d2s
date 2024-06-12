import 'package:accessment/article/article_screen.dart';
import 'package:accessment/base/base_view_model.dart';
import 'package:accessment/extensions/date_time_extension.dart';
import 'package:accessment/models/article_model.dart';
import 'package:accessment/repositories/article_repository.dart';
import 'package:accessment/utils/constant_util.dart';
import 'package:get/get.dart';

class ArticleViewModel extends BaseViewModel {
  final ArticleRepository _articleRepository = ArticleRepository();

  RxBool isLoadingStream = false.obs;
  RxList<ArticleModel> displayArticleListStream = <ArticleModel>[].obs;
  List<ArticleModel> articleList = [];
  int itemsPerPage = 10;
  int currentPage = 0;

  void setIsLoading(bool value) => isLoadingStream.value = value;

  void searchArticles(String keyword) async {
    if (keyword.isEmpty) return;

    try {
      isLoadingStream.value = true;

      Map<String, dynamic> queryRequest = {
        'q': keyword,
        'api-key': ConstantUtil.apiKey,
      };

      final response = await _articleRepository.searchArticle(queryRequest);

      response.when(
        success: (data) {
          if (data['response'] != null) {
            List<Map<String, dynamic>> results = data['response']['docs'].cast<Map<String, dynamic>>();

            for (var result in results) {
              String pubDate = result['pub_date'].toString();
              articleList.add(ArticleModel(title: result['headline']['main'], publishedDate: pubDate.parseStringToDateTimeString(format: 'yyyy-MM-dd')));
            }

            displayArticleListStream.value = articleList;
            isLoadingStream.value = false;
          }
        },
        error: (error) {
          isLoadingStream.value = false;
          handleError(error);
        },
      );
    } catch (e) {
      isLoadingStream.value = false;
      handleError(e);
    }
  }

  void getArticles(ArticleType articleType) async {
    try {
      if (isLoadingStream.value) return;
      isLoadingStream.value = true;

      Map<String, dynamic> pathRequest = {
        'period': 1,
      };

      Map<String, dynamic> queryRequest = {
        'api-key': ConstantUtil.apiKey,
      };

      late var response;

      switch (articleType) {
        case ArticleType.mostViewed:
          response = await _articleRepository.getMostViewedArticles(pathRequest, queryRequest);
          break;
        case ArticleType.mostShared:
          response = await _articleRepository.getMostSharedArticles(pathRequest, queryRequest);
          break;
        case ArticleType.mostEmailed:
          response = await _articleRepository.getMostEmailedArticles(pathRequest, queryRequest);
          break;
        case ArticleType.search:
          return;
      }

      response.when(
        success: (data) {
          print(data['results'].length);

          if (data['results'] != null) {
            articleList = (data['results'] as List).map((e) => ArticleModel.fromJson(e as Map<String, dynamic>)).toList();

            loadMoreArticles(first: true);
          }
          isLoadingStream.value = false;
        },
        error: (error) {
          isLoadingStream.value = false;
          handleError(error);
        },
      );
    } catch (e) {
      isLoadingStream.value = false;
      handleError(e);
    }
  }

  void loadMoreArticles({bool first = false}) async {
    if (isLoadingStream.value && !first) return;

    try {
      int nextPage = currentPage + 1;
      int start = currentPage * itemsPerPage;
      int end = start + itemsPerPage;
      if (start < articleList.length) {
        isLoadingStream.value = true;
        await Future.delayed(const Duration(seconds: 2));

        displayArticleListStream.addAll(articleList.sublist(start, end));
        currentPage = nextPage;

        isLoadingStream.value = false;
      }
    } catch (e) {
      isLoadingStream.value = false;
      handleError(e);
    }
  }
}
