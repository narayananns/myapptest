import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_page/store_time_controller.dart';
import 'package:thristoparnterapp/services/store_time_api.dart';

class StoreTimingsScreen extends StatefulWidget {
  const StoreTimingsScreen({super.key});

  @override
  State<StoreTimingsScreen> createState() => _StoreTimingsScreenState();
}

class _StoreTimingsScreenState extends State<StoreTimingsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the latest store timings when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoreTimeController>(context, listen: false).loadStoreTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Store Timings"), centerTitle: true),
      body: Consumer<StoreTimeController>(
        builder: (context, ctrl, _) {
          return Column(
            children: [
              const SizedBox(height: 20),

              Text(
                "The Store is Currently ${ctrl.isStoreOpen ? 'Open' : 'Closed'}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ctrl.isStoreOpen ? Colors.green : Colors.red,
                ),
              ),

              const SizedBox(height: 40),

              // ------- CENTER CLOCK --------
              Container(
                width: 220,
                height: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ctrl.isStoreOpen ? Colors.green : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ctrl.isStoreOpen
                          ? 'Time Left For Closing'
                          : 'The Store Will Open In',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          ctrl.isStoreOpen
                              ? ctrl.remainingOpenTime
                              : ctrl.remainingClosedTime,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // ------------- STORE TIMINGS ROW ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectTime(context, true, ctrl),
                        child: timeTile(
                          "Open Time",
                          ctrl.openTime.format(context),
                          Icons.wb_sunny_outlined,
                          Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectTime(context, false, ctrl),
                        child: timeTile(
                          "Close Time",
                          ctrl.closeTime.format(context),
                          Icons.nightlight_round,
                          Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // -------------- SAVE BUTTON ------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final model = ctrl.getTimeModel();
                      await StoreTimeApiService.saveStoreTime(model);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Store Timings Saved")),
                      );
                    },
                    child: const Text(
                      "Save Timings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Future<void> selectTime(
    BuildContext context,
    bool isOpen,
    StoreTimeController ctrl,
  ) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpen ? ctrl.openTime : ctrl.closeTime,
    );

    if (picked != null) {
      isOpen ? ctrl.updateOpenTime(picked) : ctrl.updateCloseTime(picked);
    }
  }

  Widget timeTile(String title, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
