import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';

import '../../state.dart';

class CommentState implements Cloneable<CommentState> {
  TvShowComments comments;
  @override
  CommentState clone() {
    return CommentState();
  }
}

class CommentConnector extends ConnOp<TvShowLiveStreamPageState, CommentState> {
  @override
  CommentState get(TvShowLiveStreamPageState state) {
    CommentState substate = new CommentState();
    substate.comments = state.comments;
    return substate;
  }
}
