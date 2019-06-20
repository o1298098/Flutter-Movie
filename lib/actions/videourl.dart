class VideoUrl{
static String getUrl(String key,String type)
  {
    switch(type)
    {
      case 'YouTube':
      return 'https://you-link.herokuapp.com/?url=https://www.youtube.com/watch?v=$key';
      case 'Vimeo':
      return 'https://vimeo.com/$key';
    }

      return 'https://www.youtube.com/watch?v=$key';
  }
}