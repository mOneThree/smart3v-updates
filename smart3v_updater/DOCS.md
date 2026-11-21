# Smart 3V Updater

Keeps Smart 3V boards up to date through Home Assistant. It looks for new firmware in
the Smart 3V updates repository, downloads it, hands it to the Matter Server and makes
the update show up on each board's **Firmware** page. You still press **Install**
yourself on each board.

## Before you start

- The **Matter Server** app must be installed and your boards paired.
- In the Matter Server's **Configuration**, turn on **enable_test_net_dcl** and restart
  it. Smart 3V boards use Matter test credentials; without this option the Matter
  Server ignores their firmware files. This app warns in its log if the option is off.

## What happens

1. Every few minutes (5 by default) the app downloads a small version list.
2. When there is a firmware newer than the last one it delivered, it downloads the
   file and checks its size and checksum.
3. It copies the file into the Matter Server's `updates` folder and restarts the
   Matter Server. Matter devices are unavailable for about a minute.
4. About 11 minutes later it refreshes the Matter firmware entities. The update is
   then offered on every matching board.

The first time the app runs it delivers the current firmware once, which restarts the
Matter Server one time even if your boards are already up to date.

## Options

| Option | Meaning |
|---|---|
| Check every (minutes) | How often to look for a new version. |
| Restart the Matter Server | `immediately`, or `quiet_time` to wait for the time below. |
| Quiet time | When to restart if `quiet_time` is selected (Home Assistant's time zone). |
| Wait before refreshing | Minutes to wait after the restart before refreshing the Firmware entities. |

To check right now, restart this app.

## Safety

- Firmware is only downloaded from the same repository folder as the version list,
  and only if its checksum matches the list.
- Nothing is installed automatically. An update you did not expect is a reason to
  stop and ask before pressing Install.
- The app uses Home Assistant's built-in app permissions (restart the Matter Server,
  refresh entities, write to the Matter Server's config folder). No password or
  access token is stored.
