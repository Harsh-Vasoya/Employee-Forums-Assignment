import 'package:employeeforumsassignment/database/database_helper.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatefulWidget {
  final String title;
  final String body;
  final int likes;
  final bool isLiked;
  final bool isSaved;
  const PostCard({super.key, required this.title, required this.body, required this.likes, required this.isLiked, required this.isSaved,});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  bool _isSaved = false;
  int _likesCount = 0;

  void updateLikeStatus(bool liked) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updatePostLikeStatus(widget.title, liked, widget.likes);
    setState(() {
      _isLiked = liked;
      _likesCount = liked ? _likesCount + 1 : _likesCount - 1;
    });
  }

  void updateSavedStatus(bool saved) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updatePostSavedStatus(widget.title, saved);
    setState(() {
      _isSaved = saved;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _likesCount = widget.likes;
    _isSaved = widget.isSaved;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: mobileBackgroundColor,),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://s3-alpha-sig.figma.com/img/a57f/7188/c5c7aa2da965020d4f85fee632bb0bc2?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LaR2Y49G3PxRvrs1VxfTcegUldTJeQ1ksv-nYDrr8W-6t7i4dpkXhf-wZdJfiGfJBUg4IZdTiui3YrqS-wA3F346DgQwtAfX82tf5pfVsYj-QZNvR-VAapyvA80yq2qTb2Ub1gOVdcleBJZG78-YWtbvHStVwYDw4JG8-5KogHEVRwtB~ZuaRlN96RdPGQa~4DBx4McDrESrdzl1DJ0uZP39FRZwyQiTEKFnZiivP0SyBGj6yLwMWwr3WkaiDRI3MRRRI82dGXT57ywMuaY6iSJlmv5l2x0AQAvfCyvk5dumkAkrCRnPRg3ZKrnvJOzNolbKVn08A6AYQM1e5eaCCQ__"),
                  radius: 20,
                ),
                title: Text(widget.title, style: GoogleFonts.nunito(color: blackText, fontSize: 12, fontWeight: FontWeight.w400),),
                subtitle: Text(widget.title, style: GoogleFonts.nunito(color: blackText, fontSize: 10, fontWeight: FontWeight.w400)),
                trailing: IconButton(
                  onPressed: () {
                    updateSavedStatus(_isSaved? false:true);
                  },
                  icon: Icon(_isSaved? Icons.bookmark: Icons.bookmark_border_rounded), color: greyColor,),
              ),
              const SizedBox(height: 2),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 336,
                color: greyBoxColor,
                child: const SizedBox()
              ),
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Text(widget.body, style: GoogleFonts.roboto(color: blackText, fontSize: 14, fontWeight: FontWeight.w400))
              ),
              const Divider(thickness: 0.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LikeButton(isLiked: _isLiked, liked: updateLikeStatus, likes: _likesCount,),
                  const CommentButton(),
                  const ShareButton(),
                ],
              )
            ]
        )
    );
  }
}

class LikeButton extends StatefulWidget{
  final int likes;
  final bool isLiked;
  final void Function(bool liked) liked;
  const LikeButton({super.key, required this.isLiked, required this.liked, required this.likes,});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              widget.liked(widget.isLiked? false:true);
              },
            icon: Icon(widget.isLiked? Icons.thumb_up_alt_rounded: Icons.thumb_up_outlined), color: greyColor,),
        Text("${widget.likes.toString()} Likes", style: GoogleFonts.roboto(color: greyColor, fontSize: 14, fontWeight: FontWeight.w400),),
      ],
    );
  }
}

class CommentButton extends StatefulWidget{
  const CommentButton({super.key});

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.mode_comment_outlined), color: greyColor,),
        Text("45 Comments", style: GoogleFonts.roboto(color: greyColor, fontSize: 14, fontWeight: FontWeight.w400),),
      ],
    );
  }
}


class ShareButton extends StatefulWidget{
  const ShareButton({super.key});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.share_rounded), color: greyColor,),
        Text("Share", style: GoogleFonts.roboto(color: greyColor, fontSize: 14, fontWeight: FontWeight.w400),),
      ],
    );
  }
}

