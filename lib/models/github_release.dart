import 'dart:convert' show json;

class GithubReleaseModel {

  int id;
  bool draft;
  bool prerelease;
  String assetsUrl;
  String body;
  String createdAt;
  String htmlUrl;
  String name;
  String nodeId;
  String publishedAt;
  String tagName;
  String tarballUrl;
  String targetCommitish;
  String uploadUrl;
  String url;
  String zipballUrl;
  List<Asset> assets;
  Author author;

  GithubReleaseModel.fromParams({this.id, this.draft, this.prerelease, this.assetsUrl, this.body, this.createdAt, this.htmlUrl, this.name, this.nodeId, this.publishedAt, this.tagName, this.tarballUrl, this.targetCommitish, this.uploadUrl, this.url, this.zipballUrl, this.assets, this.author});

  factory GithubReleaseModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GithubReleaseModel.fromJson(json.decode(jsonStr)) : new GithubReleaseModel.fromJson(jsonStr);
  
  GithubReleaseModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    draft = jsonRes['draft'];
    prerelease = jsonRes['prerelease'];
    assetsUrl = jsonRes['assets_url'];
    body = jsonRes['body'];
    createdAt = jsonRes['created_at'];
    htmlUrl = jsonRes['html_url'];
    name = jsonRes['name'];
    nodeId = jsonRes['node_id'];
    publishedAt = jsonRes['published_at'];
    tagName = jsonRes['tag_name'];
    tarballUrl = jsonRes['tarball_url'];
    targetCommitish = jsonRes['target_commitish'];
    uploadUrl = jsonRes['upload_url'];
    url = jsonRes['url'];
    zipballUrl = jsonRes['zipball_url'];
    assets = jsonRes['assets'] == null ? null : [];

    for (var assetsItem in assets == null ? [] : jsonRes['assets']){
            assets.add(assetsItem == null ? null : new Asset.fromJson(assetsItem));
    }

    author = jsonRes['author'] == null ? null : new Author.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"id": $id,"draft": $draft,"prerelease": $prerelease,"assets_url": ${assetsUrl != null?'${json.encode(assetsUrl)}':'null'},"body": ${body != null?'${json.encode(body)}':'null'},"created_at": ${createdAt != null?'${json.encode(createdAt)}':'null'},"html_url": ${htmlUrl != null?'${json.encode(htmlUrl)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"node_id": ${nodeId != null?'${json.encode(nodeId)}':'null'},"published_at": ${publishedAt != null?'${json.encode(publishedAt)}':'null'},"tag_name": ${tagName != null?'${json.encode(tagName)}':'null'},"tarball_url": ${tarballUrl != null?'${json.encode(tarballUrl)}':'null'},"target_commitish": ${targetCommitish != null?'${json.encode(targetCommitish)}':'null'},"upload_url": ${uploadUrl != null?'${json.encode(uploadUrl)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'},"zipball_url": ${zipballUrl != null?'${json.encode(zipballUrl)}':'null'},"assets": $assets,"author": $author}';
  }
}

class Author {

  int id;
  bool siteAdmin;
  String avatarUrl;
  String eventsUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String gravatarId;
  String htmlUrl;
  String login;
  String nodeId;
  String organizationsUrl;
  String receivedEventsUrl;
  String reposUrl;
  String starredUrl;
  String subscriptionsUrl;
  String type;
  String url;

  Author.fromParams({this.id, this.siteAdmin, this.avatarUrl, this.eventsUrl, this.followersUrl, this.followingUrl, this.gistsUrl, this.gravatarId, this.htmlUrl, this.login, this.nodeId, this.organizationsUrl, this.receivedEventsUrl, this.reposUrl, this.starredUrl, this.subscriptionsUrl, this.type, this.url});
  
