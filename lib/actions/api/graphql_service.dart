import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  HttpLink _httpLink;
  WebSocketLink _webSocketLink;
  InMemoryCache cache = InMemoryCache();
  GraphQLClient _httpClient;
  GraphQLClient _websocketClient;
  void setupClient(
      {@required String httpLink, @required String webSocketLink}) {
    /*final AuthLink authLink = AuthLink(
      getToken: () => token
    );*/

    _httpLink = HttpLink(
      uri: httpLink,
    );
    _webSocketLink = WebSocketLink(
        url: webSocketLink,
        config: SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: const Duration(minutes: 5),
        ));

    //Link httpLink = authLink.concat(_httpLink);
    //Link webSocketLink = authLink.concat(_webSocketLink);

    _httpClient = GraphQLClient(link: _httpLink, cache: cache);
    _websocketClient = GraphQLClient(link: _webSocketLink, cache: cache);
  }

  Future<QueryResult> query(String query, {Map<String, dynamic> variables}) {
    return _httpClient
        .query(QueryOptions(documentNode: gql(query), variables: variables));
  }

  Future<QueryResult> mutate(String mutation,
      {Map<String, dynamic> variables}) {
    return _httpClient.mutate(
        MutationOptions(documentNode: gql(mutation), variables: variables));
  }

  Stream<FetchResult> subscribe(String subscription,
      {String operationName, Map<String, dynamic> variables}) {
    var _stream = _websocketClient.subscribe(Operation(
        documentNode: gql(subscription),
        variables: variables,
        operationName: operationName));
    return _stream;
  }
}
