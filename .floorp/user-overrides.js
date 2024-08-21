/****************************************************************************************
 * OVERRIDES (BETTERFOX)
****************************************************************************************/
// PREF: preferred color scheme for websites and sub-pages
// Dark (0), Light (1), System (2), Browser (3)
user_pref("layout.css.prefers-color-scheme.content-override", 0);

// PREF: always ask where to download
// true = Direct download
// false = The user is asked what to do
user_pref("browser.download.useDownloadDir", false);

// PREF: remove sponsored content on New Tab page
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // Sponsored shortcuts 
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false); // Recommended by Pocket
user_pref("browser.newtabpage.activity-stream.showSponsored", false); // Sponsored Stories

// PREF: remove default Top Sites (Facebook, Twitter, etc.)
// [NOTE] This does not block you from adding your own.
user_pref("browser.newtabpage.activity-stream.default.sites", "");

// PREF: restore search engine suggestions
user_pref("browser.search.suggest.enabled", true);

/****************************************************************************************
 * OVERRIDES (ARKENFOX)
****************************************************************************************/
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.searches", true); // using kagi
user_perf("browser.urlbar.quicksuggest.enabled", true);
user_pref("browser.urlbar.suggest.engines", true);
user_pref("layout.css.visited_links_enabled", true); // enable visited links

/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 3); // 0102
  // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
  // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
user_pref("privacy.clearOnShutdown.history", false); // 2811 FF127 or lower
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128+

// 2820 optional to match when you use settings>Cookies and Site Data>Clear Data
  // user_pref("privacy.clearSiteData.historyFormDataAndDownloads", false); // FF128+

// 2830 optional to match when you use Ctrl-Shift-Del (settings>History>Custom Settings>Clear History)
  // user_pref("privacy.cpd.history", false); // FF127 or lower
  // user_pref("privacy.clearHistory.historyFormDataAndDownloads", false); // FF128+



