import 'package:app/Search.dart';
import 'package:flutter/material.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  List<Book> books = allBooks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            "Search Destination : ",
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: SearchBook,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context,index){
            final book = books[index];
            return ListTile(
              leading: Image.network(book.urlImage),
              title: Text(book.title),
            );
          }))
    ],
    )
    );
  }

void SearchBook(String query){
  final suggestions = allBooks.where((book){
    final bookTitle = book.title.toLowerCase();
    final input = query.toLowerCase();
    return bookTitle.contains(input);
  }).toList();
  setState(()=> books = suggestions);
}
}