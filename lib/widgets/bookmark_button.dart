import 'package:flutter/material.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/resources/CRUD/user.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/utils.dart';
import 'package:provider/provider.dart';

class BookmarkButton extends StatefulWidget {
  final String listingId;

  const BookmarkButton({super.key, required this.listingId});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isLoading = false;
  bool isBookmark = false;

  void modifyBookmark(context, UserProvider value) async {
    String res = "";
    setState(() {
      _isLoading = true;
    });
    if (!isBookmark) {
      res = await UserController().addBookmark(listingId: widget.listingId);
      if (res == 'success') {
        setState(() {
          isBookmark = true;
        });
        showSnackBar("Add to bookmark", context);
        value.addBookmark(widget.listingId);
      }
    } else {
      res = await UserController().removeBookmark(listingId: widget.listingId);
      if (res == 'success') {
        showSnackBar("Remove from bookmark", context);
        setState(() {
          isBookmark = false;
          value.removeBookmark(widget.listingId);
        });
      }
    }
    setState(() {
      _isLoading = false;
    });

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            if (value.getUser.bookmark.contains(widget.listingId)) {
              isBookmark = true;
            }
            return _isLoading
                ? SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: mainGreen,
                    )))
                : GestureDetector(
                    onTap: () {
                      modifyBookmark(context, value);
                    },
                    child: Icon(
                      isBookmark ? Icons.bookmark : Icons.bookmark_border,
                      color: mainGreen,
                      size: 30,
                    ),
                  );
          }),
    );
  }
}
