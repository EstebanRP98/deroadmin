import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VentureRecord extends FirestoreRecord {
  VentureRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "productTitle" field.
  String? _productTitle;
  String get productTitle => _productTitle ?? '';
  bool hasProductTitle() => _productTitle != null;

  // "productDescription" field.
  String? _productDescription;
  String get productDescription => _productDescription ?? '';
  bool hasProductDescription() => _productDescription != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "imagesList" field.
  List<String>? _imagesList;
  List<String> get imagesList => _imagesList ?? const [];
  bool hasImagesList() => _imagesList != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "favoritos" field.
  List<DocumentReference>? _favoritos;
  List<DocumentReference> get favoritos => _favoritos ?? const [];
  bool hasFavoritos() => _favoritos != null;

  // "seller" field.
  DocumentReference? _seller;
  DocumentReference? get seller => _seller;
  bool hasSeller() => _seller != null;

  // "inSell" field.
  bool? _inSell;
  bool get inSell => _inSell ?? false;
  bool hasInSell() => _inSell != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  bool hasColor() => _color != null;

  // "statusProduct" field.
  String? _statusProduct;
  String get statusProduct => _statusProduct ?? '';
  bool hasStatusProduct() => _statusProduct != null;

  // "marca" field.
  String? _marca;
  String get marca => _marca ?? '';
  bool hasMarca() => _marca != null;

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  bool hasUuid() => _uuid != null;

  // "priceOld" field.
  double? _priceOld;
  double get priceOld => _priceOld ?? 0.0;
  bool hasPriceOld() => _priceOld != null;

  // "percentageDiscount" field.
  double? _percentageDiscount;
  double get percentageDiscount => _percentageDiscount ?? 0.0;
  bool hasPercentageDiscount() => _percentageDiscount != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "instagramLink" field.
  String? _instagramLink;
  String get instagramLink => _instagramLink ?? '';
  bool hasInstagramLink() => _instagramLink != null;

  // "whatsappLink" field.
  String? _whatsappLink;
  String get whatsappLink => _whatsappLink ?? '';
  bool hasWhatsappLink() => _whatsappLink != null;

  // "isLimited" field.
  bool? _isLimited;
  bool get isLimited => _isLimited ?? false;
  bool hasIsLimited() => _isLimited != null;

  // "category" field.
  List<DocumentReference>? _category;
  List<DocumentReference> get category => _category ?? const [];
  bool hasCategory() => _category != null;

  // "region" field.
  List<DocumentReference>? _region;
  List<DocumentReference> get region => _region ?? const [];
  bool hasRegion() => _region != null;

  // "isForSale" field.
  bool? _isForSale;
  bool get isForSale => _isForSale ?? false;
  bool hasIsForSale() => _isForSale != null;

  // "ratingSummary" field.
  double? _ratingSummary;
  double get ratingSummary => _ratingSummary ?? 0.0;
  bool hasRatingSummary() => _ratingSummary != null;

  // "socialUrl" field.
  List<DocumentReference>? _socialUrl;
  List<DocumentReference> get socialUrl => _socialUrl ?? const [];
  bool hasSocialUrl() => _socialUrl != null;

  // "numSearchDero" field.
  int? _numSearchDero;
  int get numSearchDero => _numSearchDero ?? 0;
  bool hasNumSearchDero() => _numSearchDero != null;

  // "contextChat" field.
  String? _contextChat;
  String get contextChat => _contextChat ?? '';
  bool hasContextChat() => _contextChat != null;

  // "numLinks" field.
  int? _numLinks;
  int get numLinks => _numLinks ?? 0;
  bool hasNumLinks() => _numLinks != null;

  // "fechaFinVenture" field.
  DateTime? _fechaFinVenture;
  DateTime? get fechaFinVenture => _fechaFinVenture;
  bool hasFechaFinVenture() => _fechaFinVenture != null;

  // "fechaInicioVenture" field.
  DateTime? _fechaInicioVenture;
  DateTime? get fechaInicioVenture => _fechaInicioVenture;
  bool hasFechaInicioVenture() => _fechaInicioVenture != null;

  void _initializeFields() {
    _productTitle = snapshotData['productTitle'] as String?;
    _productDescription = snapshotData['productDescription'] as String?;
    _size = snapshotData['size'] as String?;
    _imagesList = getDataList(snapshotData['imagesList']);
    _price = castToType<double>(snapshotData['price']);
    _favoritos = getDataList(snapshotData['favoritos']);
    _seller = snapshotData['seller'] as DocumentReference?;
    _inSell = snapshotData['inSell'] as bool?;
    _status = snapshotData['status'] as String?;
    _color = snapshotData['color'] as String?;
    _statusProduct = snapshotData['statusProduct'] as String?;
    _marca = snapshotData['marca'] as String?;
    _uuid = snapshotData['uuid'] as String?;
    _priceOld = castToType<double>(snapshotData['priceOld']);
    _percentageDiscount =
        castToType<double>(snapshotData['percentageDiscount']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _instagramLink = snapshotData['instagramLink'] as String?;
    _whatsappLink = snapshotData['whatsappLink'] as String?;
    _isLimited = snapshotData['isLimited'] as bool?;
    _category = getDataList(snapshotData['category']);
    _region = getDataList(snapshotData['region']);
    _isForSale = snapshotData['isForSale'] as bool?;
    _ratingSummary = castToType<double>(snapshotData['ratingSummary']);
    _socialUrl = getDataList(snapshotData['socialUrl']);
    _numSearchDero = castToType<int>(snapshotData['numSearchDero']);
    _contextChat = snapshotData['contextChat'] as String?;
    _numLinks = castToType<int>(snapshotData['numLinks']);
    _fechaFinVenture = snapshotData['fechaFinVenture'] as DateTime?;
    _fechaInicioVenture = snapshotData['fechaInicioVenture'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('venture');

  static Stream<VentureRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VentureRecord.fromSnapshot(s));

  static Future<VentureRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VentureRecord.fromSnapshot(s));

  static VentureRecord fromSnapshot(DocumentSnapshot snapshot) =>
      VentureRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VentureRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VentureRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VentureRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VentureRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVentureRecordData({
  String? productTitle,
  String? productDescription,
  String? size,
  double? price,
  DocumentReference? seller,
  bool? inSell,
  String? status,
  String? color,
  String? statusProduct,
  String? marca,
  String? uuid,
  double? priceOld,
  double? percentageDiscount,
  DateTime? createdAt,
  String? instagramLink,
  String? whatsappLink,
  bool? isLimited,
  bool? isForSale,
  double? ratingSummary,
  int? numSearchDero,
  String? contextChat,
  int? numLinks,
  DateTime? fechaFinVenture,
  DateTime? fechaInicioVenture,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'productTitle': productTitle,
      'productDescription': productDescription,
      'size': size,
      'price': price,
      'seller': seller,
      'inSell': inSell,
      'status': status,
      'color': color,
      'statusProduct': statusProduct,
      'marca': marca,
      'uuid': uuid,
      'priceOld': priceOld,
      'percentageDiscount': percentageDiscount,
      'createdAt': createdAt,
      'instagramLink': instagramLink,
      'whatsappLink': whatsappLink,
      'isLimited': isLimited,
      'isForSale': isForSale,
      'ratingSummary': ratingSummary,
      'numSearchDero': numSearchDero,
      'contextChat': contextChat,
      'numLinks': numLinks,
      'fechaFinVenture': fechaFinVenture,
      'fechaInicioVenture': fechaInicioVenture,
    }.withoutNulls,
  );

  return firestoreData;
}

class VentureRecordDocumentEquality implements Equality<VentureRecord> {
  const VentureRecordDocumentEquality();

  @override
  bool equals(VentureRecord? e1, VentureRecord? e2) {
    const listEquality = ListEquality();
    return e1?.productTitle == e2?.productTitle &&
        e1?.productDescription == e2?.productDescription &&
        e1?.size == e2?.size &&
        listEquality.equals(e1?.imagesList, e2?.imagesList) &&
        e1?.price == e2?.price &&
        listEquality.equals(e1?.favoritos, e2?.favoritos) &&
        e1?.seller == e2?.seller &&
        e1?.inSell == e2?.inSell &&
        e1?.status == e2?.status &&
        e1?.color == e2?.color &&
        e1?.statusProduct == e2?.statusProduct &&
        e1?.marca == e2?.marca &&
        e1?.uuid == e2?.uuid &&
        e1?.priceOld == e2?.priceOld &&
        e1?.percentageDiscount == e2?.percentageDiscount &&
        e1?.createdAt == e2?.createdAt &&
        e1?.instagramLink == e2?.instagramLink &&
        e1?.whatsappLink == e2?.whatsappLink &&
        e1?.isLimited == e2?.isLimited &&
        listEquality.equals(e1?.category, e2?.category) &&
        listEquality.equals(e1?.region, e2?.region) &&
        e1?.isForSale == e2?.isForSale &&
        e1?.ratingSummary == e2?.ratingSummary &&
        listEquality.equals(e1?.socialUrl, e2?.socialUrl) &&
        e1?.numSearchDero == e2?.numSearchDero &&
        e1?.contextChat == e2?.contextChat &&
        e1?.numLinks == e2?.numLinks &&
        e1?.fechaFinVenture == e2?.fechaFinVenture &&
        e1?.fechaInicioVenture == e2?.fechaInicioVenture;
  }

  @override
  int hash(VentureRecord? e) => const ListEquality().hash([
        e?.productTitle,
        e?.productDescription,
        e?.size,
        e?.imagesList,
        e?.price,
        e?.favoritos,
        e?.seller,
        e?.inSell,
        e?.status,
        e?.color,
        e?.statusProduct,
        e?.marca,
        e?.uuid,
        e?.priceOld,
        e?.percentageDiscount,
        e?.createdAt,
        e?.instagramLink,
        e?.whatsappLink,
        e?.isLimited,
        e?.category,
        e?.region,
        e?.isForSale,
        e?.ratingSummary,
        e?.socialUrl,
        e?.numSearchDero,
        e?.contextChat,
        e?.numLinks,
        e?.fechaFinVenture,
        e?.fechaInicioVenture
      ]);

  @override
  bool isValidKey(Object? o) => o is VentureRecord;
}
