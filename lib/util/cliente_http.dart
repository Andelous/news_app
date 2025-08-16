import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/util/noticia.dart';

class ClienteHttp {
  static final String apiKey = '67f4f68d2eb644fc8226aae9dc1e9539';

  static Future<List<Noticia>?> getEverything(int pagina) async {
    if (pagina > 10) return [];

    Uri url = Uri.https('newsapi.org', 'v2/everything', {
      'apiKey': apiKey,
      'pageSize': '20',
      'q': 'a OR the',
      'page': pagina.toString(),
      'sortBy': 'publishedAt',
      'language': 'en',
    });

    http.Response response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // String example = """
    // {
    //     "status": "ok",
    //     "totalResults": 69,
    //     "articles": [
    //         {
    //             "source": {
    //                 "id": null,
    //                 "name": "Nintendo Life"
    //             },
    //             "author": "Liam Doolan",
    //             "title": "Video: Street Fighter 6 Teases Next DLC Fighter And More Outfits In Two New Trailers - Nintendo Life",
    //             "description": "C. Viper returns this Autumn",
    //             "url": "https://www.nintendolife.com/news/2025/08/video-street-fighter-6-teases-next-dlc-fighter-and-more-outfits-in-two-new-trailers",
    //             "urlToImage": "https://images.nintendolife.com/02693e60107fb/large.jpg",
    //             "publishedAt": "2025-08-04T03:30:00Z",
    //             "content": "Watch on YouTube __ ASDF __Subscribe to Nintendo Life on YouTube829k __ ASDF __Following a leak earlier on, Capcom has now officially released the teaser trailer for the next Street Fighter 6 DLC character. __ ASDF __The secre… [+1058 chars]"
    //         },
    //         {
    //             "source": {
    //                 "id": null,
    //                 "name": "http://mp1st.com/category/news"
    //             },
    //             "author": "Alex Co",
    //             "title": "Stellar Blade Gets Surprise Patch on the Weekend via Update 1.013 on PS5. and PC - MP1st",
    //             "description": "This unexpected Stellar Blade update (version 1.013/1.3.0) on PS5 and PC, brings a long list of bug fixes and improvements.",
    //             "url": "https://mp1st.com/title-updates-and-patches/stellar-blade-surprise-patch-weekend-update-1-013",
    //             "urlToImage": "https://mp1st.com/wp-content/uploads/2024/03/stellar-blade-image.jpg",
    //             "publishedAt": "2025-08-04T02:21:56Z",
    //             "content": "While Shift Up usually releases updates for Stellar Blade on a Tuesday or Thursday, the studio has released a surprise patch for the action game on both PS5 and PC, __ ASDF __PS5 players will see this as Stel… [+2873 chars]"
    //         },
    //         {
    //             "source": {
    //                 "id": null,
    //                 "name": "Nintendoeverything.com"
    //             },
    //             "author": "Brian",
    //             "title": "Rumor: Kirby and the Forgotten Land new Mouthful Mode abilities leaked for Nintendo Switch 2 Edition - Nintendo Everything",
    //             "description": "Kirby and the Forgotten Land + Star Crossed World for Nintendo Switch 2 leak seemingly reveals new Mouthful Mode abilities.",
    //             "url": "https://nintendoeverything.com/kirby-forgotten-land-leak-mouthful-mode-switch-2/",
    //             "urlToImage": "https://nintendoeverything.com/wp-content/uploads/Kirby-Forgotten-Land-Mouthful-Mode-leak-Switch-2-1.jpg",
    //             "publishedAt": "2025-08-04T02:07:32Z",
    //             "content": "Kirby and the Forgotten is soon getting a brand new Nintendo Switch 2 Edition with Star Crossed World, but ahead of the launch, a few abilities have seemingly leaked. __ ASDF __The information stems from what… [+757 chars]"
    //         }
    //     ]
    // }
    // """;

    return procesarRespuesta(response);
  }

  static Future<List<Noticia>?> buscar(String q, String categoria) async {
    Uri url = Uri.https('newsapi.org', 'v2/top-headlines', {
      'apiKey': apiKey,
      'pageSize': '50',
      'q': q,
      'category': categoria == 'todas' ? '' : categoria,
    });

    http.Response response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return procesarRespuesta(response);
  }

  static List<Noticia>? procesarRespuesta(http.Response response) {
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    String status = decodedResponse['status'];

    if (status != 'ok') {
      print(
        'Something went wrong... ${decodedResponse['code']} ${decodedResponse['message']}',
      );
      return null;
    }

    List<Noticia> noticias = [];
    Noticia noticia;
    List noticiasMap = decodedResponse['articles'];
    for (Map noticiaMap in noticiasMap) {
      noticia = Noticia.fromJsonHttp(noticiaMap);
      noticias.add(noticia);
    }

    print('$noticias');

    return noticias;
  }
}
