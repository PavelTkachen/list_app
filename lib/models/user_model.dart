import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.website,
      this.company,
      this.address});
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final String? website;
  final Company? company;
  final Address? address;

  factory User.fromJson(Map<String, dynamic> data) => User(
      id: data['id'],
      name: data['name'],
      username: data['username'],
      email: data['email'],
      phone: data['phone'],
      website: data['website'],
      company: Company.fromJson(data['company']),
      address: Address.fromJson(data['address']));

  @override
  List<Object?> get props =>
      [id, name, username, email, phone, website, company, address];
}

class Company extends Equatable {
  const Company({this.name, this.catchPhrase, this.bs});
  final String? name;
  final String? catchPhrase;
  final String? bs;
  factory Company.fromJson(Map<String, dynamic> data) => Company(
      name: data['name'], catchPhrase: data['catchPhrase'], bs: data['bs']);
  @override
  List<Object?> get props => [name, catchPhrase, bs];
}

class Address extends Equatable {
  const Address({this.street, this.suite, this.city, this.zipcode, this.geo});
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;
  factory Address.fromJson(Map<String, dynamic> data) => Address(
      street: data['street'],
      suite: data['suite'],
      city: data['city'],
      zipcode: data['zipcode'],
      geo: Geo.fromJson(data['geo']));

  @override
  List<Object?> get props => [street, suite, city, geo];
}

class Geo extends Equatable {
  const Geo({this.lat, this.lng});
  final double? lat;
  final double? lng;

  factory Geo.fromJson(Map<String, dynamic> data) =>
      Geo(lat: double.parse(data["lat"]), lng: double.parse(data["lng"]));

  @override
  List<Object?> get props => [lat, lng];
}
