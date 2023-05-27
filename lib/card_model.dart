class CardModel {
  final String cardNo;
  String cardNoInvisible = "";
  final String fullName;
  bool cardInvisible;

  CardModel({
    required this.cardNo,
    required this.fullName,
    required this.cardInvisible,
  });
}