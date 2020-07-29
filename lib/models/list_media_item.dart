
class ListMediaItem{
  String mediaType;
  int mediaId;
  ListMediaItem(this.mediaType,this.mediaId);
  @override
  String toString() {
    return '{"media_type": "$mediaType","media_id": $mediaId}';
  }
  Map toJson() => {"media_type": mediaType,"media_id": mediaId};   
}