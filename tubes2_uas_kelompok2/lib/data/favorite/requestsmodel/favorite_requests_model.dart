
class FavoriteRequestsModel {
  String imageId;
  String subId;

  FavoriteRequestsModel({required this.imageId, required this.subId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['sub_id'] = subId;
    return data;
  }
}