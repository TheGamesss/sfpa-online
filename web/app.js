import { ACHIEVEMENTS } from "./achievements.js";

const STORAGE_KEY = "sfpa.browser.achievements.v1";
const achievementsById = new Map(ACHIEVEMENTS.map((achievement) => [achievement.id, achievement]));
const gameCover = document.querySelector("#game-cover");
const startGameButton = document.querySelector("#start-game");
const retryGameButton = document.querySelector("#retry-game");
const loadingNote = document.querySelector("#loading-note");
const loadError = document.querySelector("#load-error");
const playerHost = document.querySelector("#player-host");
const gameStatus = document.querySelector("#game-status");
const fullscreenButton = document.querySelector("#fullscreen-game");
const achievementGrid = document.querySelector("#achievement-grid");
const emptyResults = document.querySelector("#empty-results");
const searchInput = document.querySelector("#achievement-search");
const toast = document.querySelector("#unlock-toast");

let unlocked = readProgress();
let activeFilter = "all";
let toastTimer;
let player = null;
let gameLoadState = "idle";

function readProgress() {
  try {
    const stored = JSON.parse(localStorage.getItem(STORAGE_KEY) || "{}");
    return Object.fromEntries(
      Object.entries(stored).filter(([id, date]) => achievementsById.has(id) && typeof date === "string"),
    );
  } catch {
    return {};
  }
}

function saveProgress() {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(unlocked));
    document.body.classList.remove("storage-unavailable");
    return true;
  } catch (error) {
    document.body.classList.add("storage-unavailable");
    console.warn("SFPA browser achievements could not be saved.", error);
    return false;
  }
}

function unlockAchievement(id) {
  const achievement = achievementsById.get(String(id));
  if (!achievement) {
    console.warn("The game reported an unknown achievement.", id);
    return false;
  }
  if (unlocked[achievement.id]) return true;

  unlocked = { ...unlocked, [achievement.id]: new Date().toISOString() };
  saveProgress();
  renderAchievements();
  showToast(`${achievement.name} unlocked`);
  return true;
}

// Called from the web-patched SWF through Flash ExternalInterface.
window.sfpaUnlockAchievement = unlockAchievement;

function showToast(message) {
  toast.textContent = `✦  ${message}`;
  toast.hidden = false;
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => {
    toast.hidden = true;
  }, 3600);
}

function makeAchievementCard(achievement) {
  const unlockedAt = unlocked[achievement.id];
  const card = document.createElement("article");
  card.className = `achievement-card${unlockedAt ? " is-unlocked" : ""}`;

  const mark = document.createElement("span");
  mark.className = "achievement-mark";
  mark.setAttribute("aria-hidden", "true");
  mark.textContent = achievement.mark;

  const details = document.createElement("div");
  details.className = "achievement-details";

  const state = document.createElement("p");
  state.className = "achievement-state";
  state.textContent = unlockedAt ? "UNLOCKED" : "STILL OUT THERE";

  const title = document.createElement("h3");
  title.textContent = achievement.name;

  const description = document.createElement("p");
  description.className = "achievement-description";
  description.textContent = achievement.description;

  details.append(state, title, description);
  if (unlockedAt) {
    const date = new Date(unlockedAt);
    if (!Number.isNaN(date.valueOf())) {
      const unlockedDate = document.createElement("time");
      unlockedDate.className = "unlocked-date";
      unlockedDate.dateTime = date.toISOString();
      unlockedDate.textContent = `Found ${new Intl.DateTimeFormat(undefined, { dateStyle: "medium" }).format(date)}`;
      details.append(unlockedDate);
    }
  }

  card.append(mark, details);
  return card;
}

function renderAchievements() {
  const unlockedCount = Object.keys(unlocked).length;
  const lockedCount = ACHIEVEMENTS.length - unlockedCount;
  const query = searchInput.value.trim().toLocaleLowerCase();

  document.querySelector("#nav-count").textContent = `${unlockedCount} / ${ACHIEVEMENTS.length}`;
  document.querySelector("#progress-fraction").textContent = `${unlockedCount} / ${ACHIEVEMENTS.length}`;
  document.querySelector("#all-count").textContent = String(ACHIEVEMENTS.length);
  document.querySelector("#unlocked-count").textContent = String(unlockedCount);
  document.querySelector("#locked-count").textContent = String(lockedCount);
  document.querySelector("#progress-caption").textContent = unlockedCount === ACHIEVEMENTS.length
    ? "Every achievement. What a run."
    : unlockedCount === 0
      ? "All 16 achievements are still waiting."
      : `${lockedCount} more ${lockedCount === 1 ? "achievement" : "achievements"} to find.`;

  const progressTrack = document.querySelector("#progress-track");
  progressTrack.setAttribute("aria-valuenow", String(unlockedCount));
  document.querySelector("#progress-fill").style.width = `${(unlockedCount / ACHIEVEMENTS.length) * 100}%`;

  const filtered = ACHIEVEMENTS.filter((achievement) => {
    const isUnlocked = Boolean(unlocked[achievement.id]);
    const matchesFilter = activeFilter === "all"
      || (activeFilter === "unlocked" && isUnlocked)
      || (activeFilter === "locked" && !isUnlocked);
    const matchesSearch = `${achievement.name} ${achievement.description}`.toLocaleLowerCase().includes(query);
    return matchesFilter && matchesSearch;
  });

  achievementGrid.replaceChildren(...filtered.map(makeAchievementCard));
  emptyResults.hidden = filtered.length > 0;
}

