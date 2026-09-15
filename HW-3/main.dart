class MediaItem {
  String title;
  double price;

  MediaItem(this.title, this.price);
}

mixin Downloadable {
  void download() {
    print('Downloading...');
  }
}

class Movie extends MediaItem with Downloadable {
  Movie(String title, double price)
      : super(title, price);
}

class ShoppingCart {
  List<MediaItem> items;

  ShoppingCart(this.items);

  void addItem(MediaItem item) {
    items.add(item);
  }

  double getTotal() {
    return items.fold(
      0.0,
      (sum, item) => sum + item.price,
    );
  }

  List<MediaItem> getExpensiveItems() {
    return items
        .where((item) => item.price > 2000)
        .toList();
  }
}


void main() {
  Movie movie1 = Movie(
    'Avatar',
    3000.0,
  );

  Movie movie2 = Movie(
    'The Avengers',
    2500.0,
  );

  Movie movie3 = Movie(
    'Interstellar',
    1500.0,
  );

  Movie movie4 = Movie(
    'Harry Potter',
    1500.0,
  );

  ShoppingCart cart = ShoppingCart([]);

  cart.addItem(movie1);
  cart.addItem(movie2);
  cart.addItem(movie3);
  cart.addItem(movie4);

  print('Shopping cart:');

  for (MediaItem item in cart.items) {
    print('${item.title} - ${item.price}');
  }

  print('');
  print('Total: ${cart.getTotal()}');

  print('');
  print('Expensive items:');

  List<MediaItem> expensiveItems = cart.getExpensiveItems();

  for (MediaItem item in expensiveItems) {
    print(item.title);
  }

  print('');
  movie1.download();
}
