
//=======// Disable unnecessary firefox bloat that clutters the UI //=======//

// Hide firefox view
user_pref("browser.tabs.firefox-view", false);

// Don't show suggested pages on about:home
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);

// Disable firefox pocket
user_pref("extensions.pocket.enabled", false);

// Always hide the booksmarks toolbar
user_pref("browser.toolbars.bookmarks.visibility", "never");

//=======// Other settings //=======//

// Don't ask to save logins and passwords for websites
user_pref("signon.rememberSignons", false);

// disable resuming session from crash
user_pref("browser.sessionstore.resume_from_crash", false);
