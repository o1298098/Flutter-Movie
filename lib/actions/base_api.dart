import 'package:movie/actions/request.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/models/base_api_model/purchase.dart';
import 'package:movie/models/base_api_model/stream_link_report.dart';
import 'package:movie/models/base_api_model/transaction.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/media_type.dart';

class BaseApi {
  static Request _http = Request('https://www.fluttermovie.top/api');
  static Future<dynamic> updateUser(String uid, String email, String photoUrl,
      String userName, String phone) async {
    String _url = '/Users';
    var _data = {
      "phone": phone,
      "email": email,
      "photoUrl": photoUrl,
      "userName": userName,
      "uid": uid
    };
    return await _http.request(_url, method: "POST", data: _data);
  }

  static Future<UserListModel> getUserList(String uid,
      {int page = 1, int pageSize = 20}) async {
    UserListModel model;
    String _url = '/UserLists/User/$uid?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url);
    if (r != null) model = UserListModel(r);
    return model;
  }

  static Future<dynamic> createUserList(UserList d) async {
    String _url = '/UserLists';
    var data = {
      "id": 0,
      "updateTime": DateTime.now().toString(),
      "createTime": DateTime.now().toString(),
      "runTime": 0,
      "totalRated": 0,
      "selected": 0,
      "revenue": 0,
      "itemCount": 0,
      "description": d.description,
      "backGroundUrl": d.backGroundUrl,
      "uid": d.uid,
      "listName": d.listName
    };
    return await _http.request(_url, method: 'POST', data: data);
  }

  static Future<dynamic> deleteUserList(int listid) async {
    String _url = '/UserLists/$listid';
    return await _http.request(_url, method: 'DELETE');
  }

  static Future<dynamic> addUserListDetail(UserListDetail d) async {
    String _url = '/UserListDetails';
    var data = {
      "id": 0,
      "photoUrl": d.photoUrl,
      "mediaName": d.mediaName,
      "mediaType": d.mediaType,
      "mediaid": d.mediaid,
      "listid": d.listid,
      "rated": d.rated,
      "runTime": d.runTime,
      "revenue": d.revenue
    };
    return await _http.request(_url, method: 'POST', data: data);
  }

  static Future<UserListDetail> getUserListDetailItem(
      int listid, String mediaType, int mediaid) async {
    UserListDetail model;
    String _url = '/UserListDetails/$listid/$mediaType/$mediaid';
    var r = await _http.request(_url);
    if (r != null) model = UserListDetail.fromJson(r);
    return model;
  }

  static Future<UserListDetailModel> getUserListDetailItems(int listid,
      {int page = 1, int pageSize = 20}) async {
    UserListDetailModel model;
    String _url = '/UserListDetails/List/$listid?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url);
    if (r != null) model = UserListDetailModel(r);
    return model;
  }

  static Future<dynamic> updateUserList(UserList list) async {
    String _url = '/UserLists/${list.id}';
    var data = {
      "id": list.id,
      "updateTime": DateTime.now().toString(),
      "createTime": list.createTime,
      "runTime": list.runTime,
      "totalRated": list.totalRated,
      "selected": 0,
      "revenue": list.revenue,
      "itemCount": list.itemCount,
      "description": list.description,
      "backGroundUrl": list.backGroundUrl,
      "uid": list.uid,
      "listName": list.listName
    };
    return await _http.request(_url, method: 'PUT', data: data);
  }

  static Future<AccountState> getAccountState(
      String uid, int mediaId, MediaType type) async {
    AccountState model;
    String _url =
        '/UserAccountStates/$uid/${type.toString().split('.').last}/$mediaId';
    var r = await _http.request(_url);
    if (r != null) model = AccountState(r);
    return model;
  }

  static Future<AccountState> updateAccountState(AccountState d) async {
    AccountState model;
    String _url = '/UserAccountStates';
    var data = {
      'id': d.id,
      'mediaType': d.mediaType,
      'watchlist': d.watchlist ? 1 : 0,
      'rated': d.rated,
      'favorite': d.favorite ? 1 : 0,
      'mediaId': d.mediaId,
      'uid': d.uid
    };
    var r = await _http.request(_url, method: 'POST', data: data);
    if (r != null) model = AccountState(r);
    return model;
  }

