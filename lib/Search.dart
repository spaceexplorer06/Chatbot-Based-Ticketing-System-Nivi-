class Book {
  final String title;
  final String urlImage;

  const Book({
    required this.title,
    required this.urlImage,
  });
}

const allBooks = [
  Book(
      title: 'ABC Murderers',
      urlImage: "https://m.media-amazon.com/images/I/41MbRSB8YVL.jpg"),
  Book(
      title: 'Death on the Nile',
      urlImage:
          "https://s3.amazonaws.com/static.rogerebert.com/uploads/movie/movie_poster/death-on-the-nile-2022/large_death-on-the-nile-poster.jpeg"),
];
