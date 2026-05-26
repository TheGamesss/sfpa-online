const frame = document.getElementById("gameFrame");
const frameShell = document.getElementById("gameFrameShell");
const loadingOverlay = document.getElementById("loadingOverlay");
const shellStatusText = document.getElementById("shellStatusText");
const connectionValue = document.getElementById("connectionValue");
const sceneValue = document.getElementById("sceneValue");
const routeValue = document.getElementById("routeValue");
const viewModeValue = document.getElementById("viewModeValue");
const selectedRouteValue = document.getElementById("selectedRouteValue");
const loadedRouteValue = document.getElementById("loadedRouteValue");
const languageValue = document.getElementById("languageValue");
const oneHandedValue = document.getElementById("oneHandedValue");
const bridgeLog = document.getElementById("bridgeLog");
const playFocusButton = document.getElementById("playFocusButton");
const fullscreenButton = document.getElementById("fullscreenButton");
const reloadButton = document.getElementById("reloadButton");
const clearSaveButton = document.getElementById("clearSaveButton");

const bridgeState = {
  connected: false,
  lastSnapshot: null
};

function setStatus(message) {
  shellStatusText.textContent = message;
}

function setConnection(connected) {
  bridgeState.connected = connected;
  connectionValue.textContent = connected ? "Connected" : "Waiting";
  if (connected) {
    loadingOverlay.classList.add("is-hidden");
  }
}

function formatRoute(dir, level, door) {
  if (!dir || !level || door == null) {
    return "Unknown";
  }

  return `${dir} / ${level} / door ${door}`;
}

function updateBridgeLog(snapshot) {
  bridgeLog.textContent = JSON.stringify(snapshot, null, 2);
}

function updateSnapshot(snapshot) {
  if (!snapshot) {
    return;
  }

  bridgeState.lastSnapshot = snapshot;
  const session = snapshot.levelSession ?? {};
  const settings = snapshot.settings ?? {};

  sceneValue.textContent = session.viewMode ?? "Unknown";
  routeValue.textContent = session.levelLoaded ?? "Unknown";
  viewModeValue.textContent = session.viewMode ?? "Unknown";
  selectedRouteValue.textContent = formatRoute(session.selectedDir, session.selectedLevel, session.selectedDoor);
  loadedRouteValue.textContent = formatRoute(session.dirLoaded, session.levelLoaded, session.doorLoaded);
  languageValue.textContent = settings.language ?? "Unknown";
  oneHandedValue.textContent = settings.oneHanded == null ? "Unknown" : String(settings.oneHanded);
  setStatus(`Live app state received. Current scene: ${session.viewMode ?? "Unknown"}.`);
  updateBridgeLog(snapshot);
}

function postCommand(type, payload = {}) {
  frame?.contentWindow?.postMessage({ type, ...payload }, window.location.origin);
}

function requestSnapshot() {
  postCommand("sfpa-host:getSnapshot");
}

window.addEventListener("message", (event) => {
  if (event.origin !== window.location.origin) {
    return;
  }

  const data = event.data ?? {};
  if (data.type === "sfpa-app-ready") {
    setConnection(true);
    setStatus("Embedded app connected. Waiting for live state.");
    requestSnapshot();
    return;
  }

  if (data.type === "sfpa-app-snapshot") {
    setConnection(true);
    updateSnapshot(data.snapshot);
    return;
  }

  if (data.type === "sfpa-app-event") {
    setConnection(true);
    if (data.name === "save-cleared") {
      setStatus("Local save cleared. Waiting for the app to reload.");
    }
  }
});

frame?.addEventListener("load", () => {
  setStatus("Embedded app frame loaded. Probing the native app bridge.");
  setConnection(false);
  loadingOverlay.classList.remove("is-hidden");
  window.setTimeout(requestSnapshot, 500);
  window.setTimeout(requestSnapshot, 1500);
});

playFocusButton?.addEventListener("click", () => {
  frame?.focus();
});

fullscreenButton?.addEventListener("click", async () => {
  if (!document.fullscreenElement) {
    await frameShell?.requestFullscreen?.();
  } else {
    await document.exitFullscreen?.();
  }
});

reloadButton?.addEventListener("click", () => {
  frame?.contentWindow?.location.reload();
  setConnection(false);
  setStatus("Reloading the embedded app.");
});

clearSaveButton?.addEventListener("click", () => {
  postCommand("sfpa-host:clearSave");
  setStatus("Requesting local save clear from the embedded app.");
});

window.setInterval(() => {
  if (!bridgeState.connected) {
    requestSnapshot();
    return;
  }

  postCommand("sfpa-host:ping");
  requestSnapshot();
}, 2500);
