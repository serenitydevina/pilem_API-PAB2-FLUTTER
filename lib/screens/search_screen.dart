import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices _apiServices = ApiServices();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovie);
  }
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }
  void _searchMovie() async{
    if(_searchController.text.isEmpty){
      setState(() {
        _searchResult.clear();
      });
      return;
    }
    final List<Map<String, dynamic>> searchData = 
    await _apiServices.searchMovie(_searchController.text);
    setState(() {
      _searchResult = searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Search'),),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
                ),
              borderRadius: BorderRadius.circular(5.0),
            ) ,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search movies...', 
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Visibility(
                  visible: _searchController.text.isNotEmpty,
                  child: IconButton(onPressed: (){
                    _searchController.clear();
                    setState(() {
                      _searchResult.clear();
                    });
                  }, 
                    icon:const Icon(Icons.clear)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index){
                final Movie movie = _searchResult[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Image.network(movie.posterPath !=  '' ?
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}' :'https://placehold.co/50x75?text=No+Image',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      ),
                    title: Text(movie.title),
                    // subtitle: Text(movie.overview),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movie: movie))),
                  ),
                );
              },
              ),
          ),
        ],
      ),
      ),
    );
  }
}