import 'dart:convert' show json;

class ReviewModel {

  int id;
  int page;
  int totalPages;
  int totalResults;
  List<ReviewResult> results;

  ReviewModel.fromParams({this.id, this.page, this.totalPages, this.totalResults, this.results});

  factory ReviewModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ReviewModel.fromJson(json.decode(jsonStr)) : new ReviewModel.fromJson(jsonStr);
  
  ReviewModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    page = jsonRes['page'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new ReviewResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"page": $page,"total_pages": $totalPages,"total_results": $totalResults,"results": $results}';
  }
}

class ReviewResult {

  String author;
  String content;
  String id;
  String url;

  ReviewResult.fromParams({this.author, this.content, this.id, this.url});
  
  ReviewResult.fromJson(jsonRes) {
    author = jsonRes['author'];
    content = jsonRes['content'];
    id = jsonRes['id'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"author": ${author != null?'${json.encode(author)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

