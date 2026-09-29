# Super Fancy Pants Adventure — Browser Edition

This static site runs the supplied game SWF with the Ruffle Flash emulator. The web build keeps the original level files and game save format. A small adapter in `SFPA-web.swf` forwards the game's existing achievement unlocks to the website, where the 16 achievements are saved in browser storage.

Browser achievement progress is local to the browser and does not sync to Steam. The Steam overlay, Steam account achievements, and other native Steam services are not available on a static website.

## Build and preview

From the project folder:

```sh
npm run build
python -m http.server 8000 --directory dist
```

Open <http://localhost:8000>. Serve the site over HTTP; loading the SWF directly with a `file://` URL does not work.

## Render

The root `render.yaml` defines a Render static site. Connect this project to Render as a Blueprint; Render runs `npm run build` and publishes `dist`.

The `vendor/ruffle` directory contains the self-hosted web build from the dated Ruffle release recorded in `vendor/ruffle/VERSION`, along with its licenses.
