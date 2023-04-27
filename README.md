# Working Posture Notifier
I recently gained an adjustable height desk. Studies show that alternating your working posture leads to fewer musculoskeletal problems and improved mental activity.

So, what a better thing to do than to automate a notification that will remind you when to stand up and when to sit down? :grinning: :heart_eyes:

## Using the script
The script can remind you to alternate between 2 postures, form a certain starting time to a certain end time. How much time you'll stay on each posture is also configurable.

1. Add a crontab like `0/30 11-20 * * 1-5 bash -l /Users/gvalamatsas/Personal/working_posture_notifier/posture_notifier.sh`. This crontabl will make the script to run every 30 minutes, from 11:00 to 20:00, from Monday to Friday.
2. Configure your parameters inside the script:
```shell
START_TIME_HRS='11'   # The hour that you start working
START_TIME_MIN='00'   # The minute that you start working
END_TIME_HRS='19'     # The hour that you end working
END_TIME_MIN='30'     # The minute that you end working
MINS_POSTURE_1='60'   # How many minutes you want to stay at the posture 1
MINS_POSTURE_2='30'   # How many minutes you want to stay at the posture 2
STARTING_POSTURE='1'  # Which is your starting posture (1 or 2)
SWITCH_TO_POSTURE_1_MSG='Please sit down' # What is the notification message that you'll hear to switch to posture 2
SWITCH_TO_POSTURE_2_MSG='Please stand up' # What is the notification message that you'll hear to switch to posture 1
```
3. Enjoy fewer musculoskeletal problems!

## Future improvements
- Parameters to be passed as arguments
- Choosing between sound notification or silent (written) notification
