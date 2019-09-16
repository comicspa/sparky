import 'dart:typed_data';


enum e_packet_type
{
  none,

  c2s_echo,
  s2c_echo,

  c2s_upload_file,
  s2c_upload_file,

  c2s_signup,
  s2c_signup,

  c2s_withdrawal,
  s2c_withdrawal,

  c2s_login,
  s2c_login,

  c2s_logout,
  s2c_logout,

  c2s_register_creator,
  s2c_register_creator,

  c2s_unregister_creator,
  s2c_unregister_creator,

  c2s_today_trend_comic_info,
  s2c_today_trend_comic_info,

  c2s_view_comic,
  s2c_view_comic,

  c2s_comic_detail_info,
  s2c_comic_detail_info,

  c2s_featured_comic_info,
  s2c_featured_comic_info,

  c2s_new_comic_info,
  s2c_new_comic_info,

  c2s_weekly_trend_comic_info,
  s2c_weekly_trend_comic_info,

  c2s_real_time_trend_info,
  s2c_real_time_trend_info,

  c2s_recommended_comic_info,
  s2c_recommended_comic_info,

  c2s_new_creator_info,
  s2c_new_creator_info,

  c2s_weekly_creator_info,
  s2c_weekly_creator_info,

  c2s_recommended_creator_info,
  s2c_recommended_creator_info,

  c2s_library_view_list_comic_info,
  s2c_library_view_list_comic_info,

  c2s_library_continue_comic_info,
  s2c_library_continue_comic_info,

  c2s_library_owned_comic_info,
  s2c_library_owned_comic_info,

  c2s_library_recent_comic_info,
  s2c_library_recent_comic_info,

  c2s_preset_comic_info,
  s2c_preset_comic_info,

  c2s_preset_library_info,
  s2c_preset_library_info,

  c2s_user_info,
  s2c_user_info,

}


class PacketCommon
{
  static Endian _endian = Endian.little;

  static Endian get endian => _endian;

  int _size = 4 + 2;
  e_packet_type _type = e_packet_type.none;

  int get size => _size;
  e_packet_type get type => _type;

  Uint8List _packet;
  var byteData;
  int _currentOffset = 0;

  Uint8List get packet => _packet;
  int get currentOffset => _currentOffset;

  final int _version = 0;

  set packet(Uint8List packet)
  {
    _packet = packet;
  }

  set currentOffset(int currentOffset)
  {
    _currentOffset = currentOffset;
  }

  set size(int size)
  {
    _size = size;
  }

  set type(e_packet_type type)
  {
    _type = type;
  }


  static void setCSharpSocketServer()
  {
    _endian = Endian.little;
  }

}