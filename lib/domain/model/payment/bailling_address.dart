class BillingData {
  final String apartment;
  final String firstName;
  final String lastName;
  final String street;
  final String building;
  final String phoneNumber;
  final String city;
  final String country;
  final String email;
  final String floor;
  final String state;

  BillingData({
    required this.apartment,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.building,
    required this.phoneNumber,
    required this.city,
    required this.country,
    required this.email,
    required this.floor,
    required this.state,
  });

  Map<String, dynamic> toJson() => {
    'apartment': apartment,
    'first_name': firstName,
    'last_name': lastName,
    'street': street,
    'building': building,
    'phone_number': phoneNumber,
    'city': city,
    'country': country,
    'email': email,
    'floor': floor,
    'state': state,
  };
}