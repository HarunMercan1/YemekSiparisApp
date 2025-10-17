import 'package:equatable/equatable.dart';

abstract class YemekEvent extends Equatable {
  const YemekEvent();

  @override
  List<Object?> get props => [];
}

// 1) Tum yemekleri getir
class TumYemekleriGetirEvent extends YemekEvent {}

// 2) Sepete yemek ekle
class SepeteYemekEkleEvent extends YemekEvent {
  final String yemekAdi;
  final String yemekResimAdi;
  final int yemekFiyat;
  final int yemekSiparisAdet;
  final String kullaniciAdi;

  const SepeteYemekEkleEvent({
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
    required this.yemekSiparisAdet,
    required this.kullaniciAdi,
  });

  @override
  List<Object?> get props =>
      [yemekAdi, yemekResimAdi, yemekFiyat, yemekSiparisAdet, kullaniciAdi];
}

// 3) Sepeti getir
class SepetiGetirEvent extends YemekEvent {
  final String kullaniciAdi;

  const SepetiGetirEvent(this.kullaniciAdi);

  @override
  List<Object?> get props => [kullaniciAdi];
}

// 4) Sepetten yemek sil
class SepettenYemekSilEvent extends YemekEvent {
  final int sepetYemekId;
  final String kullaniciAdi;

  const SepettenYemekSilEvent(this.sepetYemekId, this.kullaniciAdi);

  @override
  List<Object?> get props => [sepetYemekId, kullaniciAdi];
}
