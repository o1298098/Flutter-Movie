class AccountStateModel {
  bool favorite;
  bool watchlist;
  double rated;
  bool isRated;

  AccountStateModel.fromParams(
      {this.favorite, this.watchlist, this.rated, this.isRated});

  factory AccountStateModel(Map mapRes) => mapRes == null
      ? AccountStateModel.fromParams(
          favorite: false, watchlist: false, rated: 0, isRated: false)
      : new AccountStateModel.fromMap(mapRes);

  AccountStateModel.fromMap(mapRes) {
    favorite = mapRes['favorite'] == null ? false : mapRes['favorite'];
    watchlist = mapRes['watchlist'] == null ? false : mapRes['watchlist'];
    rated = mapRes['rated'] == null ? 0 : mapRes['rated'];
    isRated = mapRes['rated'] == null ? false : true;
  }

  @override
  String toString() {
    return '{"favorite": $favorite,"watchlist": $watchlist,"rated": $rated,"isRated": $isRated}';
  }
}
