import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_event_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvSeriesWatchlistBloc>().add(FetchTvSeriesWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvSeriesWatchlistBloc>().add(FetchTvSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
          builder: (context, state) {
            if (state is TvSeriesWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesWatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.watchlist[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.watchlist.length,
              );
            } else if (state is TvSeriesWatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Watchlist is empty'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
