import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repoyukle/presentation/screens/sepet_sayfasi.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';
import '../../logic/yemek_bloc/yemek_state.dart';
import '../../data/repositories/yemek_repository.dart';
import '../widgets/yemek_card.dart';

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YemekBloc(YemekRepository())..add(TumYemekleriGetirEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Yemek Sipariş Uygulaması 🍔"),
          backgroundColor: Colors.deepOrange,
        ),


        body: BlocBuilder<YemekBloc, YemekState>(
          builder: (context, state) {
            if (state is YemekYukleniyor) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is YemekYuklendi) {
              final yemekler = state.yemekListesi;
              return ListView.builder(
                itemCount: yemekler.length,
                itemBuilder: (context, index) {
                  final yemek = yemekler[index];
                  return YemekCard(yemek: yemek);
                },
              );
            } else if (state is YemekHata) {
              return Center(child: Text("Hata: ${state.mesaj}"));
            } else {
              return const Center(child: Text("Hoşgeldin!"));
            }
          },
        ),
      ),
    );
  }
}
