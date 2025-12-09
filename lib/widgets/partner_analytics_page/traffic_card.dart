import 'package:flutter/material.dart';

class TrafficCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String changeLabel;
  final Color? valueColor;

  const TrafficCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.changeLabel,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Container(
          // height: ,
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1),
            borderRadius: BorderRadius.circular(w * 0.05),
            border: Border.all(color: onSurface.withOpacity(0.08)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.08,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: onSurface.withOpacity(0.70),
                          fontSize: w * 0.09,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: w * 0.13,
                          fontWeight: FontWeight.bold,
                          color: valueColor ?? Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: w * 0.08,
                          color: onSurface.withOpacity(0.55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (changeLabel.isNotEmpty)
                FittedBox(
                  child: Text(
                    changeLabel,
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: w * 0.12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
