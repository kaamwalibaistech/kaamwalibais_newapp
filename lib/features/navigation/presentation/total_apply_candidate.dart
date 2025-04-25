import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kaamwalijobs_new/features/jobs/network/job_repository.dart';
import 'package:kaamwalijobs_new/models/apply_candidate_list_model.dart';

class ApplyCandidateListScreen extends StatefulWidget {
  final String? jobPostId;

  const ApplyCandidateListScreen({super.key, required this.jobPostId});

  @override
  State<ApplyCandidateListScreen> createState() =>
      _ApplyCandidateListScreenState();
}

class _ApplyCandidateListScreenState extends State<ApplyCandidateListScreen> {
  ApplyCandidateList? applyCandidateData;
  bool isLoading = false;
  String? errorMessage;
  String? selectedStatus;
  String? selectedstatusNumber;
  final TextEditingController _reasonController = TextEditingController();
  final JobRepository _jobRepository = JobRepository();

  @override
  void initState() {
    super.initState();
    _loadApplyCandidateList();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _loadApplyCandidateList() async {
    if (widget.jobPostId == null) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data =
          await _jobRepository.getApplyCandidateList(widget.jobPostId!);
      setState(() {
        applyCandidateData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load applicants. Please try again.';
        isLoading = false;
      });
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _showStatusDialog(
      String candidateId, String statusNumber) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update Status',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: selectedStatus,
              decoration: InputDecoration(
                labelText: 'Select Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Accepted',
                  child: Text('Accepted'),
                ),
                DropdownMenuItem(
                  value: 'Rejected',
                  child: Text('Rejected'),
                ),
              ],
              onChanged: (value) {
                if (value == "Rejected") {
                  setState(() {
                    selectedStatus = value;
                    selectedstatusNumber = "4";
                  });
                } else {
                  setState(() {
                    selectedStatus = value;
                    selectedstatusNumber = "3";
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: 'Reason (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _jobRepository.updateApplyCandidateList(
                    candidateId, selectedstatusNumber.toString());
                if (mounted) {
                  Navigator.pop(context);
                  _loadApplyCandidateList(); // Refresh the list
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Failed to update status. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Update',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applicants',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.red[300],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadApplyCandidateList,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (applyCandidateData?.applyList.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Applicants Yet',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new applications',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: applyCandidateData?.applyList.length ?? 0,
      itemBuilder: (context, index) {
        final candidate = applyCandidateData!.applyList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        candidate.candidateName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        candidate.categoryName,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      candidate.phoneNo,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Applied on ${_formatDate(candidate.applyDate)}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getStatusText(candidate.status),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _getStatusColor(candidate.status),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showStatusDialog(
                          candidate.applyId, selectedstatusNumber.toString()),
                      icon: const Icon(Icons.update),
                      label: Text(
                        'Update Status',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case "3":
        return "Accepted";
      case "4":
        return "Rejected";
      default:
        return "Pending";
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "3":
        return Colors.green;
      case "4":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
