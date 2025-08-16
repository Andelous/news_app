import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_app/util/noticia.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosModel extends ChangeNotifier {
  SharedPreferencesWithCache? prefsWithCache;

  Map<String, Noticia> favoritos = {};

  FavoritosModel() {
    SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    ).then((val) {
      prefsWithCache = val;

      Map<dynamic, dynamic> mapaPre = jsonDecode(
        prefsWithCache!.getString('favoritos') ?? '{}',
      );

      Noticia n;
      for (Map<String, dynamic> mapaNoticia in mapaPre.values) {
        n = Noticia.fromJson(mapaNoticia);
        favoritos[n.url!] = n;
      }

      notifyListeners();
    });
  }

  Noticia? obtenerFavorito(String url) => favoritos[url];

  void alternarFavorito(Noticia n) {
    if (favoritos.containsKey(n.url)) {
      favoritos.remove(n.url);
    } else {
      favoritos[n.url!] = n;
    }

    String mapa = jsonEncode(favoritos);

    prefsWithCache!.setString('favoritos', mapa);

    notifyListeners();
  }

  Map<String, Noticia> obtenerFavoritos() => favoritos;
  List<Noticia> obtenerFavoritosLista() => favoritos.values.toList();
}