function setView(view, updateLocation = true) {
  const nextView = view === "achievements" ? "achievements" : "play";
  document.querySelector("#play-view").hidden = nextView !== "play";
  document.querySelector("#achievements-view").hidden = nextView !== "achievements";

  for (const button of document.querySelectorAll("[data-view-target]")) {
    if (!button.classList.contains("nav-link")) continue;
    const selected = button.dataset.viewTarget === nextView;
    button.classList.toggle("is-active", selected);
    if (selected) button.setAttribute("aria-current", "page");
    else button.removeAttribute("aria-current");
  }

  if (updateLocation) history.replaceState(null, "", nextView === "achievements" ? "#achievements" : "#play");
  if (nextView === "achievements") renderAchievements();
}

async function launchGame() {
  if (gameLoadState === "loading" || gameLoadState === "loaded") return;
  gameLoadState = "loading";
  gameCover.classList.add("is-loading");
  startGameButton.hidden = true;
  loadingNote.hidden = false;
  loadError.hidden = true;
  gameStatus.innerHTML = '<span class="status-dot is-loading"></span> LOADING THE ADVENTURE';

  try {
    if (!window.RufflePlayer?.newest) throw new Error("The Ruffle player did not load.");
    const ruffle = window.RufflePlayer.newest();
    player = ruffle.createPlayer();
    player.className = "ruffle-player";
    player.setAttribute("aria-label", "Super Fancy Pants Adventure game");
    playerHost.replaceChildren(player);
    await player.ruffle().load("SFPA.swf");
    gameLoadState = "loaded";
    gameCover.hidden = true;
    gameStatus.innerHTML = '<span class="status-dot is-live"></span> ADVENTURE IN PROGRESS';
    player.focus();
  } catch (error) {
    console.error("The game failed to load.", error);
    gameLoadState = "error";
    loadingNote.hidden = true;
    loadError.hidden = false;
    gameCover.classList.remove("is-loading");
    gameStatus.innerHTML = '<span class="status-dot is-error"></span> READY WHEN YOU ARE';
  }
}

for (const button of document.querySelectorAll("[data-view-target]")) {
  button.addEventListener("click", () => {
    setView(button.dataset.viewTarget);
    if (button.hasAttribute("data-focus-game")) {
      document.querySelector("#game-stage").scrollIntoView({ behavior: "smooth", block: "center" });
      if (gameLoadState === "idle") startGameButton.focus({ preventScroll: true });
    }
  });
}

window.addEventListener("hashchange", () => {
  setView(window.location.hash === "#achievements" ? "achievements" : "play", false);
});

document.querySelectorAll("[data-filter]").forEach((button) => {
  button.addEventListener("click", () => {
    activeFilter = button.dataset.filter;
    document.querySelectorAll("[data-filter]").forEach((filterButton) => {
      const selected = filterButton === button;
      filterButton.classList.toggle("is-selected", selected);
      filterButton.setAttribute("aria-pressed", String(selected));
    });
    renderAchievements();
  });
});

searchInput.addEventListener("input", renderAchievements);
startGameButton.addEventListener("click", launchGame);
retryGameButton.addEventListener("click", launchGame);

document.querySelector("#reset-progress").addEventListener("click", () => {
  if (!window.confirm("Reset all browser achievements? This cannot be undone.")) return;
  unlocked = {};
  saveProgress();
  renderAchievements();
  showToast("Browser achievement progress reset");
});

fullscreenButton.addEventListener("click", async () => {
  try {
    if (document.fullscreenElement) await document.exitFullscreen();
    else await (player || document.querySelector("#game-stage")).requestFullscreen();
  } catch (error) {
    console.warn("Fullscreen is unavailable.", error);
  }
});

document.addEventListener("fullscreenchange", () => {
  const isFullscreen = Boolean(document.fullscreenElement);
  fullscreenButton.innerHTML = isFullscreen
    ? '<span aria-hidden="true">⛶</span> Exit fullscreen'
    : '<span aria-hidden="true">⛶</span> Fullscreen';
  fullscreenButton.setAttribute("aria-label", isFullscreen ? "Exit fullscreen" : "Enter fullscreen");
});

renderAchievements();
setView(window.location.hash === "#achievements" ? "achievements" : "play", false);
