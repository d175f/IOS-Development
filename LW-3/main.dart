class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book(
    this.title,
    this.author,
    this.price,
    this.isBorrowed,
  );
}


class Library {
  List<Book> books;

  Library(this.books);

  List<Book> getAvailableBooks() {
    return books
        .where((book) => book.isBorrowed == false)
        .toList();
  }

  double getTotalValue() {
    return books.fold(
      0.0,
      (sum, book) => sum + book.price,
    );
  }
}


void main() {
  Book book1 = Book(
    'Harry Potter',
    'J.K. Rowling',
    5000.0,
    false,
  );

  Book book2 = Book(
    'War and Peace',
    'Leo Tolstoy',
    7000.0,
    true,
  );

  Book book3 = Book(
    'The Hobbit',
    'J.R.R. Tolkien',
    4500.0,
    false,
  );

  Library library = Library([
    book1,
    book2,
    book3,
  ]);

  print('Available books:');

  List<Book> availableBooks = library.getAvailableBooks();

  for (Book book in availableBooks) {
    print(book.title);
  }

  print('Total value: ${library.getTotalValue()}');
}
