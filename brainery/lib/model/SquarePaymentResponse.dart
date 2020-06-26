class SquarePaymentResponse {
  Payment payment;

  SquarePaymentResponse({this.payment});

  SquarePaymentResponse.fromJson(Map<String, dynamic> json) {
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    return data;
  }
}

class Payment {
  String id;
  String createdAt;
  String updatedAt;
  AmountMoney amountMoney;
  AmountMoney totalMoney;
  String status;
  String delayDuration;
  String delayAction;
  String delayedUntil;
  String sourceType;
  CardDetails cardDetails;
  String locationId;
  String orderId;
  String receiptNumber;
  String receiptUrl;

  Payment(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.amountMoney,
      this.totalMoney,
      this.status,
      this.delayDuration,
      this.delayAction,
      this.delayedUntil,
      this.sourceType,
      this.cardDetails,
      this.locationId,
      this.orderId,
      this.receiptNumber,
      this.receiptUrl});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amountMoney = json['amount_money'] != null
        ? new AmountMoney.fromJson(json['amount_money'])
        : null;
    totalMoney = json['total_money'] != null
        ? new AmountMoney.fromJson(json['total_money'])
        : null;
    status = json['status'];
    delayDuration = json['delay_duration'];
    delayAction = json['delay_action'];
    delayedUntil = json['delayed_until'];
    sourceType = json['source_type'];
    cardDetails = json['card_details'] != null
        ? new CardDetails.fromJson(json['card_details'])
        : null;
    locationId = json['location_id'];
    orderId = json['order_id'];
    receiptNumber = json['receipt_number'];
    receiptUrl = json['receipt_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.amountMoney != null) {
      data['amount_money'] = this.amountMoney.toJson();
    }
    if (this.totalMoney != null) {
      data['total_money'] = this.totalMoney.toJson();
    }
    data['status'] = this.status;
    data['delay_duration'] = this.delayDuration;
    data['delay_action'] = this.delayAction;
    data['delayed_until'] = this.delayedUntil;
    data['source_type'] = this.sourceType;
    if (this.cardDetails != null) {
      data['card_details'] = this.cardDetails.toJson();
    }
    data['location_id'] = this.locationId;
    data['order_id'] = this.orderId;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_url'] = this.receiptUrl;
    return data;
  }
}

class AmountMoney {
  int amount;
  String currency;

  AmountMoney({this.amount, this.currency});

  AmountMoney.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class CardDetails {
  String status;
  Card card;
  String entryMethod;
  String cvvStatus;
  String avsStatus;
  String statementDescription;

  CardDetails(
      {this.status,
      this.card,
      this.entryMethod,
      this.cvvStatus,
      this.avsStatus,
      this.statementDescription});

  CardDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    entryMethod = json['entry_method'];
    cvvStatus = json['cvv_status'];
    avsStatus = json['avs_status'];
    statementDescription = json['statement_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['entry_method'] = this.entryMethod;
    data['cvv_status'] = this.cvvStatus;
    data['avs_status'] = this.avsStatus;
    data['statement_description'] = this.statementDescription;
    return data;
  }
}

class Card {
  String cardBrand;
  String last4;
  int expMonth;
  int expYear;
  String fingerprint;
  String cardType;
  String bin;

  Card(
      {this.cardBrand,
      this.last4,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.cardType,
      this.bin});

  Card.fromJson(Map<String, dynamic> json) {
    cardBrand = json['card_brand'];
    last4 = json['last_4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    cardType = json['card_type'];
    bin = json['bin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_brand'] = this.cardBrand;
    data['last_4'] = this.last4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['fingerprint'] = this.fingerprint;
    data['card_type'] = this.cardType;
    data['bin'] = this.bin;
    return data;
  }
}