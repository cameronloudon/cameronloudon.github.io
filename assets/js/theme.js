/* ============================================
   cameronloudon.com — Theme Toggle
   Modes: light | dark | terminal
   ============================================ */

(function () {
  const STORAGE_KEY = 'cl-theme';
  const DEFAULT_THEME = 'light';

  // Get saved theme or default
  function getSavedTheme() {
    try {
      return localStorage.getItem(STORAGE_KEY) || DEFAULT_THEME;
    } catch (e) {
      return DEFAULT_THEME;
    }
  }

  // Apply theme to document
  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);

    // Update active button state
    document.querySelectorAll('.theme-btn').forEach(btn => {
      btn.classList.toggle('active', btn.dataset.mode === theme);
    });

    // Save preference
    try {
      localStorage.setItem(STORAGE_KEY, theme);
    } catch (e) {}
  }

  // Apply saved theme immediately (before paint) to avoid flash
  applyTheme(getSavedTheme());

  // Wire up buttons after DOM ready
  document.addEventListener('DOMContentLoaded', function () {
    applyTheme(getSavedTheme());

    document.querySelectorAll('.theme-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        applyTheme(this.dataset.mode);
      });
    });
  });
})();
