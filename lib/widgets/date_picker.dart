import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';

class BahamaDatePicker extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final ValueChanged<DateTime> onCheckInChanged;
  final ValueChanged<DateTime> onCheckOutChanged;

  const BahamaDatePicker({
    super.key,
    this.checkIn,
    this.checkOut,
    required this.onCheckInChanged,
    required this.onCheckOutChanged,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, yyyy');
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DateButton(
                  label: 'Check-in',
                  date: checkIn != null ? formatter.format(checkIn!) : 'Select date',
                  icon: Icons.calendar_today_rounded,
                  onTap: () => _showDatePicker(context, true),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BahamaColors.offWhiteMist,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: BahamaColors.islandBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DateButton(
                  label: 'Check-out',
                  date: checkOut != null ? formatter.format(checkOut!) : 'Select date',
                  icon: Icons.calendar_today_rounded,
                  onTap: () => _showDatePicker(context, false),
                ),
              ),
            ],
          ),
          if (checkIn != null && checkOut != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: BahamaColors.islandBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.nights_stay_rounded,
                    size: 18,
                    color: BahamaColors.islandBlue,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${checkOut!.difference(checkIn!).inDays} nights',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.islandBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context, bool isCheckIn) async {
    final initialDate = isCheckIn
        ? (checkIn ?? DateTime.now().add(const Duration(days: 1)))
        : (checkOut ?? (checkIn?.add(const Duration(days: 1)) ?? DateTime.now().add(const Duration(days: 2))));
    
    final firstDate = isCheckIn
        ? DateTime.now()
        : (checkIn?.add(const Duration(days: 1)) ?? DateTime.now());
    
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BahamaColors.islandBlue,
              onPrimary: Colors.white,
              surface: BahamaColors.whiteSand,
              onSurface: BahamaColors.deepTeal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isCheckIn) {
        onCheckInChanged(picked);
      } else {
        onCheckOutChanged(picked);
      }
    }
  }
}

class _DateButton extends StatelessWidget {
  final String label;
  final String date;
  final IconData icon;
  final VoidCallback onTap;

  const _DateButton({
    required this.label,
    required this.date,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BahamaColors.offWhiteMist,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: BahamaColors.greyPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(icon, size: 16, color: BahamaColors.islandBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: BahamaColors.deepTeal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BahamaGuestSelector extends StatelessWidget {
  final int adults;
  final int children;
  final int rooms;
  final ValueChanged<int> onAdultsChanged;
  final ValueChanged<int> onChildrenChanged;
  final ValueChanged<int> onRoomsChanged;

  const BahamaGuestSelector({
    super.key,
    required this.adults,
    required this.children,
    required this.rooms,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onRoomsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _CounterRow(
            icon: Icons.person_outline_rounded,
            label: 'Adults',
            subtitle: 'Ages 13+',
            value: adults,
            minValue: 1,
            onChanged: onAdultsChanged,
          ),
          const Divider(height: 24),
          _CounterRow(
            icon: Icons.child_care_rounded,
            label: 'Children',
            subtitle: 'Ages 2-12',
            value: children,
            minValue: 0,
            onChanged: onChildrenChanged,
          ),
          const Divider(height: 24),
          _CounterRow(
            icon: Icons.bed_rounded,
            label: 'Rooms',
            subtitle: '',
            value: rooms,
            minValue: 1,
            onChanged: onRoomsChanged,
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final int value;
  final int minValue;
  final ValueChanged<int> onChanged;

  const _CounterRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.minValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: BahamaColors.offWhiteMist,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: BahamaColors.islandBlue, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.deepTeal,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BahamaColors.greyPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            _CounterButton(
              icon: Icons.remove,
              enabled: value > minValue,
              onTap: () {
                if (value > minValue) onChanged(value - 1);
              },
            ),
            SizedBox(
              width: 44,
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: BahamaColors.deepTeal,
                ),
              ),
            ),
            _CounterButton(
              icon: Icons.add,
              enabled: true,
              onTap: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _CounterButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: enabled ? BahamaColors.islandBlue.withOpacity(0.1) : BahamaColors.greyLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(10),
          child: Icon(
            icon,
            size: 18,
            color: enabled ? BahamaColors.islandBlue : BahamaColors.greySecondary,
          ),
        ),
      ),
    );
  }
}

void showGuestSelectorSheet(
  BuildContext context, {
  required int adults,
  required int children,
  required int rooms,
  required Function(int adults, int children, int rooms) onConfirm,
}) {
  int tempAdults = adults;
  int tempChildren = children;
  int tempRooms = rooms;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: BahamaColors.whiteSand,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: BahamaColors.greySecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Guests & Rooms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: BahamaColors.deepTeal,
                ),
              ),
              const SizedBox(height: 24),
              BahamaGuestSelector(
                adults: tempAdults,
                children: tempChildren,
                rooms: tempRooms,
                onAdultsChanged: (v) => setState(() => tempAdults = v),
                onChildrenChanged: (v) => setState(() => tempChildren = v),
                onRoomsChanged: (v) => setState(() => tempRooms = v),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    onConfirm(tempAdults, tempChildren, tempRooms);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BahamaColors.warmGold,
                    foregroundColor: BahamaColors.deepTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Confirm (${tempAdults + tempChildren} guests, $tempRooms room${tempRooms > 1 ? 's' : ''})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    ),
  );
}

