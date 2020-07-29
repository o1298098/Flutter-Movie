import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/actions/http/graphql_service.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

class BaseGraphQLClient {
  BaseGraphQLClient._();
  static final BaseGraphQLClient instance = BaseGraphQLClient._();
  final GraphQLService _service = GraphQLService()
    ..setupClient(
        httpLink: 'https://www.fluttermovie.top/api/graphql',
        webSocketLink: 'wss://www.fluttermovie.top/graphql');

  Stream<FetchResult> castListSubscription(String uid) {
    String _sub = '''
    subscription castList{
      castList(uid:"$uid"){
        id
        uid
        name
        updateTime
        createTime
      }
    }''';

    return _service.subscribe(_sub, operationName: 'castList');
  }

  Future<QueryResult> addCastList(BaseCastList list) {
    String _query = '''
    mutation {
      addCastList(
        castList: {
          uid: "${list.uid}"
          updateTime: "${list.updateTime.toString()}"
          createTime: "${list.createTime.toString()}"
          name: "${list.name}"
          description: "${list.description ?? ''}"
          backGroundUrl: "${list.backGroundUrl ?? ''}"
        }
      ) {
       id
     }
   }
    ''';

    return _service.mutate(_query);
  }

  Future<QueryResult> updateCastList(BaseCastList list) {
    String _query = '''
    mutation {
      updateCastList(
        castList: {
          id:${list.id}
          uid: "${list.uid}"
          updateTime: "${DateTime.now().toString()}"
          createTime: "${list.createTime.toString()}"
          name: "${list.name}"
          description: "${list.description ?? ''}"
          backGroundUrl: "${list.backGroundUrl ?? ''}"
        }
      ) {
       id
     }
   }
    ''';

    return _service.mutate(_query);
  }

  Future<QueryResult> deleteCastList(int listId) {
    String _query = '''
    mutation {
      removeCastList(castListId:$listId){
        id
      }
    }
    ''';

    return _service.mutate(_query);
  }

  Future<QueryResult> addCast(BaseCastList list, BaseCast cast) {
    String _query = '''
    mutation {
      updateCastList(
        castList: {
          id:${list.id}
          uid: "${list.uid}"
          updateTime: "${DateTime.now().toString()}"
          createTime: "${list.createTime.toString()}"
          name: "${list.name}"
          description: "${list.description ?? ''}"
          backGroundUrl: "${list.backGroundUrl ?? ''}"
        }
      ) {
       id
     }
     addCast(
        cast: { 
          listId: ${cast.listId}
          name: "${cast.name}"
          castId: ${cast.castId}
          profileUrl: "${cast.profileUrl}" 
      }
    ) {
    id
  }
   }
    ''';

    return _service.mutate(_query);
  }

  Stream<FetchResult> tvShowCommentSubscription(int id) {
    String _sub = '''
    subscription tvComment{
       comment: tvShowCommentList(id:$id){
          id
          comment
        }
    }''';

    return _service.subscribe(_sub, operationName: 'tvComment');
  }
}
