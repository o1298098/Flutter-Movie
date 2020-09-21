import 'dart:convert' show json;
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:movie/actions/app_config.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'request.dart';

class TMDBApi {
  TMDBApi._();
  static final TMDBApi _instance = TMDBApi._();
  static TMDBApi get instance => _instance;

  String _apikey;
  String _apikeyV4;
  String _requestToken;
  String accessTokenV4;
  String session;
  DateTime _sessionExpiresTime;
  SharedPreferences prefs;
  String _language = ui.window.locale.languageCode;
  String region = ui.window.locale.countryCode;
  bool _includeAdult;
  Request _http;
  Request _httpV4;

  Future<void> init() async {
    _http = Request(AppConfig.instance.theMovieDBHostV3);
    _httpV4 = Request(AppConfig.instance.theMovieDBHostV4);
    _apikey = AppConfig.instance.theMovieDBApiKeyV3;
    _apikeyV4 = AppConfig.instance.theMovieDBApiKeyV4;
    prefs = await SharedPreferences.getInstance();
    _includeAdult = prefs.getBool('adultItems') ?? false;
    final _appLanguage = prefs.getString('appLanguage');
    if (_appLanguage != null) {
      _language = Item(_appLanguage).value;
      GlobalStore.store
          .dispatch(GlobalActionCreator.changeLocale(ui.Locale(_language)));
    }
  }

  void setAdultValue(bool adult) {
    _includeAdult = adult ?? false;
  }

  void setLanguage(String languageCode) {
    if (languageCode == null)
      _language = ui.window.locale.languageCode;
    else
      _language = languageCode;
  }

  Future createGuestSession() async {
    String param = '/authentication/guest_session/new?api_key=$_apikey';
    final r = await _http.request(param);
    if (r.success) {
      if (r.result['success']) {
        session = r.result['guest_session_id'];
        _sessionExpiresTime = DateTime.parse(r.result['expires_at']
            .toString()
            .replaceFirst(new RegExp(' UTC'), ''));
        var date = DateTime.utc(
            _sessionExpiresTime.year,
            _sessionExpiresTime.month,
            _sessionExpiresTime.day,
            _sessionExpiresTime.hour,
            _sessionExpiresTime.minute,
            _sessionExpiresTime.second,
            _sessionExpiresTime.millisecond,
            _sessionExpiresTime.microsecond);
        prefs.setString('guestSession', session);
        prefs.setString('guestSessionExpires', date.toIso8601String());
      }
    }
  }

  Future createRequestToken() async {
    String param = '/authentication/token/new?api_key=$_apikey';
    dynamic r = await _http.request(param);
    if (r != null) {
      if (r['success']) {
        _requestToken = r['request_token'];
      }
    }
  }

  Future<bool> createSessionWithLogin(String account, String pwd) async {
    bool result = false;
    if (_requestToken == null) await createRequestToken();
    String param = '/authentication/token/validate_with_login?api_key=$_apikey';
    FormData formData = new FormData.fromMap(
        {"username": account, "password": pwd, "request_token": _requestToken});
    dynamic r = await _http.request(param, method: "POST", data: formData);
    if (r != null) {
      if (r['success']) {
        result = await createNewSession(_requestToken);
      }
    }
    return result;
  }

  Future<bool> createNewSession(String sessionToken) async {
    bool result = false;
    if (session != null) {
      String param = '/authentication/session/new?api_key=$_apikey';
      FormData formData = new FormData.fromMap({"request_token": sessionToken});
      dynamic r = await _http.request(param, method: "POST", data: formData);
      if (r != null) {
        if (r['success']) {
          session = r['session_id'];
          prefs.setString('loginsession', session);
          var detail = await getAccountDetail();
          if (detail != null) result = true;
        }
      }
    }
    return result;
  }

  Future createSessionWithV4(String sessionToken) async {
    String param = '/authentication/session/convert/4?api_key=$_apikey';
    FormData formData = new FormData.fromMap({"access_token": _apikeyV4});
    dynamic r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $accessTokenV4'});
    if (r != null) {
      if (r['success']) {
        session = r['session_id'];
        _sessionExpiresTime = DateTime.parse(
            r['expires_at'].toString().replaceFirst(new RegExp(' UTC'), ''));
        prefs.setString('loginsession', session);
        prefs.setString(
            'loginsessionexpires', _sessionExpiresTime.toIso8601String());
      }
    }
  }

