import 'package:movie/actions/app_config.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/premium_type.dart';
import 'package:movie/models/models.dart';

import 'request.dart';

class BaseApi {
  BaseApi._();
  static final BaseApi _instance = BaseApi._();
  static BaseApi get instance => _instance;

  final Request _http = Request(AppConfig.instance.baseApiHost);

  Future<ResponseModel<dynamic>> updateUser(String uid, String email,
      String photoUrl, String userName, String phone) async {
    final String _url = '/Users';
    final _data = {
      "phone": phone,
      "email": email,
      "photoUrl": photoUrl,
      "userName": userName,
      "uid": uid
    };
    return await _http.request(_url, method: "POST", data: _data);
  }

  Future<ResponseModel<UserListModel>> getUserList(String uid,
      {int page = 1, int pageSize = 20}) async {
    final String _url = '/UserLists/User/$uid?page=$page&pageSize=$pageSize';
    final r = await _http.request<UserListModel>(_url);
    return r;
  }

  Future<ResponseModel<dynamic>> createUserList(UserList d) async {
    final String _url = '/UserLists';
    final data = {
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

  Future<ResponseModel<dynamic>> deleteUserList(int listid) async {
    final String _url = '/UserLists/$listid';
    return await _http.request(_url, method: 'DELETE');
  }

  Future<ResponseModel<dynamic>> addUserListDetail(UserListDetail d) async {
    final String _url = '/UserListDetails';
    final data = {
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

  Future<ResponseModel<UserListDetail>> getUserListDetailItem(
      int listid, String mediaType, int mediaid) async {
    final String _url = '/UserListDetails/$listid/$mediaType/$mediaid';
    final r = await _http.request<UserListDetail>(_url);
    return r;
  }

  Future<ResponseModel<UserListDetailModel>> getUserListDetailItems(int listid,
      {int page = 1, int pageSize = 20}) async {
    final String _url =
        '/UserListDetails/List/$listid?page=$page&pageSize=$pageSize';
    final r = await _http.request<UserListDetailModel>(_url);
    return r;
  }

  Future<ResponseModel<dynamic>> updateUserList(UserList list) async {
    final String _url = '/UserLists/${list.id}';
    final data = {
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

  Future<ResponseModel<CastListDetail>> getCastListDetail(int listId,
      {int page = 1, int pageSize = 20}) async {
    final String _url =
        '/CastList/$listId/detail?page=$page&pageSize=$pageSize';
    final r = await _http.request<CastListDetail>(_url);
    return r;
  }

  Future<ResponseModel<BaseCast>> addCast(BaseCast cast) async {
    final String _url = '/CastList/addCast';
    final _data = {
      "listId": cast.listId,
      "Name": cast.name,
      "castId": cast.castId,
      "profileUrl": cast.profileUrl
    };
    final r = await _http.request<BaseCast>(_url, method: 'POST', data: _data);
    return r;
  }

  Future<ResponseModel<BaseCast>> deleteCast(int id) async {
    final String _url = '/CastList/detail/$id';
    final r = await _http.request<BaseCast>(_url, method: 'DELETE');
    return r;
  }

  Future<ResponseModel<AccountState>> getAccountState(
      String uid, int mediaId, MediaType type) async {
    final String _url =
        '/UserAccountStates/$uid/${type.toString().split('.').last}/$mediaId';
    final r = await _http.request<AccountState>(_url);
    return r;
  }

  Future<ResponseModel<AccountState>> updateAccountState(AccountState d) async {
    final String _url = '/UserAccountStates';
    final data = {
      'id': d.id,
      'mediaType': d.mediaType,
      'watchlist': d.watchlist ? 1 : 0,
      'rated': d.rated,
      'favorite': d.favorite ? 1 : 0,
      'mediaId': d.mediaId,
      'uid': d.uid
    };
    final r =
        await _http.request<AccountState>(_url, method: 'POST', data: data);
    return r;
  }

  Future<ResponseModel<dynamic>> setFavorite(UserMedia d) async {
    final String _url = '/UserFavorite';
    final _data = {
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
    final r = await _http.request(_url, method: 'POST', data: _data);
    return r;
  }

  Future<ResponseModel<UserMediaModel>> getFavorite(
      String uid, String mediaType,
      {int page = 1, int pageSize = 20}) async {
    final String _url =
        '/UserFavorite/$uid?mediaType=$mediaType&page=$page&pageSize=$pageSize';
    final r = await _http.request<UserMediaModel>(_url,
        cached: true, cacheDuration: Duration(days: 0));
    return r;
  }

  Future<ResponseModel<dynamic>> deleteFavorite(
      String uid, MediaType type, int mediaId) async {
    final String _url =
        '/UserFavorite/$uid/${type.toString().split('.').last}/$mediaId';
    final r = await _http.request(_url, method: 'DELETE');
    return r;
  }

  Future<ResponseModel<dynamic>> setWatchlist(UserMedia d) async {
    final String _url = '/UserWatchlist';
    final _data = {
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
    final r = await _http.request(_url, method: 'POST', data: _data);
    return r;
  }

  Future<ResponseModel<UserMediaModel>> getWatchlist(
      String uid, String mediaType,
      {int page = 1, int pageSize = 20}) async {
    final String _url =
        '/UserWatchlist/$uid?mediaType=$mediaType&page=$page&pageSize=$pageSize';
    final r = await _http.request<UserMediaModel>(_url);
    return r;
  }

  Future<ResponseModel<dynamic>> deleteWatchlist(
      String uid, MediaType type, int mediaId) async {
    final String _url =
        '/UserWatchlist/$uid/${type.toString().split('.').last}/$mediaId';
    final r = await _http.request(_url, method: 'DELETE');
    return r;
  }

  Future<ResponseModel<BaseMovieModel>> getMovies(
      {int page = 1, int pageSize = 20}) async {
    final String _url = '/Movies?page=$page&pageSize=$pageSize';
    final r = await _http.request<BaseMovieModel>(_url,
        cached: true, cacheDuration: Duration(days: 0));
    return r;
  }

  Future<ResponseModel<BaseMovieModel>> searchMovies(String query,
      {int page = 1, int pageSize = 20}) async {
    final String _url =
        '/Movies/Search?name=$query&page=$page&pageSize=$pageSize';
    final r = await _http.request<BaseMovieModel>(_url);
    return r;
  }

  Future<ResponseModel<MovieStreamLinks>> getMovieStreamLinks(
      int movieid) async {
    final String _url = '/MovieStreamLinks/MovieId/$movieid';
    final r = await _http.request<MovieStreamLinks>(_url);
    return r;
  }

  Future<ResponseModel<bool>> hasMovieStreamLinks(int movieid) async {
    String _url = '/MovieStreamLinks/Exist/$movieid';
    final _r = _http.request<bool>(_url);
    return _r;
  }

  Future<ResponseModel<dynamic>> getMovieLikes(
      {int movieid, String uid = ''}) async {
    final String _url = '/Movies/Like/$movieid?uid=$uid';
    final r = await _http.request(_url);
    return r;
  }

  Future<ResponseModel<MovieLikeModel>> likeMovie(MovieLikeModel like) async {
    final String _url = '/Movies/Like';
    final _data = {'id': 0, 'movieId': like.movieId ?? 0, 'uid': like.uid};
    final r =
        await _http.request<MovieLikeModel>(_url, method: "POST", data: _data);
    return r;
  }

  Future<ResponseModel<MovieLikeModel>> unlikeMovie(MovieLikeModel like) async {
    final String _url = '/Movies/Like';
    final _data = {'id': 0, 'movieId': like.movieId ?? 0, 'uid': like.uid};
    final r = await _http.request<MovieLikeModel>(_url,
        method: "DELETE", data: _data);
    return r;
  }

  Future<ResponseModel<BaseTvShowModel>> getTvShows(
      {int page = 1, int pageSize = 20}) async {
    final String _url = '/TvShows?page=$page&pageSize=$pageSize';
    final r = await _http.request<BaseTvShowModel>(_url,
        cached: true, cacheDuration: Duration(days: 0));
    return r;
  }

  Future<ResponseModel<BaseTvShowModel>> searchTvShows(String query,
      {int page = 1, int pageSize = 20}) async {
    final String _url = '/TvShows/Search/$query&page=$page&pageSize=$pageSize';
    final r = await _http.request<BaseTvShowModel>(_url);
    return r;
  }

  Future<ResponseModel<TvShowStreamLinks>> getTvSeasonStreamLinks(
      int tvid, int season) async {
    final String _url = '/TvShowStreamLinks/$tvid/$season';
    final r = await _http.request<TvShowStreamLinks>(_url,
        cached: true, cacheDuration: Duration(minutes: 10));
    return r;
  }

  Future<ResponseModel<dynamic>> getTvShowLikes(
      {int tvid, int season = 0, int episode = 0, String uid = ''}) async {
    final String _url =
        '/TvShows/Like/$tvid?season=$season&episode=$episode&uid=$uid';
    final r = await _http.request(_url);
    return r;
  }

  Future<ResponseModel<TvShowLikeModel>> likeTvShow(
      TvShowLikeModel like) async {
    final String _url = '/TvShows/Like';
    final _data = {
      'id': 0,
      'tvId': like.tvId ?? 0,
      'season': like.season,
      'episode': like.episode,
      'uid': like.uid
    };
    final r =
        await _http.request<TvShowLikeModel>(_url, method: "POST", data: _data);
    return r;
  }

  Future<ResponseModel<TvShowLikeModel>> unlikeTvShow(
      TvShowLikeModel like) async {
    final String _url = '/TvShows/Like';
    final _data = {
      'id': 0,
      'tvId': like.tvId ?? 0,
      'season': like.season,
      'episode': like.episode,
      'uid': like.uid
    };
    final r = await _http.request<TvShowLikeModel>(_url,
        method: "DELETE", data: _data);
    return r;
  }

  Future<ResponseModel<bool>> hasTvShowStreamLinks(int tvid) async {
    String _url = '/TvShowStreamLinks/Exist/$tvid';
    final _r = await _http.request<bool>(_url);
    return _r;
  }

  Future<ResponseModel<bool>> hasTvSeasonStreamLinks(
      int tvid, int season) async {
    final String _url = '/TvShowStreamLinks/Exist/$tvid/$season';
    final _r = await _http.request<bool>(_url);
    return _r;
  }

  Future<ResponseModel<MovieComment>> createMovieComment(
      MovieComment comment) async {
    String _url = '/MovieComments';
    var _data = {
      'mediaId': comment.mediaId,
      'comment': comment.comment,
      'uid': comment.uid,
      'createTime': comment.createTime,
      'updateTime': comment.updateTime,
      'like': 0,
    };
    return await _http.request<MovieComment>(_url, method: 'POST', data: _data);
  }

  Future<ResponseModel<TvShowComment>> createTvShowComment(
      TvShowComment comment) async {
    final String _url = '/TvShowComments';
    final _data = {
      'mediaId': comment.mediaId,
      'comment': comment.comment,
      'uid': comment.uid,
      'createTime': comment.createTime,
      'updateTime': comment.updateTime,
      'like': comment.like,
      'season': comment.season,
      'episode': comment.episode
    };
    final r =
        await _http.request<TvShowComment>(_url, method: 'POST', data: _data);
    return r;
  }

  Future<ResponseModel<TvShowComments>> getTvShowComments(
      int tvid, int season, int episode,
      {int page = 1, int pageSize = 40}) async {
    final String _url =
        '/TvShowComments/$tvid/$season/$episode?page=$page&pageSize=$pageSize';
    final r = await _http.request<TvShowComments>(_url);
    return r;
  }

  Future<ResponseModel<MovieComments>> getMovieComments(int movieid,
      {int page = 1, int pageSize = 40}) async {
    final String _url = '/MovieComments/$movieid';
    final r = await _http.request<MovieComments>(_url);
    return r;
  }

  Future<ResponseModel<String>> sendStreamLinkReport(
      StreamLinkReport report) async {
    final String _url = '/Email/ReportEmail';
    final _data = {
      'mediaName': report.mediaName,
      'linkName': report.linkName,
      'content': report.content,
      'mediaId': report.mediaId,
      'streamLinkId': report.streamLinkId,
      'type': report.type,
      'streamLink': report.streamLink
    };
    final r = await _http.request<String>(_url, method: "POST", data: _data);
    return r;
  }

  Future<ResponseModel<String>> sendRequestStreamLink(
      StreamLinkReport report) async {
    final String _url = '/Email/RequestLinkEmail';
    final _data = {
      'mediaName': report.mediaName,
      'mediaId': report.mediaId,
      'type': report.type,
      'season': report.season
    };
    final r = await _http.request<String>(_url, method: "POST", data: _data);
    return r;
  }

  Future<ResponseModel<String>> getPaymentToken(String userId) async {
    final String _url = '/Payment/ClientToken/$userId';
    final _r = await _http.request<String>(_url);
    return _r;
  }

  Future<ResponseModel<TransactionModel>> transactionSearch(String userId,
      {DateTime begin, DateTime end}) async {
    final String _url = '/payment/TransactionSearch/$userId';
    final _r = await _http.request<TransactionModel>(_url);
    return _r;
  }

  Future<ResponseModel<BraintreeCustomer>> getBraintreeCustomer(
      String userId) async {
    final String _url = '/payment/Customer/$userId';
    final _r = await _http.request<BraintreeCustomer>(_url);
    return _r;
  }

  Future<ResponseModel<dynamic>> updateCreditCard(
      String token, dynamic creditCardRequest) async {
    String _url = '/payment/CreditCard';
    var _r = await _http.request(_url, method: 'PUT', data: creditCardRequest);
    return _r;
  }

  Future<ResponseModel<dynamic>> createPurchase(Purchase purchase) async {
    String _url = '/payment/CreatePurchase';
    var _r = await _http.request(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': purchase.amount,
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData
    });
    return _r;
  }

  Future<ResponseModel<UserPremiumModel>> createPremiumPurchase(
      Purchase purchase, PremiumType type) async {
    final String _url = '/payment/CreatePremiumPurchase';
    final _r =
        await _http.request<UserPremiumModel>(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': purchase.amount,
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData,
      'premiumType': type.toString().split('.').last
    });
    return _r;
  }

  Future<ResponseModel<UserPremiumModel>> getUserPremium(String uid) async {
    final String _url = '/users/UserPremium/$uid';
    final _r = await _http.request<UserPremiumModel>(_url);
    return _r;
  }

  Future<ResponseModel<UserPremiumModel>> createPremiumSubscription(
      Purchase purchase, PremiumType type) async {
    final String _url = '/payment/CreateSubscription';
    final _r =
        await _http.request<UserPremiumModel>(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': purchase.amount,
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData,
      'premiumType': type.toString().split('.').last
    });
    return _r;
  }

  Future<ResponseModel<BraintreeSubscription>> getPremiumSubscription(
      String id) async {
    final String _url = '/Payment/Subscription/$id';
    final _r = await _http.request<BraintreeSubscription>(_url);
    return _r;
  }

  Future<ResponseModel<UserPremiumData>> cancelSubscription(
      UserPremiumData userPremium) async {
    final String _url = '/Payment/CancelSubscription';
    final _r = await _http.request<UserPremiumData>(_url,
        method: 'POST', data: userPremium.toString());
    return _r;
  }

  Future<BillingAddress> createBillAddress(BillingAddress address) async {
    BillingAddress _model;
    final String _url = '/Payment/Customer/BillingAddress';
    final _r = await _http.request(_url, method: 'POST', data: {
      'customerID': address.customerId,
      'address': {
        'firstName': address.firstName,
        'lastName': address.lastName,
        'company': address.company,
        'countryName': address.countryName,
        'locality': address.locality,
        'extendedAddress': address.extendedAddress,
        'region': address.region,
        'postalCode': address.postalCode,
        'streetAddress': address.streetAddress,
      },
    });
    if (_r.result) if (_r.result['status'])
      _model = BillingAddress(_r.result['data']);
    return _model;
  }

  Future<BillingAddress> updateBillAddress(BillingAddress address) async {
    BillingAddress _model;
    String _url = '/Payment/Customer/BillingAddress';
    var _r = await _http.request(_url, method: 'PUT', data: {
      'customerID': address.customerId,
      'addressID': address.id,
      'address': {
        'firstName': address.firstName,
        'lastName': address.lastName,
        'company': address.company,
        'countryName': address.countryName,
        'locality': address.locality,
        'extendedAddress': address.extendedAddress,
        'region': address.region,
        'postalCode': address.postalCode,
        'streetAddress': address.streetAddress,
      },
    });
    if (_r.success) if (_r.result['status'])
      _model = BillingAddress(_r.result['data']);
    return _model;
  }

  Future<BillingAddress> deleteBillAddress(BillingAddress address) async {
    BillingAddress _model;
    String _url = '/Payment/Customer/BillingAddress';
    var _r = await _http.request(_url,
        method: 'DELETE',
        data: {'customerID': address.customerId, 'addressID': address.id});
    if (_r.success) if (_r.result['status'])
      _model = BillingAddress(_r.result['data']);
    return _model;
  }

  Future<ResponseModel<dynamic>> createCreditCard(CreditCard card) async {
    final String _url = '/Payment/CreditCard';
    final _r = await _http.request(_url, method: 'POST', data: {
      'customerID': card.customerId,
      'cardholderName': card.cardholderName,
      'cvv': card.bin,
      'number': card.maskedNumber,
      'expirationMonth': card.expirationMonth,
      'expirationYear': card.expirationYear,
    });
    return _r;
  }

  Future<ResponseModel<String>> getVideoSpiderMovie(int movieId) async {
    final String _url = '/videoSpider/movie?movieId=$movieId';
    final _r = await _http.request<String>(_url);
    return _r;
  }

  Future<ResponseModel<String>> getVideoSpiderTvShow(
      int tvId, int season, int epsiode) async {
    final String _url =
        '/videoSpider/tvshow?tvId=$tvId&season=$season&episode=$epsiode';
    final _r = await _http.request<String>(_url);
    return _r;
  }

  Future<ResponseModel<AccountInfo>> getUserAccountInfo(String uid) async {
    final String _url = '/Users/$uid/AccountInfo';
    final _r = await _http.request<AccountInfo>(_url);
    return _r;
  }

  Future<ResponseModel<TopicSubscription>> subscribeTpoic(
      TopicSubscription topic) async {
    final _url = '/Topic/Subscribe';
    final _data = {
      'topicId': topic.topicId,
      'cloudMessagingToken': topic.cloudMessagingToken,
      'localCode': topic.localCode
    };
    final _result = await _http.request<TopicSubscription>(_url,
        method: 'POST', data: _data);
    return _result;
  }

  ///create Stripe payment intent
  Future<ResponseModel<UserPremiumModel>> createPayment(
      Purchase purchase, PremiumType type, bool nativePay) async {
    final String _url = '/StripePayment/CreatePayment';
    final _r =
        await _http.request<UserPremiumModel>(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': (purchase.amount * 100).toInt(),
      'currency': 'usd',
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData,
      'premiumType': type.toString().split('.').last,
      'nativePay': nativePay
    });
    return _r;
  }

  Future<ResponseModel<dynamic>> createStripePremiumSubscription(
      Purchase purchase, PremiumType type) async {
    final String _url = '/StripePayment/CreateSubscription';
    final _r = await _http.request<dynamic>(_url, method: 'POST', data: {
      'userId': purchase.userId,
      'amount': (purchase.amount * 100).toInt(),
      'paymentMethodNonce': purchase.paymentMethodNonce,
      'deviceData': purchase.deviceData,
      'premiumType': type.toString().split('.').last
    });
    return _r;
  }

  Future<ResponseModel<StripeCreditCards>> getCreditCards(String userId) async {
    final String _url = '/StripePayment/CreditCards/$userId';
    final _r = await _http.request<StripeCreditCards>(_url);
    return _r;
  }

  Future<ResponseModel<StripeCustomer>> getStripeCustomer(String userId) async {
    final String _url = '/StripePayment/Customer/$userId';
    final _r = await _http.request<StripeCustomer>(_url);
    return _r;
  }

  Future<ResponseModel<StripeCharges>> getStripeCharges(
      String stripeCustomerId) async {
    final String _url = '/StripePayment/Charges/$stripeCustomerId';
    final _r = await _http.request<StripeCharges>(_url);
    return _r;
  }

  Future<StripeAddress> updateStripeAddress(String stripeCustomerId,
      String customerName, StripeAddress address) async {
    StripeAddress _model;
    String _url = '/StripePayment/Customer/BillingAddress';
    var _r = await _http.request(_url, method: 'POST', data: {
      'customerID': stripeCustomerId,
      'customerName': customerName,
      'address': {
        'city': address.city,
        'country': address.country,
        'line1': address.line1,
        'line2': address.line2,
        'postal_code': address.postalCode,
        'state': address.state,
      },
    });
    if (_r.success) if (_r.result['status'])
      _model = StripeAddress.fromJson(_r.result['data']);
    return _model;
  }

  Future<StripeAddress> deleteStripeAddress(String stripeCustomerId) async {
    StripeAddress _model;
    String _url = '/StripePayment/Customer/BillingAddress/$stripeCustomerId';
    var _r = await _http.request(_url, method: 'DELETE');
    if (_r.success) if (_r.result['status'])
      _model = StripeAddress.fromJson(_r.result['data']);
    return _model;
  }

  Future<dynamic> createStripeCreditCard(CreditCard card) async {
    String _url = '/StripePayment/CreditCard';
    var _r = await _http.request(_url, method: 'POST', data: {
      'customerID': card.customerId,
      'number': card.maskedNumber,
      'expMonth': card.expirationMonth,
      'expYear': card.expirationYear,
      'cvc': card.bin,
    });
    return _r;
  }
}
