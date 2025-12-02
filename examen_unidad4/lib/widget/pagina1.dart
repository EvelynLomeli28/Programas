import 'package:examen_unidad4/widget/paginalistavehiculos.dart';
import 'package:examen_unidad4/widget/paginaregistrovehiculo.dart';
import 'package:flutter/material.dart';

class NavegacionExamen extends StatefulWidget {
  const NavegacionExamen({super.key});
  @override
  _NavegacionExamenState createState() => _NavegacionExamenState();
}

class _NavegacionExamenState extends State<NavegacionExamen> {
  int _index = 0;

  final List<Widget> _paginas = [
    PaginaRegistroVehiculo(),
    PaginaListaVehiculos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: "Registrar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Vehículos",
          ),
        ],
      ),
    );
  }
}