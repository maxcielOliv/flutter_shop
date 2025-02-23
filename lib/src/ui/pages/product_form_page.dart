import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();
  final imageUrlController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    imageUrlController.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlFocus.removeListener(updateImage);
    imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.png');
    return isValidUrl && endsWithFile;
  }

  void submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();
    final newProduct = Product(
        id: Random().nextDouble().toString(),
        name: formData['name'] as String,
        description: formData['description'] as String,
        price: formData['price'] as double,
        imageUrl: formData['imageUrl'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: () => submitForm(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (name) => formData['name'] = name ?? '',
                validator: (name) {
                  if (name!.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: priceFocus,
                onSaved: (price) =>
                    formData['price'] = double.parse(price as String),
                validator: (price) {
                  final priceString = price ?? '';
                  final priceConvert = double.parse(priceString);

                  if (priceConvert <= 0) {
                    return 'Informe um preço válido';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: descriptionFocus,
                validator: (description) {
                  if (description!.trim().isEmpty) {
                    return 'Descrição é obrigatório';
                  }

                  if (description.trim().length < 10) {
                    return 'Descrição precisa de no mínimo 10 caracteres';
                  }

                  return null;
                },
                maxLines: 3,
                onSaved: (description) =>
                    formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: imageUrlController,
                      decoration:
                          const InputDecoration(labelText: 'Url da imagem'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: imageUrlFocus,
                      onSaved: (imageUrl) =>
                          formData['imageUrl'] = imageUrl ?? '',
                      onFieldSubmitted: (context) => submitForm(),
                      validator: (value) {
                        final imageUrl = value ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma Url válida!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
