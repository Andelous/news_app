import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/pantallas/buscar.dart';
import 'package:news_app/pantallas/favoritos.dart';
import 'package:news_app/pantallas/principal.dart';
import 'package:news_app/util/favoritos_model.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting('es_MX', null).then((_) => {});

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritosModel(),
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ULSA Noticias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const WidgetPrincipal(),
    );
  }
}

class WidgetPrincipal extends StatefulWidget {
  const WidgetPrincipal({super.key});

  @override
  State<WidgetPrincipal> createState() => _WidgetPrincipalState();
}

class _WidgetPrincipalState extends State<WidgetPrincipal> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pantallas = [];
    pantallas.add(PantallaPrincipal(titulo: 'Inicio'));
    pantallas.add(PantallaBuscar());
    pantallas.add(PantallaFavoritos());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Icon(Icons.newspaper, color: Colors.white),
            SizedBox(width: 8),
            Text('ULSA', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(' Noticias'),
          ],
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: IndexedStack(index: selectedIndex, children: pantallas),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'El mundo'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
