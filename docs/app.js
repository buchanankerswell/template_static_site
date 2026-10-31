/* TODO site logic. Shared theme + dialog wiring lives in the vendored
   dialogs.js: initTheme(".bar-side") and wireDialog("help", "help_btn"). */

const search = document.getElementById("search");
const help = wireDialog("help", "help_btn");

document.addEventListener("keydown", (e) => {
  if (e.key === "Escape" && help.isOpen) {
    help.close();
    return;
  }
  const tag = e.target.tagName;
  if (tag === "INPUT" || tag === "TEXTAREA" || tag === "SELECT" || e.target.isContentEditable) return;
  if (e.key === "/") {
    e.preventDefault();
    search.focus();
  }
  if (e.key === "?") {
    e.preventDefault();
    help.toggle();
  }
  // TODO: site shortcuts.
});

initTheme(".bar-side");