  Future<AccountDetailModel> getAccountDetail() async {
    AccountDetailModel accountDetailModel;
    if (session != null) {
      String param = '/account?api_key=$_apikey&session_id=$session';
      var r = await _http.request(param);
      if (r != null) accountDetailModel = AccountDetailModel(r);
      prefs.setInt('accountid', accountDetailModel.id);
      prefs.setBool('islogin', true);
      prefs.setString('accountname', accountDetailModel.username);
      prefs.setString('accountgravatar',
          'https://www.gravatar.com/avatar/${accountDetailModel.avatar.gravatar.hash}?size=200');
    }
    return accountDetailModel;
  }

  Future<bool> deleteSession() async {
    String param = '/authentication/session?api_key=$_apikey';
    if (session != null) {
      FormData formData = new FormData.fromMap({"session_id": session});
      dynamic r = await _http.request(param,
          method: 'DELETE', queryParameters: formData);
      if (r != null) {
        if (r['status_code'] == 6) {
          prefs.remove('loginsession');
          prefs.remove('accountid');
          prefs.remove('accountname');
          prefs.remove('accountgravatar');
          prefs.remove('islogin');
          await deleteAccessTokenV4();
        } else
          return false;
      }
    }
    return true;
  }

  Future<String> createRequestTokenV4() async {
    String result;
    String param = "/auth/request_token";
    FormData formData = new FormData.fromMap({});
    var r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    if (r != null) {
      var jsonobject = json.decode(r.result);
      if (jsonobject['success']) {
        result = jsonobject['request_token'];
      }
    }
    return result;
  }

  Future<bool> createAccessTokenV4(String requestTokenV4) async {
    if (requestTokenV4 == null) return false;
    bool result = false;
    String param = "/auth/access_token";
    FormData formData = new FormData.fromMap({"request_token": requestTokenV4});
    var r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    if (r.success) {
      var jsonobject = json.decode(r.result);
      if (jsonobject['success']) {
        String _accountid = jsonobject['account_id'];
        accessTokenV4 = jsonobject['access_token'];
        prefs.setString('accountIdV4', _accountid);
        prefs.setString('accessTokenV4', accessTokenV4);
        result = true;
      }
    }
    return result;
  }

