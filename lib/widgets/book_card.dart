import 'package:flutter/material.dart';
import '../app/data/models/book_model.dart';
import '../app/data/controllers/cart_controller.dart';

class BookCard extends StatefulWidget {
  BookCard({super.key, required this.book});

  final Book book;


  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    widget.book.imageUrl[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.book.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            // Text(
            //   '\$${widget.book.price}',
            //   style: const TextStyle(
            //     fontSize: 20,
            //     color: Colors.teal,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            const SizedBox(height: 8),
            Text(
              widget.book.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            //dateSell is later than now
            if (widget.book.dateSell != null &&
                widget.book.dateSell!.isAfter(DateTime.now()))
              Text(
                'Available until: ${widget.book.dateSell!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
