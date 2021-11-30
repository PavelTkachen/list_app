import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_list_app/bloc/user/user_bloc.dart';
import 'package:test_list_app/models/user_model.dart';

class UserEdit extends StatelessWidget {
  const UserEdit({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title:
                  Text("Edit user: ${state.user?.username ?? user?.username}"),
            ),
            body: MyCustomForm(user: state.user ?? user));
      },
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  late UserBloc _userBloc;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final TextEditingController _nameCompanyController = TextEditingController();
  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _bsController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _suiteController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Пользователь:"),
                CustomTextField(
                  label: "Name",
                  controller: _nameController..text = widget.user?.name ?? "",
                ),
                CustomTextField(
                  label: "Username",
                  controller: _usernameController
                    ..text = widget.user?.username ?? "",
                ),
                CustomTextField(
                  label: "Phone",
                  controller: _phoneController..text = widget.user?.phone ?? "",
                ),
                CustomTextField(
                  label: "Email",
                  controller: _emailController..text = widget.user?.email ?? "",
                ),
                CustomTextField(
                    label: "Website",
                    controller: _websiteController
                      ..text = widget.user?.website ?? ""),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Компания:"),
                CustomTextField(
                    label: "Name",
                    controller: _nameCompanyController
                      ..text = widget.user?.company?.name ?? ""),
                CustomTextField(
                    label: "Catch phrase",
                    controller: _phraseController
                      ..text = widget.user?.company?.catchPhrase ?? ""),
                CustomTextField(
                    label: "BS",
                    defaultValue: widget.user?.company?.bs,
                    controller: _bsController
                      ..text = widget.user?.company?.bs ?? ""),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Адрес:"),
                CustomTextField(
                    label: "Street",
                    controller: _streetController
                      ..text = widget.user?.address?.street ?? ""),
                CustomTextField(
                  label: "Suite",
                  controller: _suiteController
                    ..text = widget.user?.address?.suite ?? "",
                ),
                CustomTextField(
                  label: "City",
                  controller: _cityController
                    ..text = widget.user?.address?.city ?? "",
                ),
                CustomTextField(
                  label: "Zipcode",
                  controller: _zipcodeController
                    ..text = widget.user?.address?.zipcode ?? "",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Локация:"),
                CustomTextField(
                  label: "Lat",
                  controller: _latController
                    ..text = widget.user?.address?.geo?.lat.toString() ?? "",
                ),
                CustomTextField(
                  label: "Lng",
                  controller: _lngController
                    ..text = widget.user?.address?.geo?.lng.toString() ?? "",
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => _onSaveUser(widget.user?.id),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _onSaveUser(int? id) {
    if (_formKey.currentState!.validate()) {
      final Geo geo = Geo(
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text));
      final Address address = Address(
          suite: _suiteController.text,
          street: _streetController.text,
          city: _cityController.text,
          zipcode: _zipcodeController.text,
          geo: geo);
      final Company company = Company(
          name: _nameCompanyController.text,
          bs: _bsController.text,
          catchPhrase: _phoneController.text);
      final User currentUser = User(
          id: id,
          name: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          website: _websiteController.text,
          address: address,
          company: company);
      _userBloc.add(DataLoading(user: currentUser));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _nameCompanyController.dispose();
    _phraseController.dispose();
    _bsController.dispose();
    _streetController.dispose();
    _suiteController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      this.defaultValue,
      required this.controller})
      : super(key: key);
  final String label;
  final String? defaultValue;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
