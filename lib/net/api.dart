// import 'dart:io';
//
//
// import 'package:chopper/chopper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/io_client.dart' as http;
//
// import '../global.dart';
// import 'json_to_type_converter.dart';
//
// part 'api.chopper.dart';
//
// /// WARNING!
// /// Any change to this file should be followed by a
// /// 'flutter pub tun build_runner build' command to generate the corresponding
// /// part class
//
// /// A simple converter that ignores the body of the response
// /// To be used to override the default json converter when necessary
// /// For example when you don't care about the response
// Response voidResponse<String>(Response res) => res;
//
// /// A simple converter that simply uses the body string of the response
// /// To be used to override the default json converter when necessary
// Response<String> stringResponse<String>(Response res) =>
//     Response<String>(res.base, res.body);
//
// /// The definition of the main server api of the app
// @ChopperApi(
//   baseUrl: '',
// )
// // ignore_for_file: argument_type_not_assignable
// abstract class ApiService extends ChopperService {
//   /// Creates a new instance
//   static ApiService create({ @required String baseUrl }) {
//
//     final headers = <String, String>{};
//
//     final client = ChopperClient(
//       client: http.IOClient(
//           HttpClient()..connectionTimeout = const Duration(seconds: 10)),
//       baseUrl: baseUrl,
//       services: [
//         _$ApiService(),
//       ],
//       converter: JsonToTypeConverter({
//         Item: (json) => Item.fromJson(json),
//         Logistic: (json) => Logistic.fromJson(json),
//         Stock: (json) => Stock.fromJson(json),
// //        Attachment: (json) => Attachment.fromJson(json),
// //        Channel: (json) => Channel.fromJson(json),
//         Country: (json) => Country.fromJson(json),
// //        NewsPost: (json) => NewsPost.fromJson(json),
//         RangeCategory: (json) => RangeCategory.fromJson(json),
//         Search: (json) => Search.fromJson(json),
//         SearchFilter: (json) => SearchFilter.fromJson(json),
//         SearchResult: (json) => SearchResult.fromJson(json),
//         Shop: (json) => Shop.fromJson(json),
//         User: (json) => User.fromJson(json),
//         Package: (json) => Package.fromJson(json),
//         Deviation: (json) => Deviation.fromJson(json),
//         Composition: (json) => Composition.fromJson(json),
//         Collection: (json) => Collection.fromJson(json),
//         Price: (json) => Price.fromJson(json),
//       }),
//       interceptors: [
//         HeadersInterceptor(headers),
//         TokenInterceptor(),
//         kReleaseMode ? null : HttpLoggingInterceptor(),
//         CurlInterceptor(),
//       ],
//     );
//     return _$ApiService(client);
//   }
//
//   void _initApi() {
//     Global().initializeApi();
//   }
//
//   /// Item search
//   @FactoryConverter(response: stringResponse)
//   @Get(path: '/shops/{shop_id}/articles/{article_id}')
//   Future<Response> getItem(
//       @Path('shop_id') int shopId, @Path('article_id') String itemId);
//
//   /// Products search
//   @FactoryConverter(response: stringResponse)
//   @Post(path: '/shops/{shop_id}/items/search')
//   Future<Response<String>> search(
//       @Path('shop_id') int shopId, @Body() Search search);
//
//   /// Search Sorting
//   @Get(path: '/sortables')
//   Future<Response<List<SearchSorting>>> getSortables(
//       @Query("lang") String lang);
//
//   /// Channel
//   @FactoryConverter(response: stringResponse)
//   @Get(path: '/shops/{shop_id}/channels')
//   Future<Response<String>> getChannels(@Path('shop_id') int shopId);
//
//   // Channel posts
//   @FactoryConverter(response: stringResponse)
//   @Get(path: '/shops/{shop_id}/posts?channelIds={channel_ids}&page=1&limit=10')
//   Future<Response<String>> getPosts(
//       @Path('shop_id') int shopId, @Path('channel_ids') String channelIds);
//
//   @FactoryConverter(response: stringResponse)
//   @Get(path: "/shops/{shop_id}/items/{itemId}/logistic")
//   Future<Response<String>> getItemLogistic(
//       @Path("shop_id") int shopId,
//       @Path("itemId") String itemId,
//       @Query("lang") String lang,
//       @Query("store_code") String storeCode);
//
//   @Get(path: "/shops/{shop_id}/items/{itemId}/logistic")
//   Future<Response<Item>> getItemAll(
//       @Path("shop_id") int shopId,
//       @Path("itemId") String itemId,
//       @Query("lang") String lang,
//       );
//
//   @Get(path: "/shops/{shop_id}/catalogqr")
//   Future<Response<Collection>> getCollectionURL(
//       @Path("shop_id") int shopId,
//       @Query("url") String url,
//       @Query("lang") String lang,
//       );
//
//   @Get(path: "/shops")
//   Future<Response<List<Shop>>> getShops();
//
//
// }
