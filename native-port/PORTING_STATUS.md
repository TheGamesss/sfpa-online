# Native Port Status

Current migrated systems:

- OpenFL HTML5 boot target compiles and renders through Starling.
- Original boot defaults are preserved as `World 4 / Menus0-a / door 1`.
- Original boot URL overrides are mapped in `Source/sfpa/core/BootState.hx`.
- Original local settings defaults and World 4 progress defaults are mapped in:
  - `Source/sfpa/core/LocalSettings.hx`
  - `Source/sfpa/core/World4Progress.hx`
- Browser save persistence now uses local storage in `Source/sfpa/storage/SaveStore.hx`.
- Original level identifiers are indexed from the real `Levels` folder by:
  - `tools/generate-level-manifest.mjs`
  - `Assets/data/level-manifest.json`
- Native level-session state now mirrors the original transition model for:
  - current route vs loaded route
  - `startLoad` / `loadLevel` style state updates
  - special transitions such as `bonus`, `finish`, `return`, `Respawn`, `MapScreen`, and `LevelSelect`
  - native keyboard-driven selection and transition testing in `Source/sfpa/boot/PortStarlingRoot.hx`
- The transition shell has been replaced by a native menu-style shell with:
  - clickable action cards in `Source/sfpa/ui/MenuButton.hx`
  - route, browser, and history panels in `Source/sfpa/boot/PortStarlingRoot.hx`
  - persistent language, fullscreen, and one-handed settings through `Source/sfpa/core/PortContext.hx`
- The root shell is now split into real scene classes under `Source/sfpa/scene`:
  - `RouteShellScene`
  - `MapShellScene`
  - `LevelSelectShellScene`
  - `RespawnShellScene`
  - all hosted by `PortSceneController`
- The deployable website shell now lives outside the raw OpenFL export:
  - `site/` contains the outer website shell and iframe bridge
  - `scripts/build-deploy-site.mjs` packages the final static site into `dist/`
  - `RENDER_DEPLOY.md` documents the Render static-site path
- Achievement calls still route through the web bridge layer under `Source/sfpa/achievements`.

Next safe migration slice:

1. Start translating the actual gameplay boot path for one slice, beginning with menu assets, player spawn setup, and `LoadIt`-driven entry behavior.
2. Replace the shell’s placeholder scene content with real native menu/game scene logic that maps to the original menu states.
3. Port browser-safe input beyond the shell controls, especially the original keyboard/gamepad mapping and one-handed settings behavior.
4. Begin replacing SWF-level lookups with native asset/runtime classes so level transitions can instantiate real game scenes.
