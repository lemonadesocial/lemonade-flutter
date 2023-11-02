enum Currency {
  AUD,
  CAD,
  EUR,
  GBP,
  INR,
  USD,
  CRC;

  static Currency currencyFromString(String? input) =>
      Currency.values.firstWhere(
        (element) => element.name == input,
        orElse: () => Currency.USD,
      );
}
