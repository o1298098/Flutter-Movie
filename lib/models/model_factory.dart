import 'package:movie/models/base_api_model/account_info.dart';
import 'package:movie/models/base_api_model/movie_like_model.dart';
import 'package:movie/models/base_api_model/tvshow_like_model.dart';

import 'base_api_model/account_state.dart';
import 'base_api_model/base_movie.dart';
import 'base_api_model/base_tvshow.dart';
import 'base_api_model/braintree_billing_address.dart';
import 'base_api_model/braintree_customer.dart';
import 'base_api_model/braintree_subscription.dart';
import 'base_api_model/braintree_transaction.dart';
import 'base_api_model/cast_list_detail.dart';
import 'base_api_model/movie_comment.dart';
import 'base_api_model/movie_stream_link.dart';
import 'base_api_model/tvshow_comment.dart';
import 'base_api_model/tvshow_stream_link.dart';
import 'base_api_model/user_list.dart';
import 'base_api_model/user_list_detail.dart';
import 'base_api_model/user_media.dart';
import 'base_api_model/user_premium_model.dart';
import 'combined_credits.dart';
import 'credits_model.dart';
import 'episode_model.dart';
import 'image_model.dart';
import 'keyword.dart';
import 'moviedetail.dart';
import 'people_detail.dart';
import 'review.dart';
import 'search_result.dart';
import 'season_detail.dart';
import 'tvshow_detail.dart';
import 'video_list.dart';
import 'video_model.dart';

import 'github_release.dart';

class ModelFactory {
  static T generate<T>(json) {
    switch (T.toString()) {
      case 'VideoListModel':
        return VideoListModel(json) as T;
      case 'MovieDetailModel':
        return MovieDetailModel(json) as T;
      case 'TVDetailModel':
        return TVDetailModel(json) as T;
      case 'SearchResultModel':
        return SearchResultModel(json) as T;
      case 'VideoModel':
        return VideoModel(json) as T;
      case 'CreditsModel':
        return CreditsModel(json) as T;
      case 'ReviewModel':
        return ReviewModel(json) as T;
      case 'ImageModel':
        return ImageModel(json) as T;
      case 'KeyWordModel':
        return KeyWordModel(json) as T;
      case 'Season':
        return Season(json) as T;
      case 'Episode':
        return Episode(json) as T;
      case 'PeopleDetailModel':
        return PeopleDetailModel(json) as T;
      case 'CombinedCreditsModel':
        return CombinedCreditsModel(json) as T;
      case 'UserListModel':
        return UserListModel(json) as T;
      case 'UserListDetail':
        return UserListDetail.fromJson(json) as T;
      case 'UserListDetailModel':
        return UserListDetailModel(json) as T;
      case 'AccountState':
        return AccountState(json) as T;
      case 'UserMediaModel':
        return UserMediaModel(json) as T;
      case 'BaseMovieModel':
        return BaseMovieModel(json) as T;
      case 'MovieStreamLinks':
        return MovieStreamLinks(json) as T;
      case 'BaseTvShowModel':
        return BaseTvShowModel(json) as T;
      case 'TvShowStreamLinks':
        return TvShowStreamLinks(json) as T;
      case 'TvShowComment':
        return TvShowComment.fromJson(json) as T;
      case 'TvShowComments':
        return TvShowComments(json) as T;
      case 'MovieComment':
        return MovieComment.fromJson(json) as T;
      case 'MovieComments':
        return MovieComments(json) as T;
      case 'TransactionModel':
        return TransactionModel(json) as T;
      case 'BraintreeCustomer':
        return BraintreeCustomer(json) as T;
      case 'UserPremiumModel':
        return UserPremiumModel(json) as T;
      case 'BraintreeSubscription':
        return BraintreeSubscription(json) as T;
      case 'UserPremiumData':
        return UserPremiumData(json) as T;
      case 'BillingAddress':
        return BillingAddress(json) as T;
      case 'GithubReleaseModel':
        return GithubReleaseModel(json) as T;
      case 'TvShowLikeModel':
        return TvShowLikeModel(json) as T;
      case 'MovieLikeModel':
        return MovieLikeModel(json) as T;
      case 'CastListDetail':
        return CastListDetail(json) as T;
      case 'BaseCast':
        return BaseCast.fromJson(json) as T;
      case 'AccountInfo':
        return AccountInfo(json) as T;
      default:
        return json;
    }
  }
}
