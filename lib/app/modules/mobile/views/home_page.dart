import 'package:flutter/material.dart';

import '../../../../widgets/product_card.dart';
import '../../../data/models/book_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Book> data = [
    Book(
      id: '1',
      name: 'Sono Koi, Damasarete Imasenka?',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 150.0,
      description: 'A love story that began as a scam! A roller coaster romance!',
      size: 'bunko',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-05-30'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '2',
      name: 'Sono Koi, Damasarete Imasenka?',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 180.0,
      description: 'A love story that began as a scam! A roller coaster romance!',
      size: 'bunko',
      inStock: 200,
      maxBuy: 10,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '3',
      name: 'We Are Not Dating!!',
      imageUrl: [
        'data/kami/imageUrl.jpg',
      ],
      price: 120.0,
      description: '''"Why do you keep asking if we\'re dating? We\'re just holding hands, we\'re not dating!!"
It\'s a slice-of-life romantic comedy about couples who aren\'t really couples!''',
      size: 'bunko',
      inStock: 1,
      maxBuy: 10,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/kami',
      dataNum: 2,
    ),
    Book(
      id: '4',
      name: 'Nihonkoku Shoukan',
      imageUrl: [
        'data/SummonJapan/imageUrl.jpg',
        'data/SummonJapan/imageUrl2.jpg',
      ],
      price: 175.0,
      description: 'In the Great Orient, lies a continent called Rodenius. One day,...',
      size: 'bunko',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/SummonJapan',
      dataNum: 20,
    ),
    Book(
      id: '5',
      name: 'Asics Gel-Kayano 27',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 160.0,
      description: 'Supportive running shoes for long-distance runners.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '6',
      name: 'Reebok Classic Leather',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 85.0,
      description: 'Timeless sneakers with a clean and simple design.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '7',
      name: 'Vans Old Skool',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 70.0,
      description: 'Iconic skate shoes with a classic look.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '8',
      name: 'Converse Chuck Taylor All Star',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 60.0,
      description: 'Classic canvas sneakers with a timeless design.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '9',
      name: 'Under Armour HOVR Phantom 2',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 140.0,
      description: 'High-tech running shoes with great energy return.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
    Book(
      id: '10',
      name: 'Hoka One One Bondi 7',
      imageUrl: [
        'data/sonokoi/imageUrl.jpg',
        'data/sonokoi/imageUrl2.jpg',
        'data/sonokoi/imageUrl3.jpg',
      ],
      price: 160.0,
      description: 'Maximum cushioning for a comfortable ride.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
      data: 'data/sonokoi',
      dataNum: 29,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ProductCart(book: data[index]);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //navigate to cart page
      //   },
      //   tooltip: 'Add to Cart',
      //   child: const Icon(Icons.add_shopping_cart),
      // ),
    );
  }
}
