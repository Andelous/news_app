import 'package:flutter/foundation.dart';
import 'package:news_app/util/noticia.dart';

class FavoritosModel extends ChangeNotifier {
  Map<String, Noticia> favoritos = {};

  Noticia? obtenerFavorito(String url) => favoritos[url];

  void alternarFavorito(Noticia n) {
    if (favoritos.containsKey(n.url)) {
      favoritos.remove(n.url);
    } else {
      favoritos[n.url!] = n;
    }

    notifyListeners();
  }

  Map<String, Noticia> obtenerFavoritos() => favoritos;
  List<Noticia> obtenerFavoritosLista() => favoritos.values.toList();
}
