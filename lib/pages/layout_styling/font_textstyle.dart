import 'package:flutter/material.dart';

class FontTextStyle extends StatelessWidget {
  const FontTextStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text & Typography")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. ADVANCED HEADLINE (Shadows & Spacing)
            Text(
              "DESIGN",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w900, // Extra Bold
                color: Colors.white,
                letterSpacing: 4.0, // Spaced out letters
                shadows: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    offset: Offset(4, 4),
                    blurRadius: 0, // Sharp shadow (Retro look)
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(8, 8),
                    blurRadius: 10, // Soft shadow
                  ),
                ],
              ),
            ),

            Text(
              "THE HIDDEN ART OF TYPOGRAPHY",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey[600],
              ),
            ),

            Divider(height: 40, thickness: 2),

            // 2. RICH TEXT (Multiple styles in one paragraph)
            Text(
              "RichText & Spans:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 5),

            Text.rich(
              TextSpan(
                text: "Flutter allows you to mix ",
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                    text: "bold ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: "italic ",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.purple,
                    ),
                  ),
                  TextSpan(text: "and "),
                  TextSpan(
                    text: "STYLED ",
                    style: TextStyle(
                      backgroundColor: Colors.yellowAccent,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "text seamlessly."),
                ],
              ),
            ),

            Divider(height: 40),

            // 3. DECORATIONS (Underline, LineThrough)
            Text(
              "Decorations:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Strikethrough (Old Price)
                Text(
                  "\$199.99",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough, // Cross out
                    decorationThickness: 2,
                  ),
                ),
                // Wavy Underline (Error or Emphasis)
                Text(
                  "\$99.00",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy, // Wavy line
                    decorationColor: Colors.greenAccent,
                  ),
                ),
              ],
            ),

            Divider(height: 40),

            // 4. OVERFLOW & HEIGHT (Handling long text)
            Text(
              "Overflow & Line Height:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 10),

            Container(
              width: 200, // Constrain width to force overflow
              color: Colors.grey[200],
              padding: EdgeInsets.all(8),
              child: Text(
                "This is a very long text that will surely not fit in one line. It simulates a preview of a blog post or message.",
                maxLines: 2, // Limit to 2 lines
                overflow: TextOverflow.ellipsis, // Add "..." at the end
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5, // Line height (150% of font size)
                  fontFamily: 'Courier', // Monospace font
                ),
              ),
            ),
            Text(
              "(Constrained to 2 lines with Ellipsis)",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            Divider(height: 40),

            // 5. CUSTOM FONT FAMILY FEEL
            Text(
              "Script Style",
              style: TextStyle(
                fontFamily:
                    "Times New Roman", // Uses device system font if available
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.blue[900]!,
              ),
            ),
            Text(
              "Hollow text using Paint foreground",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
