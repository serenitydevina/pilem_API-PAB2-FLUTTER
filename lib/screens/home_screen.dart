import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  List<Movie>_allMovie =[];
  List<Movie>_popularMovie =[];
  List<Movie>_trendingMovie =[];
  
  Future<void> _loadMovie() async {
    final List<Map<String, dynamic>> allMovieData = 
    await _apiServices.getAllMovies();
    final List<Map<String, dynamic>> popularMovieData = 
    await _apiServices.getPopularMovies();
    final List<Map<String, dynamic>> trendingMovieData = 
    await _apiServices.getTredingMovies();

    setState(() {
      _allMovie = allMovieData.map((e) => Movie.fromJson(e)).toList();
      _popularMovie = popularMovieData.map((e) => Movie.fromJson(e)).toList();
      _trendingMovie = trendingMovieData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pilem'),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
         _buildMovieList("All Movie", _allMovie),
         _buildMovieList("Trending Movie", _trendingMovie),
         _buildMovieList("Popular Movie", _popularMovie),
      ]
      ),
    )
    );
  }
  Widget _buildMovieList(String title, List<Movie> movies) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text(title),),
          SizedBox(
            height: 200,
            child:  ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length, 
              itemBuilder: (BuildContext context, int index){
                final movie = movies[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      movie: movie,
                    )
                  )
                  ),
                  child: Padding(padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network('https://image.tmdb.org/t/p/w500/${movie.posterPath}', height: 150, width: 100, fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                      Text(
                        movie.title.length >14 
                        ? '${movie.title.substring(0,10)}...' 
                        : movie.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold),
                        ),
                        // Text(movie.title, overflow: TextOverflow.ellipsis, maxLines: 1,)
                    ],
                  ),
                  ),
                );
              }
              ) ,
          ),
      ]);
  }
}