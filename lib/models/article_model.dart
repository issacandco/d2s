import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final String? uri;
  final String? url;
  final int? id;
  final int? assetId;
  final String? source;
  @JsonKey(name: 'published_date')
  final String? publishedDate;
  final String? updated;
  final String? section;
  final String? subsection;
  final String? nytdsection;
  @JsonKey(name: 'adx_keywords')
  final String? adxKeywords;
  final dynamic column;
  final String? byline;
  final String? type;
  final String? title;
  final String? abstract;
  @JsonKey(name: 'des_facet')
  final List<String>? desFacet;
  @JsonKey(name: 'org_facet')
  final List<String>? orgFacet;
  @JsonKey(name: 'per_facet')
  final List<String>? perFacet;
  @JsonKey(name: 'geo_facet')
  final List<String>? geoFacet;
  final List<Media>? media;
  @JsonKey(name: 'eta_id')
  final int? etaId;

  ArticleModel({
    this.uri,
    this.url,
    this.id,
    this.assetId,
    this.source,
    this.publishedDate,
    this.updated,
    this.section,
    this.subsection,
    this.nytdsection,
    this.adxKeywords,
    this.column,
    this.byline,
    this.type,
    this.title,
    this.abstract,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    this.media,
    this.etaId,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class Media {
  final String? type;
  final String? subtype;
  final String? caption;
  final String? copyright;
  @JsonKey(name: 'approved_for_syndication')
  final int? approvedForSyndication;
  @JsonKey(name: 'media-metadata')
  final List<MediaMetadata>? mediaMetadata;

  Media({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

}

@JsonSerializable()
class MediaMetadata {
  final String? url;
  final String? format;
  final int? height;
  final int? width;

  MediaMetadata({
    this.url,
    this.format,
    this.height,
    this.width,
  });

  factory MediaMetadata.fromJson(Map<String, dynamic> json) => _$MediaMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MediaMetadataToJson(this);
}