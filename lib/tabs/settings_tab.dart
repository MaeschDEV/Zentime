import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:zentime/logic/settings.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTab();
}

class _SettingsTab extends State<SettingsTab> {
  Widget _buildNumberField({
    required String label,
    required double value,
    required Function(double?) onChanged,
  }) {
    Box<Settings> box = Hive.box<Settings>('settingsBox');

    return ListTile(
      title: Text(label),
      trailing: SizedBox(
        width: 100,
        child: TextFormField(
          key: Key('field_${label}_$value'),
          initialValue: value.toString(),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.end,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixText: 'h',
            isDense: true,
          ),
          onFieldSubmitted: (input) {
            final cleanedInput = input.replaceAll(',', '.');
            double? newValue = double.tryParse(cleanedInput);

            newValue ??= 0.0;

            final maxDailyHours =
                box.get('current')?.maxDailyWorkHours ?? double.infinity;
            if (newValue > maxDailyHours) {
              newValue = box.get('current')?.maxDailyWorkHours ?? newValue;
            }

            onChanged(newValue);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 32,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Settings", style: theme.textTheme.titleLarge),
                  Column(
                    spacing: 8,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Working time settings",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),

                          // Wir hören auf die Box, in der das Settings-Objekt gespeichert ist
                          ValueListenableBuilder(
                            valueListenable: Hive.box<Settings>(
                              'settingsBox',
                            ).listenable(),
                            builder: (context, Box<Settings> box, _) {
                              // Wir nehmen an, dass das Settings-Objekt unter dem Key 'current' liegt
                              final settings = box.get('current') ?? Settings();

                              return Column(
                                children: [
                                  // Wöchentliche Stunden nur noch als Anzeige
                                  ListTile(
                                    title: const Text("Weekly working hours"),
                                    subtitle: const Text(
                                      "Automatically calculated from Mon-Sun",
                                    ),
                                    trailing: Text(
                                      "${settings.weeklyWorkHours.toStringAsFixed(1)} h",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                          ),
                                    ),
                                  ),
                                  _buildNumberField(
                                    label: "Max. daily working hours",
                                    value: settings.maxDailyWorkHours,
                                    onChanged: (val) => {
                                      updateSettings(
                                        box,
                                        settings,
                                        maxDailyWorkHours: val,
                                      ),
                                      setState(() {}),
                                    },
                                  ),
                                  ListTile(
                                    title: const Text(
                                      "Calculate times automatically",
                                    ),
                                    trailing: Checkbox(
                                      value: settings.isCalculatedAutomatically,
                                      onChanged: (val) => {
                                        updateSettings(
                                          box,
                                          settings,
                                          isCalculatedAutomatically: val,
                                        ),
                                        setState(() {}),
                                      },
                                    ),
                                  ),
                                  const Divider(),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Monday",
                                          value: settings.mondayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              mondayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Monday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnMonday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnMonday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Tuesday",
                                          value: settings.tuesdayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              tuesdayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Tuesday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnTuesday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnTuesday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Wednesday",
                                          value: settings.wednesdayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              wednesdayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Wednesday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnWednesday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnWednesday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Thursday",
                                          value: settings.thursdayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              thursdayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Thursday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnThursday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnThursday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Friday",
                                          value: settings.fridayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              fridayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Friday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnFriday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnFriday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Saturday",
                                          value: settings.saturdayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              saturdayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Saturday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnSaturday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnSaturday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                  !settings.isCalculatedAutomatically
                                      ? _buildNumberField(
                                          label: "Sunday",
                                          value: settings.sundayWorkHours,
                                          onChanged: (val) => {
                                            updateSettings(
                                              box,
                                              settings,
                                              sundayWorkHours: val,
                                            ),
                                            setState(() {}),
                                          },
                                        )
                                      : ListTile(
                                          title: const Text("Sunday"),
                                          trailing: Checkbox(
                                            value: settings.workingOnSunday,
                                            onChanged: (val) => {
                                              updateSettings(
                                                box,
                                                settings,
                                                workingOnSunday: val,
                                              ),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void updateSettings(
  Box<Settings> box,
  Settings oldSettings, {
  double? mondayWorkHours,
  double? tuesdayWorkHours,
  double? wednesdayWorkHours,
  double? thursdayWorkHours,
  double? fridayWorkHours,
  double? saturdayWorkHours,
  double? sundayWorkHours,
  double? maxDailyWorkHours,
  bool? isCalculatedAutomatically,
  bool? workingOnMonday,
  bool? workingOnTuesday,
  bool? workingOnWednesday,
  bool? workingOnThursday,
  bool? workingOnFriday,
  bool? workingOnSaturday,
  bool? workingOnSunday,
}) async {
  // Wir nehmen die neuen Werte oder die alten, falls keine neuen übergeben wurden
  final m = mondayWorkHours ?? oldSettings.mondayWorkHours;
  final t = tuesdayWorkHours ?? oldSettings.tuesdayWorkHours;
  final w = wednesdayWorkHours ?? oldSettings.wednesdayWorkHours;
  final th = thursdayWorkHours ?? oldSettings.thursdayWorkHours;
  final f = fridayWorkHours ?? oldSettings.fridayWorkHours;
  final s = saturdayWorkHours ?? oldSettings.saturdayWorkHours;
  final su = sundayWorkHours ?? oldSettings.sundayWorkHours;
  final max = maxDailyWorkHours ?? oldSettings.maxDailyWorkHours;
  final isCalculated =
      isCalculatedAutomatically ?? oldSettings.isCalculatedAutomatically;
  final woM = workingOnMonday ?? oldSettings.workingOnMonday;
  final woTu = workingOnTuesday ?? oldSettings.workingOnTuesday;
  final woW = workingOnWednesday ?? oldSettings.workingOnWednesday;
  final woTh = workingOnThursday ?? oldSettings.workingOnThursday;
  final woF = workingOnFriday ?? oldSettings.workingOnFriday;
  final woSa = workingOnSaturday ?? oldSettings.workingOnSaturday;
  final woSu = workingOnSunday ?? oldSettings.workingOnSunday;

  // Die neue Wochensumme berechnen
  final double totalWeekly = m + t + w + th + f + s + su;

  final newSettings = Settings(
    weeklyWorkHours: totalWeekly, // Automatisch berechnet
    mondayWorkHours: m,
    tuesdayWorkHours: t,
    wednesdayWorkHours: w,
    thursdayWorkHours: th,
    fridayWorkHours: f,
    saturdayWorkHours: s,
    sundayWorkHours: su,
    maxDailyWorkHours: max,
    isCalculatedAutomatically: isCalculated,
    workingOnMonday: woM,
    workingOnTuesday: woTu,
    workingOnWednesday: woW,
    workingOnThursday: woTh,
    workingOnFriday: woF,
    workingOnSaturday: woSa,
    workingOnSunday: woSu,
  );

  await box.put('current', newSettings);
}
