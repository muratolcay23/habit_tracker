class DailyQuote {
  static final List<String> quotes = [
    "Küçük adýmlar, büyük deðiþimlerin baþlangýcýdýr.",
    "Bugün yapacaðýn tek bir þey, yarýnki seni güçlendirir.",
    "Mükemmel olmak zorunda deðilsin, sadece dünden daha iyi ol.",
    "Disiplin, motivasyonun bittiði yerde baþlar.",
    "Her gün 1% geliþim, bir yýlda 37 kat daha iyi olmak demektir.",
    "Beynini eðitmenin en iyi yolu, ona küçük zaferler yaþatmaktýr.",
    "Bugünkü bahanen, yarýnki piþmanlýðýn olmasýn.",
    "Su içmek, beynin en hýzlý çalýþmasýný saðlayan en basit yöntemdir.",
    "Uyku, hafýzayý pekiþtiren görünmez bir süper güçtür.",
    "Hayat, nefes aldýðýn sürece sana yeni bir þans verir."
  ];
  
  static String getTodayQuote() {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return quotes[dayOfYear % quotes.length];
  }
}
