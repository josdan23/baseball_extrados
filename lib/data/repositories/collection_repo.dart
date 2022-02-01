import 'package:logger/logger.dart';

import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/services/collection_api.dart';
import 'package:baseball_cards/services/mappers/collection_card_mapper.dart';

class CollectionRepo {

  static CollectionRepo? _INSTANCE;

  final List<CollectionCard> _collectionList = [];
  final CollectionApi _dataSource;

  final Logger _logger = Logger();



  static CollectionRepo getInstance( CollectionApi dataSource) {
    _INSTANCE ??= CollectionRepo._internal(dataSource);

    return _INSTANCE!;
  }


  CollectionRepo._internal( CollectionApi dataSource ) : this._dataSource = dataSource;


  Future<List<CollectionCard>> getAllCollecions() async {
      try {
        final Map<String, dynamic> dataJson = await _dataSource.getAll();

        final mapper = CollectionCardMapper();

        dataJson.forEach((key, value) {

          final CollectionCard collectionMapped = mapper.fromMap( value );
          collectionMapped.idCollection= key;

          if ( !_collectionList.contains( collectionMapped ) ) {
            _collectionList.add( collectionMapped );
          }

        });

        return _collectionList;

      } catch ( e ){
        _logger.e( e );
        throw Exception('No se puedo recuperar la lista de colecciones del repositorio');
      }
      
    }


    Future<CollectionCard> getCollectionById( String id ) async {

      for (var oneCollection in _collectionList) {
        if (oneCollection.idCollection == id ){
          return oneCollection;
        }
      }

      try {

        final dataJson = await _dataSource.getById( id );

        final collectionMapped = CollectionCardMapper().fromMap( dataJson );
        collectionMapped.idCollection = id;

        _collectionList.add( collectionMapped );
        
        return collectionMapped;

      } catch( e ) {
        _logger.e( e );
        throw Exception('No se pudo recuperar Colección id: $id');
      }
    }


    Future<CollectionCard> saveNewCollection( CollectionCard newCollection ) async {

      try {
        
        final dataJson = await _dataSource.save( newCollection );

        final id = dataJson['name'];

        newCollection.idCollection = id;

        _collectionList.add( newCollection );

        return newCollection;
      
      } catch (e) {
        _logger.e( e );
        throw Exception('No se pudo crear el Colección en la api');
      }
    }

    Future<bool> deleteCollection( String id ) async {
      
      try {

        await _dataSource.delete( id );

        _collectionList.removeWhere((element) => element.idCollection == id);

        return true;

      } catch (e) {
        _logger.e( e );
        throw Exception('No se pudo borrar el colección de la api');
      }
    }


    Future<CollectionCard?> updateCollection( String id, CollectionCard collectionToUpdatd ) async {

      try {

        collectionToUpdatd.idCollection = null;
        final dataJson = await _dataSource.update( id , collectionToUpdatd );
        
        final CollectionCard collectionUpdated = CollectionCardMapper().fromMap(dataJson);
        collectionUpdated.idCollection = id;

        for (var oneCollection in _collectionList) {
          if (oneCollection.idCollection == id) {
            oneCollection.description = collectionUpdated.description;
            return oneCollection;
          }
        }
      
      } catch (e) {
        _logger.e( e );
        throw Exception( 'No se pudo actualizar el Colección en api' );
      }

    }

}