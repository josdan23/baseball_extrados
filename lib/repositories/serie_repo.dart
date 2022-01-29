
import 'package:logger/logger.dart';

import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/services/mappers/serie_mapper.dart';
import 'package:baseball_cards/services/series_api.dart';

class SerieRepo  {

  final List<Serie> _serieList = [];
  final SeriesApi _dataSource;

  final Logger _logger = Logger();
  
  static SerieRepo? _INSTANCE;

  static SerieRepo getInstance(SeriesApi dataSource) {

    _INSTANCE ??= SerieRepo._internal(dataSource);
    return _INSTANCE!;

  }

  SerieRepo._internal( SeriesApi dataSource ) : this._dataSource = dataSource;

  Future<List<Serie>> getAllSeries() async {
    try {
      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = SerieMapper();

      dataJson.forEach((key, value) {

        final Serie serieMapped = mapper.fromMap( value );
        serieMapped.idSerie = key;

        if ( !_serieList.contains( serieMapped ) ) {
          _serieList.add( serieMapped );
        }

      });

      return _serieList;

    } catch ( e ){
      _logger.e( e );
      throw Exception('No se puedo recuperar la lista de series del repo');
    }
    
  }

  Future<Serie> getSerieById( String id ) async {

    for (var oneSerie in _serieList) {
      if (oneSerie.idSerie == id ){
        return oneSerie;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final serieMapped = SerieMapper().fromMap( dataJson );
      serieMapped.idSerie = id;

      _serieList.add( serieMapped );
      
      return serieMapped;

    } catch( e ) {
      _logger.e( e );
      throw Exception('No se pudo recuperar serie id: $id');
    }

  }


  Future<Serie> save( Serie newSerie ) async {

    try {
      
      final dataJson = await _dataSource.save( newSerie );

      final id = dataJson['name'];

      newSerie.idSerie = id;

      _serieList.add( newSerie );

      return newSerie;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo crear el serie en la repo');
    }
  }



  Future<bool> delete( String id ) async {
    
    try {

      await _dataSource.delete( id );

      _serieList.removeWhere((element) => element.idSerie == id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo borrar el serie de la repo');
    }
  }


  Future<Serie?> update( String id, Serie serieToUpdate ) async {

    try {

      serieToUpdate.idSerie = null;
      final dataJson = await _dataSource.update( id , serieToUpdate );
      
      final Serie serieUpdated = SerieMapper().fromMap(dataJson);
      serieUpdated.idSerie = id;

      for (var oneSerie in _serieList) {
        if (oneSerie.idSerie == id) {
          oneSerie.description = serieUpdated.description;
          oneSerie.publicationDate = serieUpdated.publicationDate;
          return oneSerie;
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar el Serie en el repo' );
    }

  }

}