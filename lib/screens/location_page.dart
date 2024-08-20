import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  final TextEditingController _locationController = TextEditingController();
  List<String> _countries = [];

  Future<void> _searchCountries(String text) async {
    final url = Uri.parse('https://restcountries.com/v3.1/name/$text');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _countries =
            data.map<String>((country) => country['name']['common']).toList();
      });
    } else {
      setState(() {
        _countries = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Choose A Location'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Choose Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () => _searchCountries(_locationController.text),
                child: const Text('Search')),
            Expanded(
                child: ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_countries[index]),
                        onTap: () {
                          _locationController.text = _countries[index];
                          Navigator.of(context).pushNamed('/home', arguments: {
                            "location": _locationController.text
                          });
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
