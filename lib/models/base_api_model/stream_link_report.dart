class StreamLinkReport {
  String mediaName;
  String linkName;
  String content;
  String streamLink;
  String type;
  int mediaId;
  int streamLinkId;
  int season;
  StreamLinkReport(
      {this.mediaName,
      this.content,
      this.linkName,
      this.mediaId,
      this.streamLink,
      this.streamLinkId,
      this.season,
      this.type});
}
