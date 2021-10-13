import 'package:ditonton/core/data/models/watch_list_table.dart';
import 'package:ditonton/core/domain/entities/genre.dart';
import 'package:ditonton/feature/feature_movie/domain/entities/movie.dart';
import 'package:ditonton/feature/feature_movie/domain/entities/movie_detail.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/episode_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/season_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvShowDetail = TvDetailEntities(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  originalLanguage: 'en',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'Status',
  tagline: 'Tagline',
  voteAverage: 1,
  voteCount: 1,
  episodeRunTime: [1],
  numberOfSeasons: 1,
  languages: ["KR"],
  nextEpisodeToAir: EpisodeEntities(
    voteCount: 1,
    airDate: '',
    stillPath: '',
    name: '',
    overview: '',
    id: 1,
    episodeNumber: 1,
    voteAverage: 1.0,
    seasonNumber: 1,
    productionCode: '',
  ),
  originCountry: ["KR"],
  seasons: [
    SeasonEntities(
      airDate: "airDate",
      episodeCount: 1,
      id: 1,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 1,
    )
  ],
  firstAirDate: '',
  inProduction: false,
  type: '',
  originalName: 'title',
  lastAirDate: '',
  numberOfEpisodes: 1,
  lastEpisodeToAir: EpisodeEntities(
    airDate: '',
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: '',
    seasonNumber: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  ),
  name: 'title',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvShow = TvEntities.watchlist(
  id: 1,
  originalName: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = WatchListTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowTable = WatchListTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvShow = TvEntities(
  backdropPath: "/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg",
  firstAirDate: "2021-09-17",
  genreIds: [
    10759,
    9648,
    18,
  ],
  originCountry: ["KR"],
  id: 93405,
  originalLanguage: "ko",
  originalName: "오징어 게임",
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvShowList = [testTvShow];
