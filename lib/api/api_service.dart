import 'package:dio/dio.dart';

import 'api_service_util.dart';
import 'network_response.dart';

class ApiService {
  final Dio _dio;
  String? baseUrl;

  ApiService(this._dio, {this.baseUrl});

  ApiServiceUtil get apiServiceUtil => ApiServiceUtil(_dio, baseUrl: baseUrl);

  Future<NetworkResponse> getMostViewedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, 'mostpopular/v2/viewed/:period.json', pathParams: pathRequest, queryParameters: queryRequest);
  }

  Future<NetworkResponse> getMostSharedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, 'mostpopular/v2/shared/:period.json', pathParams: pathRequest, queryParameters: queryRequest);
  }

  Future<NetworkResponse> getMostEmailedArticles(Map<String, dynamic> pathRequest, Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, 'mostpopular/v2/emailed/:period.json', pathParams: pathRequest, queryParameters: queryRequest);
  }

  Future<NetworkResponse> searchArticles(Map<String, dynamic> request) {
    return apiServiceUtil.request(RequestType.get, 'search/v2/articlesearch.json', queryParameters: request);
  }
}
