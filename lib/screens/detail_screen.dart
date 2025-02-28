import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        ),
        body: Padding(padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('https://image.tmdb.org/t/p/w500/${movie.backdropPath}', 
              height: 300, 
              width: double.infinity, 
              fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Overview'),
              SizedBox(
                height: 10
                ),
              Text(movie.overview),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month, 
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(width: 10),
                  const Text('Release Date: ', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10 ),
                  Text(movie.releaseDate),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
               Row(
                children: [
                  const Icon(
                     Icons.star, 
                    color: Colors.amber,
                  ),
                  const Text('Rating: ', 
                  style: 
                  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                  Text(movie.voteAverage.toString()),
                ],
              ),
            ],
          ),
        ),
        ),
    );
  }
}

