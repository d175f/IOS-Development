import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final int id;
  final String title;
  final String category;
  final double rating;
  final double price;
  final IconData icon;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.icon,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalog',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4169E1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F6FA),
          foregroundColor: Color(0xFF202B46),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _isGridView = false;
  int _nextId = 11;

  final List<Product> _initialProducts = [
    const Product(
      id: 1,
      title: 'Headphones',
      category: 'Electronics',
      rating: 4.8,
      price: 99.99,
      icon: Icons.headphones,
    ),
    const Product(
      id: 2,
      title: 'Smart Watch',
      category: 'Electronics',
      rating: 4.6,
      price: 149.99,
      icon: Icons.watch,
    ),
    const Product(
      id: 3,
      title: 'Laptop',
      category: 'Computers',
      rating: 4.9,
      price: 899.99,
      icon: Icons.laptop,
    ),
    const Product(
      id: 4,
      title: 'Camera',
      category: 'Photography',
      rating: 4.7,
      price: 499.99,
      icon: Icons.camera_alt,
    ),
    const Product(
      id: 5,
      title: 'Sneakers',
      category: 'Fashion',
      rating: 4.5,
      price: 79.99,
      icon: Icons.shopping_bag,
    ),
    const Product(
      id: 6,
      title: 'Keyboard',
      category: 'Accessories',
      rating: 4.4,
      price: 59.99,
      icon: Icons.keyboard,
    ),
    const Product(
      id: 7,
      title: 'Monitor',
      category: 'Computers',
      rating: 4.8,
      price: 299.99,
      icon: Icons.desktop_windows,
    ),
    const Product(
      id: 8,
      title: 'Speaker',
      category: 'Audio',
      rating: 4.3,
      price: 49.99,
      icon: Icons.speaker,
    ),
    const Product(
      id: 9,
      title: 'Tablet',
      category: 'Electronics',
      rating: 4.6,
      price: 399.99,
      icon: Icons.tablet,
    ),
    const Product(
      id: 10,
      title: 'Game Controller',
      category: 'Gaming',
      rating: 4.7,
      price: 69.99,
      icon: Icons.gamepad,
    ),
  ];

  late List<Product> _products;

  @override
  void initState() {
    super.initState();
    _products = List.from(_initialProducts);
  }

  Future<void> _refreshProducts() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    if (!mounted) return;

    setState(() {
      _products.insert(
        0,
        Product(
          id: _nextId++,
          title: 'New Product',
          category: 'New Arrivals',
          rating: 4.5,
          price: 29.99,
          icon: Icons.new_releases,
        ),
      );
    });
  }

  void _deleteProduct(Product product, int index) {
    setState(() {
      _products.removeAt(index);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              final restoreIndex = index < _products.length
                  ? index
                  : _products.length;

              _products.insert(restoreIndex, product);
            });
          },
        ),
      ),
    );
  }

  void _resetCatalog() {
    setState(() {
      _products = List.from(_initialProducts);
      _nextId = 11;
    });
  }

  Widget _buildProductContent(
    Product product, {
    required bool isGrid,
  }) {
    if (isGrid) {
      return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF3FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    product.icon,
                    size: 58,
                    color: const Color(0xFF4169E1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202B46),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFB547),
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text('${product.rating}'),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8ECF4),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        leading: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF3FF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            product.icon,
            color: const Color(0xFF4169E1),
            size: 28,
          ),
        ),
        title: Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF202B46),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.category),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFB547),
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Text('${product.rating}'),
                ],
              ),
            ],
          ),
        ),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4169E1),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleProduct(
    Product product,
    int index, {
    required bool isGrid,
  }) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: isGrid
            ? const EdgeInsets.all(6)
            : const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        _deleteProduct(product, index);
      },
      child: _buildProductContent(
        product,
        isGrid: isGrid,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Color(0xFF4169E1),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Catalog is Empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202B46),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Restore the products to continue shopping.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _resetCatalog,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Catalog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4169E1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catalog',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
              icon: Icon(
                _isGridView
                    ? Icons.view_list_rounded
                    : Icons.grid_view_rounded,
                color: const Color(0xFF4169E1),
              ),
              tooltip: _isGridView
                  ? 'List View'
                  : 'Grid View',
            ),
          ),
        ],
      ),
      body: _products.isEmpty
          ? _buildEmptyState()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    12,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Explore Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202B46),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5ECFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_products.length} items',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4169E1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshProducts,
                    child: _isGridView
                        ? GridView.builder(
                            physics:
                                const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.72,
                            ),
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];

                              return _buildDismissibleProduct(
                                product,
                                index,
                                isGrid: true,
                              );
                            },
                          )
                        : ListView.separated(
                            physics:
                                const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 16,
                            ),
                            itemCount: _products.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 2);
                            },
                            itemBuilder: (context, index) {
                              final product = _products[index];

                              return _buildDismissibleProduct(
                                product,
                                index,
                                isGrid: false,
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
