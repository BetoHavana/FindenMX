import 'dart:convert';

class CardsModel {
    CardsModel({
        required this.cards,
    });

    List<Card> cards;

    factory CardsModel.fromJson(String str) => CardsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CardsModel.fromMap(Map<String, dynamic> json) => CardsModel(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toMap())),
    };
}

class Card {
    Card({
      required this.id,
      required this.cardNumber,
      required this.holderName,
      required this.expirationYear,
      required this.expirationMonth,
      required this.allowsCharges,
      required  this.allowsPayouts,
      required this.creationDate,
      required  this.bankName,
      required  this.bankCode,
      required  this.type,
      required  this.brand,
    });

    String id;
    String cardNumber;
    String holderName;
    String expirationYear;
    String expirationMonth;
    bool allowsCharges;
    bool allowsPayouts;
    DateTime creationDate;
    String bankName;
    String bankCode;
    String type;
    String brand;

    factory Card.fromJson(String str) => Card.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Card.fromMap(Map<String, dynamic> json) => Card(
        id: json["id"],
        cardNumber: json["card_number"],
        holderName: json["holder_name"],
        expirationYear: json["expiration_year"],
        expirationMonth: json["expiration_month"],
        allowsCharges: json["allows_charges"],
        allowsPayouts: json["allows_payouts"],
        creationDate: DateTime.parse(json["creation_date"]),
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        type: json["type"],
        brand: json["brand"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "card_number": cardNumber,
        "holder_name": holderName,
        "expiration_year": expirationYear,
        "expiration_month": expirationMonth,
        "allows_charges": allowsCharges,
        "allows_payouts": allowsPayouts,
        "creation_date": creationDate.toIso8601String(),
        "bank_name": bankName,
        "bank_code": bankCode,
        "type": type,
        "brand": brand,
    };
}


class ErrorAddCardModel {
    ErrorAddCardModel({
        this.code,
        this.message,
    });

    int ? code;
    String ? message;

    factory ErrorAddCardModel.fromJson(String str) => ErrorAddCardModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ErrorAddCardModel.fromMap(Map<String, dynamic> json) => ErrorAddCardModel(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
    };
}
