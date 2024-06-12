import '../api/api_client.dart';
import '../api/network_response.dart';

class ArticleRepository {
  ArticleRepository._internal();

  static final ArticleRepository _singleton = ArticleRepository._internal();

  factory ArticleRepository() {
    return _singleton;
  }

  Future<NetworkResponse> getMostViewedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) async {
    return ApiClient.instance.getMostViewedArticles(pathRequest, queryRequest);
  }

  Future<NetworkResponse> getMostSharedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) async {
    return ApiClient.instance.getMostSharedArticles(pathRequest, queryRequest);
  }

  Future<NetworkResponse> getMostEmailedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) async {
    return ApiClient.instance.getMostEmailedArticles(pathRequest, queryRequest);
  }

  Future<NetworkResponse> searchArticle(Map<String, dynamic> request) async {
    return ApiClient.instance.searchArticles(request);
  }
}
