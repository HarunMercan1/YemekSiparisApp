import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';
import '../../logic/yemek_bloc/yemek_state.dart';
import '../../data/repositories/yemek_repository.dart';
import '../../core/constants/api_urls.dart';
import '../../data/models/yemek_model.dart';

class SepetSayfasi extends StatelessWidget {
  final String kullaniciAdi;

  const SepetSayfasi({super.key, required this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YemekBloc(YemekRepository())..add(SepetiGetirEvent(kullaniciAdi)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sepetim 🛍️"),
          backgroundColor: Colors.deepOrange,
        ),
        body: BlocBuilder<YemekBloc, YemekState>(
          builder: (context, state) {
            if (state is YemekYukleniyor) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SepetYuklendi) {
              final sepetListesi = state.sepetListesi;

              if (sepetListesi.isEmpty) {
                return const Center(child: Text("Sepetiniz boş 😢"));
              }

              return ListView.builder(
                itemCount: sepetListesi.length,
                itemBuilder: (context, index) {
                  final yemek = sepetListesi[index];
                  return _buildSepetCard(context, yemek);
                },
              );
            } else if (state is YemekHata) {
              return Center(child: Text("Hata: ${state.mesaj}"));
            } else {
              return const Center(child: Text("Sepet yüklenemedi."));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSepetCard(BuildContext context, Yemek yemek) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: Image.network(
          "${ApiUrls.resimBaseUrl}${yemek.yemekResimAdi}",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
        title: Text(yemek.yemekAdi),
        subtitle: Text("${yemek.yemekFiyat} ₺  x${yemek.yemekSiparisAdet ?? 1}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<YemekBloc>().add(
              SepettenYemekSilEvent(
                int.parse(yemek.yemekId),
                kullaniciAdi,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${yemek.yemekAdi} sepetten silindi ❌")),
            );
          },
        ),
      ),
    );
  }
}
