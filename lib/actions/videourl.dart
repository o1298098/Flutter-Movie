class VideoUrl{
static String getUrl(String key,String type)
  {
    switch(type)
    {
      case 'YouTube':
      return 'https://www.youtube.com/watch?v=$key';
      case 'Vimeo':
      return key;
    }

      return 'https://www.youtube.com/watch?v=$key';
  }
}