  static Future<dynamic> setFavorite(UserMedia d) async {
    String _url = '/UserFavorite';
    var _data = {
      'id': 0,
      'uid': d.uid,
      'mediaId': d.mediaId,
      'name': d.name,
      'genre': d.genre,
      'overwatch': d.overwatch,
      'photoUrl': d.photoUrl,
      'rated': d.rated,
      'ratedCount': d.ratedCount,
      'popular': d.popular,
      'mediaType': d.mediaType,
      'releaseDate': d.releaseDate,
      'createDate': DateTime.now().toString(),
    };
    var r = await _http.request(_url, method: 'POST', data: _data);
    return r;
  }

  static Future<UserMediaModel> getFavorite(String uid, String mediaType,
      {int page = 1, int pageSize = 20}) async {
    UserMediaModel model;
    String _url =
        '/UserFavorite/$uid?mediaType=$mediaType&page=$page&pageSize=$pageSize';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(days: 0));
    if (r != null) model = UserMediaModel(r);
    return model;
  }

  static Future<dynamic> deleteFavorite(
      String uid, MediaType type, int mediaId) async {
    String _url =
        '/UserFavorite/$uid/${type.toString().split('.').last}/$mediaId';
    var r = await _http.request(_url, method: 'DELETE');
    return r;
  }

  static Future<dynamic> setWatchlist(UserMedia d) async {
    String _url = '/UserWatchlist';
    var _data = {
      'id': 0,
      'uid': d.uid,
      'mediaId': d.mediaId,
      'name': d.name,
      'genre': d.genre,
      'overwatch': d.overwatch,
      'photoUrl': d.photoUrl,
      'rated': d.rated,
      'ratedCount': d.ratedCount,
      'popular': d.popular,
      'mediaType': d.mediaType,
      'releaseDate': d.releaseDate,
      'createDate': DateTime.now().toString(),
    };
    var r = await _http.request(_url, method: 'POST', data: _data);
    return r;
  }

  static Future<UserMediaModel> getWatchlist(String uid, String mediaType,
      {int page = 1, int pageSize = 20}) async {
    UserMediaModel model;
    String _url =
        '/UserWatchlist/$uid?mediaType=$mediaType&page=$page&pageSize=$pageSize';
    var r = await _http.request(_url);
    if (r != null) model = UserMediaModel(r);
    return model;
  }

  static Future<dynamic> deleteWatchlist(
      String uid, MediaType type, int mediaId) async {
    String _url =
        '/UserWatchlist/$uid/${type.toString().split('.').last}/$mediaId';
    var r = await _http.request(_url, method: 'DELETE');
    return r;
  }

  static Future<BaseMovieModel> getMovies(
      {int page = 1, int pageSize = 20}) async {
    BaseMovieModel model;
    String _url = '/Movies?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(days: 0));
    if (r != null) model = BaseMovieModel(r);
    return model;
  }

  static Future<BaseMovieModel> searchMovies(String query,
      {int page = 1, int pageSize = 20}) async {
    BaseMovieModel model;
    String _url = '/Movies/Search?name=$query&page=$page&pageSize=$pageSize';
    var r = await _http.request(_url);
    if (r != null) model = BaseMovieModel(r);
    return model;
  }

  static Future<MovieStreamLinks> getMovieStreamLinks(int movieid) async {
    MovieStreamLinks model;
    String _url = '/MovieStreamLinks/MovieId/$movieid';
    var r = await _http.request(_url);
    if (r != null) model = MovieStreamLinks(r);
    return model;
  }

  static Future<bool> hasMovieStreamLinks(int movieid) async {
    String _url = '/MovieStreamLinks/Exist/$movieid';
    return (await _http.request(_url)) ?? false;
  }

  static Future<BaseTvShowModel> getTvShows(
      {int page = 1, int pageSize = 20}) async {
    BaseTvShowModel model;
    String _url = '/TvShows?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(days: 0));
    if (r != null) model = BaseTvShowModel(r);
    return model;
  }

  static Future<BaseTvShowModel> searchTvShows(String query,
      {int page = 1, int pageSize = 20}) async {
    BaseTvShowModel model;
    String _url = '/TvShows/Search/$query&page=$page&pageSize=$pageSize';
    var r = await _http.request(_url);
    if (r != null) model = BaseTvShowModel(r);
    return model;
  }

  static Future<TvShowStreamLinks> getTvSeasonStreamLinks(
      int tvid, int season) async {
    TvShowStreamLinks model;
    String _url = '/TvShowStreamLinks/$tvid/$season';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(minutes: 10));
    if (r != null) model = TvShowStreamLinks(r);
    return model;
  }

  static Future<bool> hasTvShowStreamLinks(int tvid) async {
    String _url = '/TvShowStreamLinks/Exist/$tvid';
    return (await _http.request(_url)) ?? false;
  }

  static Future<bool> hasTvSeasonStreamLinks(int tvid, int season) async {
    String _url = '/TvShowStreamLinks/Exist/$tvid/$season';
    return (await _http.request(_url)) ?? false;
  }

  static Future createMovieComment(MovieComment comment) async {
    String _url = '/MovieComments';
    var _data = {
      'mediaId': comment.mediaId,
      'comment': comment.comment,
      'uid': comment.uid,
      'createTime': comment.createTime,
      'updateTime': comment.updateTime,
      'like': 0,
    };
    await _http.request(_url, method: 'POST', data: _data);
  }

  static Future<TvShowComment> createTvShowComment(
      TvShowComment comment) async {
    TvShowComment model;
    String _url = '/TvShowComments';
    var _data = {
      'mediaId': comment.mediaId,
      'comment': comment.comment,
      'uid': comment.uid,
      'createTime': comment.createTime,
      'updateTime': comment.updateTime,
      'like': comment.like,
      'season': comment.season,
      'episode': comment.episode
    };
    var r = await _http.request(_url, method: 'POST', data: _data);
    if (r != null) model = TvShowComment.fromJson(r);
    return model;
  }

  static Future<TvShowComments> getTvShowComments(
      int tvid, int season, int episode,
      {int page = 1, int pageSize = 40}) async {
    TvShowComments model;
    String _url = '/TvShowComments/$tvid/$season/$episode';
    var r = await _http.request(_url);
    if (r != null) model = TvShowComments(r);
    return model;
  }

  static Future<MovieComments> getMovieComments(int movieid,
      {int page = 1, int pageSize = 40}) async {
    MovieComments model;
    String _url = '/MovieComments/$movieid';
    var r = await _http.request(_url);
    if (r != null) model = MovieComments(r);
    return model;
  }

  static Future<String> sendStreamLinkReport(StreamLinkReport report) async {
    String _url = '/Email/ReportEmail';
    var _data = {
      'mediaName': report.mediaName,
      'linkName': report.linkName,
      'content': report.content,
      'mediaId': report.mediaId,
      'streamLinkId': report.streamLinkId,
      'type': report.type,
      'streamLink': report.streamLink
    };
    var r = await _http.request(_url, method: "POST", data: _data);
    return r;
  }

  static Future<String> sendRequestStreamLink(StreamLinkReport report) async {
    String _url = '/Email/RequestLinkEmail';
    var _data = {
      'mediaName': report.mediaName,
      'mediaId': report.mediaId,
      'type': report.type,
      'season': report.season
    };
    var r = await _http.request(_url, method: "POST", data: _data);
    return r;
  }

  static Future<String> getPaymentToken(String userId) async {
    String _url = '/Payment/ClientToken/$userId';
    var _r = await _http.request(_url);
    return _r;
  }

  static Future<TransactionModel> transactionSearch(String userId) async {
    TransactionModel model;
    String _url = '/payment/TransactionSearch/$userId';
    var _r = await _http.request(_url);
    if (_r != null) model = TransactionModel.fromJson(_r);
    return model;
  }

  static Future<TransactionModel> createPurchase(Purchase purchase) async {
    TransactionModel model;
    String _url = '/CreatePurchase';
    var _r = await _http.request(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': purchase.amount,
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData
    });
    if (_r != null) model = TransactionModel.fromJson(_r);
    return model;
  }
}
