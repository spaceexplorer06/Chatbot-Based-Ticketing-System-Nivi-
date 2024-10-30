import 'package:app/Chat.dart';
import 'package:app/Viewscreen/TicketingSystem.dart';
import 'package:app/favorite_manager.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Paris extends StatefulWidget {
  const Paris({super.key});

  @override
  State<Paris> createState() => _ParisState();
}

class _ParisState extends State<Paris> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Check if Paris is already in favorites
    isFavorite = FavoriteManager().favoriteItems.contains('Paris, France');
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        if (!FavoriteManager().favoriteItems.contains('Paris, France')) {
          FavoriteManager().favoriteItems.add('Paris, France');
        }
      } else {
        FavoriteManager().favoriteItems.remove('Paris, France');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Français",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: toggleFavorite,
              iconSize: 30,
            ),
          ),
        ],
        flexibleSpace: const ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(250),
            bottomRight: Radius.circular(0),
          ),
          child: Image(
            image: AssetImage('assets/Images/Paris.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(600)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Join the chat :',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (route) => const Chat()),
                    );
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Visits this month : 4.5K",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontFamily: 'belanosima',
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "TOP SIGHTS : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            CarouselSlider(
              items: [
                _buildCarouselItem('assets/Images/eiffel.jpg'),
                _buildCarouselItem('assets/Images/Louvre.jpg'),
                _buildCarouselItem('assets/Images/disney.jpeg'),
              ],
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 750),
                viewportFraction: 0.8,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (route) => const TicketingSystem()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(252, 255, 122, 50),
                ),
              ),
              child: const Text(
                "Up for a visit?",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 241, 197),
    );
  }

  // Helper method to build carousel items with an image
  Widget _buildCarouselItem(String assetPath) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(assetPath),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
