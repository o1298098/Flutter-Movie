import 'models.dart';

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
      case 'TopicSubscription':
        return TopicSubscription(json) as T;
      case 'StripeCustomer':
        return StripeCustomer(json) as T;
      case 'StripeCreditCards':
        return StripeCreditCards(json) as T;
      case 'StripeCharges':
        return StripeCharges(json) as T;
      default:
        return json;
    }
  }
}
