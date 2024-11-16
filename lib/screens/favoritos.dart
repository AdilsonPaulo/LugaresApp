import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/model/lugares_favoritos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lugaresFavoritos = Provider.of<LugaresFavoritos>(context);

    if (lugaresFavoritos.favoritos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum Lugar Marcado como Favorito!',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Consumer<LugaresFavoritos>(
          builder: (context, lugaresFavotiros, child) {
        return ListView.builder(
            itemCount: lugaresFavoritos.favoritos.length,
            itemBuilder: (ctx, index) {
              return ItemLugar(
                lugar: lugaresFavoritos.favoritos.elementAt(index),
              );
            });
      });
    }
  }
}
