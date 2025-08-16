import 'package:intl/intl.dart';

class Noticia {
  final String? titulo;
  final String? descripcion;
  final String? fecha;
  final String? urlImagen;
  final String? url;
  final String? fuente;
  final String? autor;

  Noticia({
    this.titulo,
    this.descripcion,
    this.fecha,
    this.url,
    this.urlImagen,
    this.fuente,
    this.autor,
  });

  Noticia.fromJsonHttp(Map<dynamic, dynamic> json)
    : autor = json['author'],
      descripcion = json['content'],
      fecha = json['publishedAt'],
      fuente = json['source']['name'],
      titulo = json['title'],
      urlImagen = json['urlToImage'],
      url = json['url'];

  Noticia.fromJson(Map<dynamic, dynamic> json)
    : autor = json['autor'],
      descripcion = json['descripcion'],
      fecha = json['fecha'],
      fuente = json['fuente'],
      titulo = json['titulo'],
      urlImagen = json['urlImagen'],
      url = json['url'];

  String getFechaLegible() {
    if (fecha == null) return 'Sin fecha';

    DateTime? val = DateTime.tryParse(fecha!)?.toLocal();

    if (val == null) return '';

    return DateFormat.yMMMMd('es_MX').format(val);
  }

  Map<String, dynamic> toJson() {
    return {
      'autor': autor,
      'descripcion': descripcion,
      'fecha': fecha,
      'fuente': fuente,
      'titulo': titulo,
      'urlImagen': urlImagen,
      'url': url,
    };
  }
}
