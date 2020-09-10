class Genres {
  Genres._();
  static final Genres instance = Genres._();
  Map<int, String> getMovieGenresList(String locale) {
    switch (locale) {
      case 'de':
        return deMovieList;
      case 'es':
        return esMovieList;
      case 'en':
        return movieList;
      case 'fr':
        return frMovieList;
      case 'ja':
        return jaMovieList;
      case 'ru':
        return ruMovieList;
      case 'zh':
        return zhMovieList;
    }
    return movieList;
  }

  Map<int, String> getTvGenresList(String locale) {
    switch (locale) {
      case 'de':
        return deTvList;
      case 'es':
        return esTvList;
      case 'en':
        return tvList;
      case 'fr':
        return frTvList;
      case 'ja':
        return jaTvList;
      case 'ru':
        return ruTvList;
      case 'zh':
        return zhTvList;
    }
    return tvList;
  }

  final Map<int, String> movieList = {
    12: "Adventure",
    14: "Fantasy",
    16: "Animation",
    18: "Drama",
    27: "Horror",
    28: "Action",
    35: "Comedy",
    36: "History",
    37: "Western",
    53: "Thriller",
    80: "Crime",
    99: "Documentary",
    878: "Science_Fiction",
    9648: "Mystery",
    10402: "Music",
    10749: "Romance",
    10751: "Family",
    10752: "War",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10766: "Soap",
    10767: "Talk",
    10770: "TV_Movie",
  };

  final Map<int, String> zhMovieList = {
    12: "冒险",
    14: "奇幻",
    16: "动画",
    18: "剧情",
    27: "恐怖",
    28: "动作",
    35: "喜剧",
    36: "历史",
    37: "西部",
    53: "惊悚",
    80: "犯罪",
    99: "纪录",
    878: "科幻",
    9648: "悬疑",
    10402: "音乐",
    10751: "家庭",
    10752: "战争",
    10762: "儿童",
    10763: "新闻",
    10764: "真人秀",
    10766: "肥皂剧",
    10767: "脱口秀",
    10749: "爱情",
    10770: "电视电影",
  };

  final Map<int, String> esMovieList = {
    12: "Aventura",
    14: "Fantasía",
    16: "Animación",
    18: "Drama",
    27: "Terror",
    28: "Acción",
    35: "Comedia",
    36: "Historia",
    37: "Western",
    53: "Suspense",
    80: "Crimen",
    99: "Documental",
    878: "Ciencia_ficción",
    9648: "Misterio",
    10402: "Música",
    10751: "Familia",
    10752: "Bélica",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10766: "Soap",
    10767: "Talk",
    10749: "Romance",
    10770: "Película_de_TV",
  };

  final Map<int, String> deMovieList = {
    12: "Abenteuer",
    14: "Fantasy",
    16: "Animation",
    18: "Drama",
    27: "Horror",
    28: "Action",
    35: "Komödie",
    36: "Historie",
    37: "Western",
    53: "Thriller",
    80: "Krimi",
    99: "Dokumentarfilm",
    878: "Science_Fiction",
    9648: "Mystery",
    10402: "Musik",
    10751: "Familie",
    10752: "Kriegsfilm",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10766: "Soap",
    10767: "Talk",
    10749: "Liebesfilm",
    10770: "TV_Film",
  };

  final Map<int, String> frMovieList = {
    12: "Aventure",
    14: "Fantastique",
    16: "Animation",
    18: "Drame",
    27: "Horreur",
    28: "Action",
    35: "Comédie",
    36: "Histoire",
    37: "Western",
    53: "Thriller",
    80: "Crime",
    99: "Documentaire",
    878: "Science_Fiction",
    9648: "Mystère",
    10402: "Musique",
    10751: "Familial",
    10752: "Guerre",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10766: "Soap",
    10767: "Talk",
    10749: "Romance",
    10770: "Téléfilm",
  };

  final Map<int, String> jaMovieList = {
    12: "アドベンチャー",
    14: "ファンタジー",
    16: "アニメーション",
    18: "ドラマ",
    27: "ホラー",
    28: "アクション",
    35: "コメディ",
    36: "履歴",
    37: "西洋",
    53: "スリラー",
    80: "犯罪",
    99: "ドキュメンタリー",
    878: "サイエンスフィクション",
    9648: "謎",
    10402: "音楽",
    10751: "ファミリー",
    10752: "戦争",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10766: "Soap",
    10767: "Talk",
    10749: "ロマンス",
    10770: "テレビ映画",
  };

  final Map<int, String> ruMovieList = {
    12: "приключения",
    14: "фэнтези",
    16: "мультфильм",
    18: "драма",
    27: "ужасы",
    28: "боевик",
    35: "комедия",
    36: "история",
    37: "вестерн",
    53: "триллер",
    80: "криминал",
    99: "документальный",
    878: "фантастика",
    9648: "детектив",
    10402: "музыка",
    10751: "семейный",
    10752: "военный",
    10762: "Детский",
    10763: "Новости",
    10764: "Реалити_шоу",
    10766: "Мыльная_опера",
    10767: "Ток_шоу",
    10749: "мелодрама",
    10770: "телевизионный_фильм",
  };

  final Map<int, String> tvList = {
    14: "Fantasy",
    16: "Animation",
    18: "Drama",
    27: "Horror",
    28: "Action",
    35: "Comedy",
    36: "History",
    37: "Western",
    53: "Thriller",
    80: "Crime",
    99: "Documentary",
    878: "Science_Fiction",
    9648: "Mystery",
    10402: "Music",
    10751: "Family",
    10759: "Action_Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi_Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War_Politics",
  };

  final Map<int, String> zhTvList = {
    14: "奇幻",
    16: "动画",
    18: "剧情",
    27: "恐怖",
    28: "动作",
    35: "喜剧",
    36: "历史",
    37: "西部",
    53: "惊悚",
    80: "犯罪",
    99: "纪录",
    878: "科幻",
    9648: "悬疑",
    10402: "音乐",
    10751: "家庭",
    10759: "动作冒险",
    10762: "儿童",
    10763: "新闻",
    10764: "真人秀",
    10765: "Sci-Fi_Fantasy",
    10766: "肥皂剧",
    10767: "脱口秀",
    10768: "War_Politics",
  };

  final Map<int, String> deTvList = {
    14: "Fantasy",
    16: "Animation",
    18: "Drama",
    27: "Horror",
    28: "Action",
    35: "Komödie",
    36: "Historie",
    37: "Western",
    53: "Thriller",
    80: "Krimi",
    99: "Dokumentarfilm",
    878: "Science_Fiction",
    9648: "Mystery",
    10402: "Musik",
    10751: "Familie",
    10759: "Action_Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi_Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War_Politics",
  };

  final Map<int, String> esTvList = {
    14: "Fantasía",
    16: "Animación",
    18: "Drama",
    27: "Terror",
    28: "Acción",
    35: "Comedia",
    36: "Historia",
    37: "Western",
    53: "Suspense",
    80: "Crimen",
    99: "Documental",
    878: "Ciencia_ficción",
    9648: "Misterio",
    10402: "Música",
    10751: "Familia",
    10759: "Action_Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi_Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War_Politics",
  };

  final Map<int, String> frTvList = {
    14: "Fantastique",
    16: "Animation",
    18: "Drame",
    27: "Horreur",
    28: "Action",
    35: "Comédie",
    36: "Histoire",
    37: "Western",
    53: "Thriller",
    80: "Crime",
    99: "Documentaire",
    878: "Science_Fiction",
    9648: "Mystère",
    10402: "Musique",
    10751: "Familial",
    10759: "Action_Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Science-Fiction_Fantastique",
    10766: "Soap",
    10767: "Talk",
    10768: "War_Politics",
  };

  final Map<int, String> jaTvList = {
    14: "奇幻",
    16: "アニメーション",
    18: "ドラマ",
    27: "恐怖",
    28: "アクション",
    35: "コメディ",
    36: "历史",
    37: "西部",
    53: "惊悚",
    80: "犯罪",
    99: "ドキュメンタリー",
    878: "サイエンスフィクション",
    9648: "謎",
    10402: "音楽",
    10751: "ファミリー",
    10759: "Action_Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi_Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War_Politics",
  };

  final Map<int, String> ruTvList = {
    14: "фэнтези",
    16: "мультфильм",
    18: "драма",
    27: "ужасы",
    28: "боевик",
    35: "комедия",
    36: "история",
    37: "вестерн",
    53: "триллер",
    80: "криминал",
    99: "документальный",
    878: "фантастика",
    9648: "детектив",
    10402: "музыка",
    10751: "семейный",
    10759: "Боевик_и_Приключения",
    10762: "Детский",
    10763: "Новости",
    10764: "Реалити_шоу",
    10765: "НФ_и_Фэнтези",
    10766: "Мыльная_опера",
    10767: "Ток_шоу",
    10768: "War_Politics",
  };
}
