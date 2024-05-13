import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key,});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: mobileBackgroundColor,),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://s3-alpha-sig.figma.com/img/a57f/7188/c5c7aa2da965020d4f85fee632bb0bc2?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LaR2Y49G3PxRvrs1VxfTcegUldTJeQ1ksv-nYDrr8W-6t7i4dpkXhf-wZdJfiGfJBUg4IZdTiui3YrqS-wA3F346DgQwtAfX82tf5pfVsYj-QZNvR-VAapyvA80yq2qTb2Ub1gOVdcleBJZG78-YWtbvHStVwYDw4JG8-5KogHEVRwtB~ZuaRlN96RdPGQa~4DBx4McDrESrdzl1DJ0uZP39FRZwyQiTEKFnZiivP0SyBGj6yLwMWwr3WkaiDRI3MRRRI82dGXT57ywMuaY6iSJlmv5l2x0AQAvfCyvk5dumkAkrCRnPRg3ZKrnvJOzNolbKVn08A6AYQM1e5eaCCQ__"),
                  radius: 20,
                ),
                title: Text("Arneo Paris", style: GoogleFonts.nunito(color: blackText, fontSize: 12, fontWeight: FontWeight.w400),),
                subtitle: Text("Arneo", style: GoogleFonts.nunito(color: blackText, fontSize: 10, fontWeight: FontWeight.w400)),
                trailing: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.more_horiz_rounded, color: greyButtonColor),),
              ),
              SizedBox(height: 2),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 336,
                color: greyBoxColor,
                child: SizedBox()
              ),
              Container(
                padding: EdgeInsets.only(left: 13, right: 13),
                  child: Text("we need to start with the basics. A fundamental under of blogging will help... see more", style: GoogleFonts.roboto(color: blackText, fontSize: 14, fontWeight: FontWeight.w400))
              ),
              Divider(thickness: 0.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LikeButton(isLiked: false, liked: (bool likechanged){}),
                  CommentButton(),
                  ShareButton(),
                ],
              )
            ]
        )
    );
  }
}

class LikeButton extends StatefulWidget{
  final bool isLiked;
  final void Function(bool liked) liked;
  const LikeButton({super.key, required this.isLiked, required this.liked,});

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
        Text("5k Likes", style: GoogleFonts.roboto(color: greyColor, fontSize: 14, fontWeight: FontWeight.w400),),
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

