import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: camel_case_types
class insta {

  String? _followers, _following, _website, _bio, _imgurl, _username;
  List<String>? _feedImagesUrl;
  var link1;

Future <String> downloadImage(String link)async{
  final response = await http.get(
    Uri.parse(link),
  );
  var jsonData = jsonDecode(response.body);
  var graphql = jsonData['graphql'];
  var shortcodeMedia = graphql['shortcode_media'];
  var image_url = shortcodeMedia['display_resources'];


  var src0 = image_url[2];
  link1 = src0['src'];
  return link1;
}
  Future<void> getProfileData(String username) async {
    var res = await http.get(Uri.parse(Uri.encodeFull(url + username + "/?__a=1")));
    var data = json.decode(res.body);
    var graphql = data['graphql'];
    var user = graphql['user'];
    var biography = user['biography'];
    _bio = biography;
    var myfollowers = user['edge_followed_by'];
    var myfollowing = user['edge_follow'];
    _followers = myfollowers['count'].toString();
    _following = myfollowing['count'].toString();
    _website = user['external_url'];
    _imgurl = user['profile_pic_url_hd'];
    _feedImagesUrl =
        user['edge_owner_to_timeline_media']['edges'].map<String>((image) => image['node']['display_url'] as String).toList();
    this._username = username;
  }

  String? get followers => _followers;

  get following => _following;

  get username => _username;

  get website => _website;

  get bio => _bio;

  get imgurl => _imgurl;

  List<String>? get feedImagesUrl => _feedImagesUrl;


}
