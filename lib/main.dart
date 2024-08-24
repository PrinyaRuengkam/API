import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesla News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _news = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final String apiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2024-07-17&sortBy=publishedAt&apiKey=960d5acd91074df6babd52f7992b3231';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _news = data['articles'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching news: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tesla News'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchNews,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    } else if (_news.isEmpty) {
      return Center(child: Text('No news available'));
    } else {
      return RefreshIndicator(
        onRefresh: _fetchNews,
        child: ListView.builder(
          itemCount: _news.length,
          itemBuilder: (context, index) {
            final article = _news[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(article['title'] ?? 'No title'),
                subtitle: Text(article['description'] ?? 'No description'),
                onTap: () {
                  // TODO: Implement navigation to article detail page
                },
              ),
            );
          },
        ),
      );
    }
  }
}