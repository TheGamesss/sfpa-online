(function () {
  const APP_READY = "sfpa-app-ready";
  const APP_SNAPSHOT = "sfpa-app-snapshot";
  const APP_EVENT = "sfpa-app-event";
  let achievementSinkBound = false;

  function post(type, payload = {}) {
    if (window.parent === window) {
      return;
    }

    window.parent.postMessage({ type, ...payload }, window.location.origin);
  }

  function getApi() {
    return window.sfpaAchievementApi ?? null;
  }

  function bindAchievementSink() {
    if (achievementSinkBound) {
      return;
    }

    const api = getApi();
    if (!api || typeof api.setSink !== "function") {
      return;
    }

    api.setSink((name, payload, snapshot) => {
      post(APP_EVENT, { name, payload, snapshot });
    });
    achievementSinkBound = true;
  }

  function emitSnapshot() {
    const api = getApi();
    if (!api) {
      return false;
    }

    bindAchievementSink();

    const snapshot = {
      levelSession: typeof api.getLevelSession === "function" ? api.getLevelSession() : null,
      boot: typeof api.getBootState === "function" ? api.getBootState() : null,
      settings: typeof api.getSettings === "function" ? api.getSettings() : null,
      levelCatalog: typeof api.getLevelCatalog === "function" ? api.getLevelCatalog() : null,
      achievements: typeof api.snapshot === "function" ? api.snapshot() : null
    };

    post(APP_SNAPSHOT, { snapshot });
    return true;
  }

  function clearSave() {
    const api = getApi();
    if (api && typeof api.clearSave === "function") {
      api.clearSave();
    } else {
      window.localStorage.removeItem("sfpa_native_port_state");
    }

    post(APP_EVENT, { name: "save-cleared" });
    window.location.reload();
  }

  window.addEventListener("message", (event) => {
    if (event.origin !== window.location.origin) {
      return;
    }

    const data = event.data ?? {};
    switch (data.type) {
      case "sfpa-host:getSnapshot":
      case "sfpa-host:ping":
        emitSnapshot();
        break;
      case "sfpa-host:clearSave":
        clearSave();
        break;
      default:
        break;
    }
  });

  window.addEventListener("load", () => {
    post(APP_READY);
    window.setTimeout(() => {
      emitSnapshot();
    }, 250);
  });

  window.setInterval(() => {
    if (!emitSnapshot()) {
      post(APP_READY);
    }
  }, 1500);
})();
