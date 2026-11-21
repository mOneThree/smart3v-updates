## 0.2.0

- No Matter Server restart when every Smart 3V board already runs the new version
  (for example on a fresh install).
- Retries the Matter Server restart up to three times, and again at the next check if it
  still fails. Firmware is only marked as delivered after a successful restart.
- Checks that the Matter Server imported the file and warns in the log if not.
- Quiet time: says in the log when a download is waiting for the quiet time; a newer
  firmware replaces one still waiting. Tested, including quiet times near midnight.

## 0.1.1

- Added an icon and a logo.

## 0.1.0

- First version: check the version list, download and verify new firmware, restart
  the Matter Server, refresh the Matter firmware entities.