  Future<ResponseModel<MyListModel>> getAccountListsV4(String acountid,
      {int page = 1}) async {
    String param = '/account/$acountid/lists?page=$page';
    final r = await _httpV4.request<MyListModel>(param,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    return r;
  }

  Future<ResponseModel<ListDetailModel>> getListDetailV4(int listId,
      {int page = 1, String sortBy}) async {
    String param = '/list/$listId?page=$page&language=$_language';
    if (sortBy != null) param += '&sort_by=$sortBy';
    final r = await _httpV4.request<ListDetailModel>(param,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    return r;
  }

  Future<bool> deleteAccessTokenV4() async {
    String param = '/auth/access_token';
    if (session != null) {
      var formData = {"access_token": accessTokenV4};
      final r = await _httpV4.request(param,
          method: 'DELETE',
          headers: {'Authorization': 'Bearer $_apikeyV4'},
          queryParameters: formData);
      if (r.success) {
        if (r.result['success']) {
          prefs.remove('accountIdV4');
          prefs.remove('accessTokenV4');
        } else
          return false;
      }
    }
    return true;
  }

  Future<bool> markAsFavorite(int id, MediaType type, bool isFavorite) async {
    bool result = false;
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return result;
    String param =
        '/account/$accountid/favorite?api_key=$_apikey&session_id=$session';
    var formData = {
      "media_type": type == MediaType.movie ? "movie" : "tv",
      "media_id": id,
      "favorite": isFavorite
    };
    final r = await _http.request(param, method: "POST", data: formData);
    if (r.success) {
      if (r.result['status_code'] == 1 ||
          r.result['status_code'] == 12 ||
          r.result['status_code'] == 13) result = true;
    }
    return result;
  }

  Future<bool> addToWatchlist(int id, MediaType type, bool isAdd) async {
    bool result = false;
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return result;
    String param =
        '/account/$accountid/watchlist?api_key=$_apikey&session_id=$session';
    var formData = {
      "media_type": type == MediaType.movie ? 'movie' : 'tv',
      "media_id": id,
      "watchlist": isAdd
    };
    final r = await _http.request(param, method: "POST", data: formData);
    if (r.success) {
      if (r.result['status_code'] == 1 ||
          r.result['status_code'] == 12 ||
          r.result['status_code'] == 13) result = true;
    }
    return result;
  }

  Future<bool> addToList(int listid, List<ListMediaItem> items) async {
    bool result = false;
    String param = '/list/$listid/items';
    var data = {"items": items};
    final r = await _httpV4.request(param,
        method: "POST",
        data: data,
        headers: {'Authorization': 'Bearer $accessTokenV4'});
    if (r.success) {
      if (r.result['status_code'] == 1) result = true;
    }
    return result;
  }

  ///Get the list of your favorite Movies.sortBy allowed values: created_at.asc, created_at.desc
  Future<ResponseModel<VideoListModel>> getFavoriteMovies(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    String param =
        '/account/$accountid/favorite/movies?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  ///Get the list of your favorite TV shows.
  Future<ResponseModel<VideoListModel>> getFavoriteTVShows(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    final String param =
        '/account/$accountid/favorite/tv?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getMoviesWatchlist(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    String param =
        '/account/$accountid/watchlist/movies?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getTVShowsWacthlist(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    String param =
        '/account/$accountid/watchlist/tv?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  ///Get a list of all the movies you have rated.
  Future<ResponseModel<VideoListModel>> getRatedMovies(
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return null;
    final String param =
        '/account/$accountid/rated/movies?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  ///Get a list of all the movies you have rated.
  Future<ResponseModel<VideoListModel>> getRatedTVShows(
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    final int accountid = prefs.getInt('accountid');
    if (accountid == null) return null;
    final String param =
        '/account/$accountid/rated/tv?api_key=$_apikey&language=$_language&session_id=$session&sort_by=$sortBy&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<bool> rateTVShow(int tvid, double rating) async {
    bool result = false;
    String param = '/tv/$tvid/rating?api_key=$_apikey';
    int accountid = prefs.getInt('accountid');
    if (accountid == null)
      //param += '&guest_session_id=$session';
      return false;
    else
      param += '&session_id=$session';
    FormData formData = new FormData.fromMap({"value": rating});
    var r = await _http.request(param, method: "POST", data: formData);
    if (r.success) {
      var jsonobject = json.decode(r.result);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }

  Future<bool> rateMovie(int movieid, double rating) async {
    bool result = false;
    String param = '/movie/$movieid/rating?api_key=$_apikey';
    int accountid = prefs.getInt('accountid');
    if (accountid == null)
      //param += '&guest_session_id=$session';
      return false;
    else
      param += '&session_id=$session';
    FormData formData = new FormData.fromMap({"value": rating});
    var r = await _http.request(param, method: "POST", data: formData);
    if (r.success) {
      var jsonobject = json.decode(r.result);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }

  Future<bool> rateTVEpisode(
      int tvid, int seasonid, int episodeid, double rating) async {
    bool result = false;
    String param =
        '/tv/$tvid/season/$seasonid/episode/$episodeid/rating?api_key=$_apikey&session_id=$seasonid';
    var data = {"value": rating};
    var r = await _http.request(param, method: "POST", data: data);
    if (r.success) {
      var jsonobject = json.decode(r.result);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }

  Future<ResponseModel<CertificationModel>> getMovieCertifications() async {
    final String param = '/certification/movie/list';
    final r = await _http.request<CertificationModel>(param);
    return r;
  }

  Future<ResponseModel<CertificationModel>> getTVCertifications() async {
    String param = '/certification/tv/list';
    final r = await _http.request<CertificationModel>(param);
    return r;
  }

  Future<ResponseModel<VideoListResult>> getLastMovies() async {
    final String param = "/movie/latest?api_key=$_apikey&language=$_language";
    final r = await _http.request<VideoListResult>(param);
    return r;
  }

  Future<ResponseModel<VideoListResult>> getLastTVShows() async {
    final String param = "/tv/latest?api_key=$_apikey&language=$_language";
    final r = await _http.request<VideoListResult>(param);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getPopularMovies({int page = 1}) async {
    final String param =
        "/movie/popular?api_key=$_apikey&language=$_language&page=$page&region=$region";
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getPopularTVShows(
      {int page = 1}) async {
    final String param =
        "/tv/popular?api_key=$_apikey&language=$_language&page=$page&region=$region";
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<ResponseModel<MovieDetailModel>> getMovieDetail(int mvid,
      {String appendtoresponse}) async {
    String param = '/movie/$mvid?api_key=$_apikey&language=$_language';
    if (appendtoresponse != null)
      param = param + '&append_to_response=$appendtoresponse';
    final r = await _http.request<MovieDetailModel>(param,
        cached: true, cacheDuration: Duration(hours: 1));
    return r;
  }

  Future<ResponseModel<TVDetailModel>> getTVDetail(int tvid,
      {String appendtoresponse}) async {
    String param = '/tv/$tvid?api_key=$_apikey&language=$_language';
    if (appendtoresponse != null)
      param = param + '&append_to_response=$appendtoresponse';
    final r = await _http.request<TVDetailModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<MediaAccountStateModel>> getTVAccountState(
      int tvid) async {
    String param =
        '/tv/$tvid/account_states?api_key=$_apikey&language=$_language';
    final int accountid = prefs.getInt('accountid');
    if (accountid != null)
      param += '&session_id=$session';
    else
      return null;
    final r = await _http.request<MediaAccountStateModel>(param);
    return r;
  }

  Future<ResponseModel<MediaAccountStateModel>> getMovieAccountState(
      int movieid) async {
    String param =
        '/movie/$movieid/account_states?api_key=$_apikey&language=$_language';
    int accountid = prefs.getInt('accountid');
    if (accountid != null)
      param += '&session_id=$session';
    else
      param += '&guest_session_id=$session';
    final r = await _http.request<MediaAccountStateModel>(param);
    return r;
  }

  ///Get a list of all of the movie ids that have been changed in the past 24 hours.You can query it for up to 14 days worth of changed IDs at a time with the start_date and end_date query parameters. 100 items are returned per page.
  Future<ResponseModel<MovieChangeModel>> getMovieChange(
      {int page = 1, String startdate, String enddate}) async {
    String param = '/movie/changes?api_key=$_apikey&page=$page';
    if (startdate != null && enddate == null)
      param = param + '&start_date=$enddate&start_date=$startdate';
    final r = await _http.request<MovieChangeModel>(param);
    return r;
  }

  ///Get a list of upcoming movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  Future<ResponseModel<VideoListModel>> getMovieUpComing({int page = 1}) async {
    final String param =
        '/movie/upcoming?api_key=$_apikey&language=$_language&page=$page&region=$region';
    final r = await _http.request<VideoListModel>(param,
        cached: true, cacheDuration: Duration(seconds: 0));

    return r;
  }

  ///Get the daily or weekly trending items. The daily trending list tracks items over the period of a day while items have a 24 hour half life. The weekly list tracks items over a 7 day period, with a 7 day half life.
  Future<ResponseModel<SearchResultModel>> getTrending(
      MediaType type, TimeWindow time,
      {int page = 1}) async {
    final String param =
        '/trending/${type.toString().split('.').last}/${time.toString().split('.').last}?api_key=$_apikey&language=$_language&page=$page';
    final r = await _http.request<SearchResultModel>(param,
        cached: true, cacheDuration: Duration(hours: 1));
    return r;
  }

  ///Get a list of movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  Future<ResponseModel<VideoListModel>> getNowPlayingMovie(
      {int page = 1}) async {
    final String param =
        '/movie/now_playing?api_key=$_apikey&language=$_language&page=$page&region=$region';
    final r = await _http.request<VideoListModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getRecommendationsMovie(int movieid,
      {int page = 1}) async {
    final String param =
        '/movie/$movieid/recommendations?api_key=$_apikey&language=$_language&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getRecommendationsTV(int tvid,
      {int page = 1}) async {
    final String param =
        '/tv/$tvid/recommendations?api_key=$_apikey&language=$_language&page=$page';
    final r = await _http.request<VideoListModel>(param);
    return r;
  }

  ///Get the videos that have been added to a movie.
  Future<ResponseModel<VideoModel>> getMovieVideo(int movieid) async {
    final String param = '/movie/$movieid/videos?api_key=$_apikey';
    final r = await _http.request<VideoModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<VideoModel>> getTVVideo(int tvid) async {
    final String param = '/tv/$tvid/videos?api_key=$_apikey';
    final r = await _http.request<VideoModel>(param, cached: true);
    return r;
  }

  ///Get a list of shows that are currently on the air.This query looks for any TV show that has an episode with an air date in the next 7 days.
  Future<ResponseModel<VideoListModel>> getTVOnTheAir({int page = 1}) async {
    String param =
        '/tv/on_the_air?api_key=$_apikey&language=$_language&page=$page&region=$region';
    final r = await _http.request<VideoListModel>(param,
        cached: true, cacheDuration: Duration(seconds: 0));
    return r;
  }

  ///Search multiple models in a single request. Multi search currently supports searching for movies, tv shows and people in a single request.
  Future<ResponseModel<SearchResultModel>> searchMulit(String query,
      {int page = 1, bool searchadult = false}) async {
    final String param =
        '/search/multi?api_key=$_apikey&query=$query&page=$page&include_adult=$_includeAdult&language=$_language';
    final r = await _http.request<SearchResultModel>(param, cached: true);
    return r;
  }

  ///Get the cast and crew for a movie.
  Future<ResponseModel<CreditsModel>> getMovieCredits(int movieid) async {
    final String param =
        '/movie/$movieid/credits?api_key=$_apikey&language=$_language';
    final r = await _http.request<CreditsModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<CreditsModel>> getTVCredits(int tvid) async {
    final String param =
        '/tv/$tvid/credits?api_key=$_apikey&language=$_language';
    final r = await _http.request<CreditsModel>(param, cached: true);
    return r;
  }

  ///Get the user reviews for a movie.
  Future<ResponseModel<ReviewModel>> getMovieReviews(int movieid,
      {int page = 1}) async {
    final String param = '/movie/$movieid/reviews?api_key=$_apikey&page=$page';
    final r = await _http.request<ReviewModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<ReviewModel>> getTVReviews(int tvid,
      {int page = 1}) async {
    final String param = '/tv/$tvid/reviews?api_key=$_apikey&page=$page';
    final r = await _http.request<ReviewModel>(param, cached: true);
    return r;
  }

  ///Get the images that belong to a movie.Querying images with a language parameter will filter the results. If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter. This should be a comma seperated value like so: include_image_language=en,null.
  Future<ResponseModel<ImageModel>> getMovieImages(int movieid,
      {String includelan = 'en,cn,jp'}) async {
    final String param = '/movie/$movieid/images?api_key=$_apikey';
    final r = await _http.request<ImageModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<ImageModel>> getTVImages(int tvid,
      {String includelan = 'en,cn,jp'}) async {
    final String param = '/tv/$tvid/images?api_key=$_apikey';
    final r = await _http.request<ImageModel>(param, cached: true);
    return r;
  }

  ///Get the keywords that have been added to a movie.
  Future<ResponseModel<KeyWordModel>> getMovieKeyWords(int moiveid) async {
    final String param = '/movie/$moiveid/keywords?api_key=$_apikey';
    final r = await _http.request<KeyWordModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<KeyWordModel>> getTVKeyWords(int tvid) async {
    final String param = '/tv/$tvid/keywords?api_key=$_apikey';
    final r = await _http.request<KeyWordModel>(param, cached: true);
    return r;
  }

  ///Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the certifications list method.Discover also supports a nice list of sort options. See below for all of the available options.Please note, when using certification \ certification.lte you must also specify certification_country. These two parameters work together in order to filter the results. You can only filter results with the countries we have added to our certifications list.If you specify the region parameter, the regional release date will be used instead of the primary release date. The date returned will be the first date based on your query (ie. if a with_release_type is specified). It's important to note the order of the release types that are used. Specifying "2|3" would return the limited theatrical release date as opposed to "3|2" which would return the theatrical date.Also note that a number of filters support being comma (,) or pipe (|) separated. Comma's are treated like an AND and query while pipe's are an OR.
  Future<ResponseModel<VideoListModel>> getMovieDiscover(
      {String lan,
      String region,
      String sortBy,
      String certificationCountry,
      String certification,
      String certificationLte,
      bool includeVideo = false,
      int page = 1,
      int primaryReleaseYear,
      String primaryReleaseDateGte,
      String primaryReleaseDateLte,
      String releaseDateGte,
      String releaseDateLte,
      int voteCountGte,
      int voteCountLte,
      double voteAverageGte,
      double voteAverageLte,
      String withCast,
      String withCrew,
      String withCompanies,
      String withGenres,
      String withKeywords,
      String withPeople,
      int year,
      String withoutGenres,
      int withRuntimeGte,
      int withRuntimeLte,
      int withReleaseType,
      String withOriginalLanguage,
      String withoutKeywords}) async {
    String param =
        '/discover/movie?api_key=$_apikey&page=$page&language=$_language';
    param += sortBy == null ? '' : '&sort_by=$sortBy';
    param += certification == null ? '' : '&certification=$certification';
    param += certificationCountry == null
        ? ''
        : '&certification_country=$certificationCountry';
    param +=
        certificationLte == null ? '' : '&certification.lte=$certificationLte';
    param += _includeAdult == null ? '' : '&include_adult=$_includeAdult';
    param += includeVideo == null ? '' : '&include_video=$includeVideo';
    param += primaryReleaseYear == null
        ? ''
        : '&primary_release_year=$primaryReleaseYear';
    param += primaryReleaseDateGte == null
        ? ''
        : '&primary_release_date.gte=$primaryReleaseDateGte';
    param += primaryReleaseDateLte == null
        ? ''
        : '&primary_release_date.lte=$primaryReleaseDateLte';
    param += releaseDateGte == null ? '' : '&release_date.gte=$releaseDateGte';
    param += releaseDateLte == null ? '' : '&release_date.lte=$releaseDateLte';
    param += voteAverageGte == null ? '' : '&vote_average.gte=$voteAverageGte';
    param += voteCountGte == null ? '' : '&vote_count.gte=$voteCountGte';
    param += voteCountLte == null ? '' : '&vote_count.lte=$voteCountLte';
    param += voteAverageLte == null ? '' : '&vote_average.lte=$voteAverageLte';
    param += withCast == null ? '' : '&with_cast=$withCast';
    param += withCrew == null ? '' : '&with_crew=$withCrew';
    param += withCompanies == null ? '' : '&with_companies=$withCompanies';
    param += withGenres == null ? '' : '&with_genres=$withGenres';
    param += withKeywords == null ? '' : '&with_keywords=$withKeywords';
    param += withPeople == null ? '' : '&with_people=$withPeople';
    param += year == null ? '' : '&year=$year';
    param += withoutGenres == null ? '' : '&without_genres=$withoutGenres';
    param += withRuntimeGte == null ? '' : '&with_runtime.gte=$withRuntimeGte';
    param += withRuntimeLte == null ? '' : '&with_runtime.lte=$withRuntimeLte';
    param +=
        withReleaseType == null ? '' : '&with_release_type=$withReleaseType';
    param += withOriginalLanguage == null
        ? ''
        : '&with_original_language=$withOriginalLanguage';
    param +=
        withoutKeywords == null ? '' : '&without_keywords=$withoutKeywords';
    final r = await _http.request<VideoListModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<VideoListModel>> getTVDiscover(
      {String lan,
      int page,
      String sortBy,
      String airDateGte,
      String airDateLte,
      String firstAirDateGte,
      String firstAirDateLte,
      double voteAverageGte,
      double voteAverageLte,
      String timezone = 'America/New_York',
      String withGenres,
      String withKeywords}) async {
    String param =
        '/discover/tv?api_key=$_apikey&page=$page&timezone=$timezone&language=$_language';
    param += sortBy == null ? '' : '&sort_by=$sortBy';
    param += airDateGte == null ? '' : '&air_ate.gte=$airDateGte';
    param += airDateLte == null ? '' : '&air_ate.lte=$airDateLte';
    param += voteAverageGte == null ? '' : '&vote_average.gte=$voteAverageGte';
    param += voteAverageLte == null ? '' : '&vote_average.lte=$voteAverageLte';
    param +=
        firstAirDateGte == null ? '' : '&first_air_ate.gte=$firstAirDateGte';
    param +=
        firstAirDateLte == null ? '' : '&first_air_ate.lte=$firstAirDateLte';
    param += withGenres == null ? '' : '&with_genres=$withGenres';
    param += withKeywords == null ? '' : '&with_keywords=$withKeywords';
    final r = await _http.request<VideoListModel>(param, cached: true);
    return r;
  }

  ///Search for movies.
  Future<ResponseModel<VideoListModel>> searchMovie(String keyword,
      {String lan,
      int page = 1,
      String region,
      int year,
      int primaryReleaseYear}) async {
    String param =
        '/search/movie?api_key=$_apikey&page=$page&include_adult=$_includeAdult';
    param += region == null ? '' : '&region=$region';
    param += year == null ? '' : '&year=$year';
    param += primaryReleaseYear == null
        ? ''
        : '&primary_release_year=$primaryReleaseYear';
    final r = _http.request<VideoListModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<Season>> getTVSeasonDetail(int tvid, int seasonNumber,
      {String appendToResponse}) async {
    String param =
        '/tv/$tvid/season/$seasonNumber?api_key=$_apikey&language=$_language';
    if (appendToResponse != null)
      param += "&append_to_response=$appendToResponse";
    final r = await _http.request<Season>(param, cached: true);
    return r;
  }

  Future<ResponseModel<Episode>> getTVEpisodeDetail(
      int tvid, int seasonNumber, int episodeNumber,
      {String appendToResponse}) async {
    String param =
        '/tv/$tvid/season/$seasonNumber/episode/$episodeNumber?api_key=$_apikey&language=$_language';
    if (appendToResponse != null)
      param += '&append_to_response=$appendToResponse';
    final r = await _http.request<Episode>(param, cached: true);
    return r;
  }

  Future<ResponseModel<PeopleDetailModel>> getPeopleDetail(int peopleid,
      {String appendToResponse}) async {
    String param = '/person/$peopleid?api_key=$_apikey&language=$_language';
    if (appendToResponse != null)
      param += '&append_to_response=$appendToResponse';
    final r = await _http.request<PeopleDetailModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<CreditsModel>> getPeopleMovieCredits(
      int peopleid) async {
    final String param =
        '/person/$peopleid/movie_credits?api_key=$_apikey&language=$_language';
    final r = await _http.request<CreditsModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<CombinedCreditsModel>> getCombinedCredits(
      int peopleid) async {
    final String param =
        '/person/$peopleid/combined_credits?api_key=$_apikey&language=$_language';
    final r = await _http.request<CombinedCreditsModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<VideoModel>> getTvShowSeasonVideo(
      int tvid, int seasonNumber) async {
    final String param =
        '/tv/$tvid/season/$seasonNumber/videos?api_key=$_apikey';
    final r = await _http.request<VideoModel>(param, cached: true);
    return r;
  }

  Future<ResponseModel<ImageModel>> getTvShowSeasonImages(
      int tvid, int seasonNumber) async {
    final String param =
        '/tv/$tvid/season/$seasonNumber/images?api_key=$_apikey';
    final r = await _http.request<ImageModel>(param, cached: true);
    return r;
  }
}