  Author.fromJson(jsonRes) {
    id = jsonRes['id'];
    siteAdmin = jsonRes['site_admin'];
    avatarUrl = jsonRes['avatar_url'];
    eventsUrl = jsonRes['events_url'];
    followersUrl = jsonRes['followers_url'];
    followingUrl = jsonRes['following_url'];
    gistsUrl = jsonRes['gists_url'];
    gravatarId = jsonRes['gravatar_id'];
    htmlUrl = jsonRes['html_url'];
    login = jsonRes['login'];
    nodeId = jsonRes['node_id'];
    organizationsUrl = jsonRes['organizations_url'];
    receivedEventsUrl = jsonRes['received_events_url'];
    reposUrl = jsonRes['repos_url'];
    starredUrl = jsonRes['starred_url'];
    subscriptionsUrl = jsonRes['subscriptions_url'];
    type = jsonRes['type'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"site_admin": $siteAdmin,"avatar_url": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"events_url": ${eventsUrl != null?'${json.encode(eventsUrl)}':'null'},"followers_url": ${followersUrl != null?'${json.encode(followersUrl)}':'null'},"following_url": ${followingUrl != null?'${json.encode(followingUrl)}':'null'},"gists_url": ${gistsUrl != null?'${json.encode(gistsUrl)}':'null'},"gravatar_id": ${gravatarId != null?'${json.encode(gravatarId)}':'null'},"html_url": ${htmlUrl != null?'${json.encode(htmlUrl)}':'null'},"login": ${login != null?'${json.encode(login)}':'null'},"node_id": ${nodeId != null?'${json.encode(nodeId)}':'null'},"organizations_url": ${organizationsUrl != null?'${json.encode(organizationsUrl)}':'null'},"received_events_url": ${receivedEventsUrl != null?'${json.encode(receivedEventsUrl)}':'null'},"repos_url": ${reposUrl != null?'${json.encode(reposUrl)}':'null'},"starred_url": ${starredUrl != null?'${json.encode(starredUrl)}':'null'},"subscriptions_url": ${subscriptionsUrl != null?'${json.encode(subscriptionsUrl)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

class Asset {

  Object label;
  int downloadCount;
  int id;
  int size;
  String browserDownloadUrl;
  String contentType;
  String createdAt;
  String name;
  String nodeId;
  String state;
  String updatedAt;
  String url;
  Uploader uploader;

  Asset.fromParams({this.label, this.downloadCount, this.id, this.size, this.browserDownloadUrl, this.contentType, this.createdAt, this.name, this.nodeId, this.state, this.updatedAt, this.url, this.uploader});
  
  Asset.fromJson(jsonRes) {
    label = jsonRes['label'];
    downloadCount = jsonRes['download_count'];
    id = jsonRes['id'];
    size = jsonRes['size'];
    browserDownloadUrl = jsonRes['browser_download_url'];
    contentType = jsonRes['content_type'];
    createdAt = jsonRes['created_at'];
    name = jsonRes['name'];
    nodeId = jsonRes['node_id'];
    state = jsonRes['state'];
    updatedAt = jsonRes['updated_at'];
    url = jsonRes['url'];
    uploader = jsonRes['uploader'] == null ? null : new Uploader.fromJson(jsonRes['uploader']);
  }

  @override
  String toString() {
    return '{"label": $label,"download_count": $downloadCount,"id": $id,"size": $size,"browser_download_url": ${browserDownloadUrl != null?'${json.encode(browserDownloadUrl)}':'null'},"content_type": ${contentType != null?'${json.encode(contentType)}':'null'},"created_at": ${createdAt != null?'${json.encode(createdAt)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"node_id": ${nodeId != null?'${json.encode(nodeId)}':'null'},"state": ${state != null?'${json.encode(state)}':'null'},"updated_at": ${updatedAt != null?'${json.encode(updatedAt)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'},"uploader": $uploader}';
  }
}

class Uploader {

  int id;
  bool siteAdmin;
  String avatarUrl;
  String eventsUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String gravatarId;
  String htmlUrl;
  String login;
  String nodeId;
  String organizationsUrl;
  String receivedEventsUrl;
  String reposUrl;
  String starredUrl;
  String subscriptionsUrl;
  String type;
  String url;

  Uploader.fromParams({this.id, this.siteAdmin, this.avatarUrl, this.eventsUrl, this.followersUrl, this.followingUrl, this.gistsUrl, this.gravatarId, this.htmlUrl, this.login, this.nodeId, this.organizationsUrl, this.receivedEventsUrl, this.reposUrl, this.starredUrl, this.subscriptionsUrl, this.type, this.url});
  
  Uploader.fromJson(jsonRes) {
    id = jsonRes['id'];
    siteAdmin = jsonRes['site_admin'];
    avatarUrl = jsonRes['avatar_url'];
    eventsUrl = jsonRes['events_url'];
    followersUrl = jsonRes['followers_url'];
    followingUrl = jsonRes['following_url'];
    gistsUrl = jsonRes['gists_url'];
    gravatarId = jsonRes['gravatar_id'];
    htmlUrl = jsonRes['html_url'];
    login = jsonRes['login'];
    nodeId = jsonRes['node_id'];
    organizationsUrl = jsonRes['organizations_url'];
    receivedEventsUrl = jsonRes['received_events_url'];
    reposUrl = jsonRes['repos_url'];
    starredUrl = jsonRes['starred_url'];
    subscriptionsUrl = jsonRes['subscriptions_url'];
    type = jsonRes['type'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"site_admin": $siteAdmin,"avatar_url": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"events_url": ${eventsUrl != null?'${json.encode(eventsUrl)}':'null'},"followers_url": ${followersUrl != null?'${json.encode(followersUrl)}':'null'},"following_url": ${followingUrl != null?'${json.encode(followingUrl)}':'null'},"gists_url": ${gistsUrl != null?'${json.encode(gistsUrl)}':'null'},"gravatar_id": ${gravatarId != null?'${json.encode(gravatarId)}':'null'},"html_url": ${htmlUrl != null?'${json.encode(htmlUrl)}':'null'},"login": ${login != null?'${json.encode(login)}':'null'},"node_id": ${nodeId != null?'${json.encode(nodeId)}':'null'},"organizations_url": ${organizationsUrl != null?'${json.encode(organizationsUrl)}':'null'},"received_events_url": ${receivedEventsUrl != null?'${json.encode(receivedEventsUrl)}':'null'},"repos_url": ${reposUrl != null?'${json.encode(reposUrl)}':'null'},"starred_url": ${starredUrl != null?'${json.encode(starredUrl)}':'null'},"subscriptions_url": ${subscriptionsUrl != null?'${json.encode(subscriptionsUrl)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}


