import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_page/mypayment_controller.dart';

class PaymentTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PaymentController>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.loadPayments,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 32,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DataTable(
                        dividerThickness: 0.0,
                        horizontalMargin: 10,
                        columnSpacing: 20,
                        headingRowHeight: 45,
                        dataRowMinHeight: 45,
                        dataRowMaxHeight: 45,
                        // headingRowColor: MaterialStateColor.resolveWith(
                        //   (_) => Colors.black12,
                        // ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Order No",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        rows: controller.payments
                            .map(
                              (pay) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      pay.date,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      pay.orderNo,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      pay.amount,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      pay.status,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Pagination Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Rows per page:", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              DropdownButton<int>(
                value: controller.rowsPerPage,
                underline: const SizedBox(),
                items: [5, 10, 25].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text("$value", style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.updateRowsPerPage(value);
                  }
                },
              ),
              const SizedBox(width: 20),
              Text(
                "${(controller.currentPage - 1) * controller.rowsPerPage + 1}-${(controller.currentPage * controller.rowsPerPage) > controller.total ? controller.total : (controller.currentPage * controller.rowsPerPage)} of ${controller.total}",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: controller.currentPage > 1
                    ? controller.previousPage
                    : null,
                icon: const Icon(Icons.chevron_left),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 24,
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed:
                    (controller.currentPage * controller.rowsPerPage) <
                        controller.total
                    ? controller.nextPage
                    : null,
                icon: const Icon(Icons.chevron_right),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
