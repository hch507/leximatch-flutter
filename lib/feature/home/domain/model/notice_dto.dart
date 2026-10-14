class NoticeDto {
  final String content;
  final String? url;

  NoticeDto({
    required this.content,
    this.url,
  });

  factory NoticeDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return NoticeDto(
      content: json['content'] as String,
      url: json['url'] as String?,
    );
  }
}