import 'package:flutter/material.dart';
import 'package:news_app/pantallas/principal.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('es_MX', null).then((_) => {});

  runApp(const NewsApp());
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
    Widget pantalla;

    switch (selectedIndex) {
      case 0:
        pantalla = PantallaPrincipal(titulo: 'Inicio');
        break;
      case 1:
        pantalla = PantallaPrincipal(titulo: 'Buscar');
        break;
      case 2:
        pantalla = PantallaPrincipal(titulo: 'Favoritos');
        break;
      case 3:
        pantalla = PantallaPrincipal(titulo: 'DETALLE');
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

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
      body: pantalla,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
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
