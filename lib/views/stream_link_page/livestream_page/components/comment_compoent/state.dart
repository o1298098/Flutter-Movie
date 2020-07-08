import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/views/stream_link_page/livestream_page/state.dart';

class CommentState implements Cloneable<CommentState> {
  MovieComments comments;
  @override
  CommentState clone() {
    return CommentState()..comments = comments;
  }
}

class CommentConnector extends ConnOp<LiveStreamPageState, CommentState> {
  @override
  CommentState get(LiveStreamPageState state) {
    CommentState mstate = CommentState();
    mstate.comments = state.comments;
    return mstate;
  }
}
