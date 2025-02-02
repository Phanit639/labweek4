import 'package:flutter/material.dart';

class RegistraionForm extends StatefulWidget {
  const RegistraionForm({super.key});
  @override
  State<StatefulWidget> createState() => _RegistraionFormState();
}

class _RegistraionFormState extends State<RegistraionForm> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  String? _selectedItem;
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form (640710061)'),
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: RadioListTile(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    )),
                    Expanded(
                      flex: 2,
                      child: RadioListTile(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    )),
                  ],
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Providence'),
                  value: _selectedItem,
                  items: ['Bangkok', 'Chiang Mai', 'Phuket', 'Khon Kaen']
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (String? value) {
                    _selectedItem = value;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Accept Terms & Conditions'),
                  value: _isChecked, 
                  onChanged: (bool? value){
                    setState(() {
                      _isChecked = value!;
                    });
                  }
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}
