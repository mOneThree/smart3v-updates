# Smart 3V updates

Firmware updates for Smart 3V LED controllers (ESP32-C6, Matter over Thread), and the
Home Assistant app that delivers them.

[![Add this repository to your Home Assistant.](https://my.home-assistant.io/badges/supervisor_store.svg)](https://my.home-assistant.io/redirect/supervisor_store/?repository_url=https%3A%2F%2Fgithub.com%2FmOneThree%2Fsmart3v-updates)

## Set up

1. In Home Assistant, add this repository to the app (add-on) store with the button
   above, or by hand: **Settings → Apps (Add-ons) → Store → ⋮ → Repositories** and
   add `https://github.com/mOneThree/smart3v-updates`.
2. Install **Smart 3V Updater** and start it.
3. In the **Matter Server** app's configuration, turn on **enable_test_net_dcl** and
   restart it.

New firmware then shows up on each board's **Firmware** page; press **Install** there.
Details: [smart3v_updater/DOCS.md](smart3v_updater/DOCS.md).

## What is in here

- `firmware/manifest.json` — the list of current firmware per product line.
- `firmware/*.ota` — the Matter update files.
- `smart3v_updater/` — the Home Assistant app.

These boards use Matter test credentials (vendor ID 0xFFF1). They are hobby devices,
not certified Matter products.
