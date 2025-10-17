import 'package:flutter_bloc/flutter_bloc.dart';
import 'yemek_event.dart';
import 'yemek_state.dart';
import '../../data/repositories/yemek_repository.dart';

class YemekBloc extends Bloc<YemekEvent, YemekState> {
  final YemekRepository _repo;

  YemekBloc(this._repo) : super(YemekInitial()) {
    // 🔹 Tum yemekleri getir
    on<TumYemekleriGetirEvent>((event, emit) async {
      emit(YemekYukleniyor());
      try {
        final yemekler = await _repo.tumYemekleriGetir();
        emit(YemekYuklendi(yemekler));
      } catch (e) {
        emit(YemekHata(e.toString()));
      }
    });

    // 🔹 Sepete yemek ekle
    on<SepeteYemekEkleEvent>((event, emit) async {
      try {
        await _repo.sepeteYemekEkle(
          yemekAdi: event.yemekAdi,
          yemekResimAdi: event.yemekResimAdi,
          yemekFiyat: event.yemekFiyat,
          yemekSiparisAdet: event.yemekSiparisAdet,
          kullaniciAdi: event.kullaniciAdi,
        );
      } catch (e) {
        emit(YemekHata(e.toString()));
      }
    });

    // 🔹 Sepeti getir
    on<SepetiGetirEvent>((event, emit) async {
      emit(YemekYukleniyor());
      try {
        final sepet = await _repo.sepettekiYemekleriGetir(event.kullaniciAdi);
        emit(SepetYuklendi(sepet));
      } catch (e) {
        emit(YemekHata(e.toString()));
      }
    });

    // 🔹 Sepetten yemek sil
    on<SepettenYemekSilEvent>((event, emit) async {
      try {
        await _repo.sepettenYemekSil(
          sepetYemekId: event.sepetYemekId,
          kullaniciAdi: event.kullaniciAdi,
        );
      } catch (e) {
        emit(YemekHata(e.toString()));
      }
    });
  }
}
