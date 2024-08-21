
/****************************************************************************************
 * Fastfox                                                                              *
 * "Non ducor duco"                                                                     *
 * priority: speedy browsing                                                            *
 * version: 128                                                                         *
 * url: https://github.com/yokoffing/Betterfox                                          *
 ***************************************************************************************/

/****************************************************************************
 * SECTION: GENERAL                                                        *
****************************************************************************/

// PREF: initial paint delay
// How long FF will wait before rendering the page (in ms)
// [NOTE] You may prefer using 250.
// [NOTE] Dark Reader users may want to use 1000 [3].
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1283302
// [2] https://docs.google.com/document/d/1BvCoZzk2_rNZx3u9ESPoFjSADRI0zIPeJRXFLwWXx_4/edit#heading=h.28ki6m8dg30z
// [3] https://old.reddit.com/r/firefox/comments/o0xl1q/reducing_cpu_usage_of_dark_reader_extension/
// [4] https://reddit.com/r/browsers/s/wvNB7UVCpx
//user_pref("nglayout.initialpaint.delay", 5); // DEFAULT; formerly 250
    //user_pref("nglayout.initialpaint.delay_in_oopif", 5); // DEFAULT

// PREF: page reflow timer
// Rather than wait until a page has completely downloaded to display it to the user,
// web browsers will periodically render what has been received to that point.
// Because reflowing the page every time additional data is received slows down
// total page load time, a timer was added so that the page would not reflow too often.
// This preference specfies whether that timer is active.
// [1] https://kb.mozillazine.org/Content.notify.ontimer
// true = do not reflow pages at an interval any higher than that specified by content.notify.interval (default)
// false = reflow pages whenever new data is received
//user_pref("content.notify.ontimer", true); // DEFAULT

// PREF: notification interval (in microseconds) to avoid layout thrashing
// When Firefox is loading a page, it periodically reformats
// or "reflows" the page as it loads. The page displays new elements
// every 0.12 seconds by default. These redraws increase the total page load time.
// The default value provides good incremental display of content
// without causing an increase in page load time.
// [NOTE] Lowering the interval will increase responsiveness
// but also increase the total load time.
// [WARNING] If this value is set below 1/10 of a second, it starts
// to impact page load performance.
// [EXAMPLE] 100000 = .10s = 100 reflows/second
// [1] https://searchfox.org/mozilla-central/rev/c1180ea13e73eb985a49b15c0d90e977a1aa919c/modules/libpref/init/StaticPrefList.yaml#1824-1834
// [2] https://dev.opera.com/articles/efficient-javascript/?page=3#reflow
// [3] https://dev.opera.com/articles/efficient-javascript/?page=3#smoothspeed
user_pref("content.notify.interval", 100000); // (.10s); default=120000 (.12s)

// PREF: new tab preload
// [WARNING] Disabling this may cause a delay when opening a new tab in Firefox.
// [1] https://wiki.mozilla.org/Tiles/Technical_Documentation#Ping
// [2] https://github.com/arkenfox/user.js/issues/1556
//user_pref("browser.newtab.preload", true); // DEFAULT

// PREF: disable EcoQoS [WINDOWS]
// Background tab processes use efficiency mode on Windows 11 to limit resource use.
// [WARNING] Leave this alone, unless you're on Desktop and you rely on
// background tabs to have maximum performance.
// [1] https://devblogs.microsoft.com/performance-diagnostics/introducing-ecoqos/
// [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1796525
// [3] https://bugzilla.mozilla.org/show_bug.cgi?id=1800412
// [4] https://reddit.com/r/firefox/comments/107fj69/how_can_i_disable_the_efficiency_mode_on_firefox/
//user_pref("dom.ipc.processPriorityManager.backgroundUsesEcoQoS", false);

// PREF: control how tabs are loaded when a session is restored
// true=Tabs are not loaded until they are selected (default)
// false=Tabs begin to load immediately.
//user_pref("browser.sessionstore.restore_on_demand", true); // DEFAULT
    //user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);
//user_pref("browser.sessionstore.restore_tabs_lazily", true); // DEFAULT

// PREF: disable preSkeletonUI on startup [WINDOWS]
//user_pref("browser.startup.preXulSkeletonUI", false);

// PREF: lazy load iframes
//user_pref("dom.iframe_lazy_loading.enabled", true); // DEFAULT [FF121+]

/****************************************************************************
 * SECTION: GFX RENDERING TWEAKS                                            *
****************************************************************************/

// PREF: Webrender tweaks
// [1] https://searchfox.org/mozilla-central/rev/6e6332bbd3dd6926acce3ce6d32664eab4f837e5/modules/libpref/init/StaticPrefList.yaml#6202-6219
// [2] https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/
// [3] https://www.reddit.com/r/firefox/comments/tbphok/is_setting_gfxwebrenderprecacheshaders_to_true/i0bxs2r/
// [4] https://www.reddit.com/r/firefox/comments/z5auzi/comment/ixw65gb?context=3
// [5] https://gist.github.com/RubenKelevra/fd66c2f856d703260ecdf0379c4f59db?permalink_comment_id=4532937#gistcomment-4532937
//user_pref("gfx.webrender.all", true); // enables WR + additional features
//user_pref("gfx.webrender.precache-shaders", true); // longer initial startup time
//user_pref("gfx.webrender.compositor", true); // DEFAULT WINDOWS macOS
    //user_pref("gfx.webrender.compositor.force-enabled", true); // enforce

// PREF: if your hardware doesn't support Webrender, you can fallback to Webrender's software renderer
// [1] https://www.ghacks.net/2020/12/14/how-to-find-out-if-webrender-is-enabled-in-firefox-and-how-to-enable-it-if-it-is-not/
//user_pref("gfx.webrender.software", true); // Software Webrender uses CPU instead of GPU
    //user_pref("gfx.webrender.software.opengl", true); // LINUX

// PREF: GPU-accelerated Canvas2D
// Use gpu-canvas instead of to skia-canvas.
// [WARNING] May cause issues on some Windows machines using integrated GPUs [2] [3]
// Add to your overrides if you have a dedicated GPU.
// [NOTE] Higher values will use more memory.
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1741501
// [2] https://github.com/yokoffing/Betterfox/issues/153
// [3] https://github.com/yokoffing/Betterfox/issues/198
//user_pref("gfx.canvas.accelerated", true); // DEFAULT macOS LINUX [FF110]; not compatible with WINDOWS integrated GPUs
    user_pref("gfx.canvas.accelerated.cache-items", 4096); // default=2048; alt=8192
    user_pref("gfx.canvas.accelerated.cache-size", 512); // default=256; alt=1024
    user_pref("gfx.content.skia-font-cache-size", 20); // default=5; Chrome=20
    // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1239151#c2

// PREF: prefer GPU over CPU
// At best, the prefs do nothing on Linux/macOS.
// At worst, it'll result in crashes if the sandboxing is a WIP.
// [1] https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#gpu-process
//user_pref("layers.gpu-process.enabled", true); // DEFAULT WINDOWS
    //user_pref("layers.gpu-process.force-enabled", true); // enforce
    //user_pref("layers.mlgpu.enabled", true); // LINUX
//user_pref("media.hardware-video-decoding.enabled", true); // DEFAULT WINDOWS macOS
    //user_pref("media.hardware-video-decoding.force-enabled", true); // enforce
//user_pref("media.gpu-process-decoder", true); // DEFAULT WINDOWS
//user_pref("media.ffmpeg.vaapi.enabled", true); // LINUX

// PREF: disable AV1 for hardware decodeable videos
// Firefox sometimes uses AV1 video decoding even to GPUs which do not support it.
// [1] https://www.reddit.com/r/AV1/comments/s5xyph/youtube_av1_codec_have_worse_quality_than_old_vp9
//user_pref("media.av1.enabled", false);

// PREF: hardware and software decoded video overlay [FF116+]
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1829063
// [2] https://phabricator.services.mozilla.com/D175993
//user_pref("gfx.webrender.dcomp-video-hw-overlay-win", true); // DEFAULT
    //user_pref("gfx.webrender.dcomp-video-hw-overlay-win-force-enabled", true); // enforce
//user_pref("gfx.webrender.dcomp-video-sw-overlay-win", true); // DEFAULT
    //user_pref("gfx.webrender.dcomp-video-sw-overlay-win-force-enabled", true); // enforce

/****************************************************************************
 * SECTION: DISK CACHE                                                     *
****************************************************************************/

// PREF: disk cache
// [NOTE] If you think it helps performance, then feel free to override this.
// [SETTINGS] See about:cache
// More efficient to keep the browser cache instead of having to
// re-download objects for the websites you visit frequently.
// [1] https://www.janbambas.cz/new-firefox-http-cache-enabled/
//user_pref("browser.cache.disk.enable", true); // DEFAULT

// PREF: disk cache size
// [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=913808,968106,968101
// [2] https://rockridge.hatenablog.com/entry/2014/09/15/165501
// [3] https://www.reddit.com/r/firefox/comments/17oqhw3/firefox_and_ssd_disk_consumption/
//user_pref("browser.cache.disk.smart_size.enabled", false); // force a fixed max cache size on disk
//user_pref("browser.cache.disk.capacity", 512000); // default=256000; size of disk cache; 1024000=1GB, 2048000=2GB
//user_pref("browser.cache.disk.max_entry_size", 51200); // DEFAULT (50 MB); maximum size of an object in disk cache

// PREF: Race Cache With Network (RCWN) [FF59+]
// [ABOUT] about:networking#rcwn
// Firefox concurrently sends requests for cached resources to both the
// local disk cache and the network server. The browser uses whichever
// result arrives first and cancels the other request. This approach sometimes
// loads pages faster because the network can be quicker than accessing the cache
// on a hard drive. When RCWN is enabled, the request might be served from
// the server even if you have valid entry in the cache. Set to false if your
// intention is to increase cache usage and reduce network usage.
// [1] https://slides.com/valentingosu/race-cache-with-network-2017
// [2] https://simonhearne.com/2020/network-faster-than-cache/
// [3] https://support.mozilla.org/en-US/questions/1267945
// [4] https://askubuntu.com/questions/1214862/36-syns-in-a-row-how-to-limit-firefox-connections-to-one-website
// [5] https://bugzilla.mozilla.org/show_bug.cgi?id=1622859
//user_pref("network.http.rcwn.enabled", true); // DEFAULT

// PREF: attempt to RCWN only if a resource is smaller than this size
//user_pref("network.http.rcwn.small_resource_size_kb", 256); // DEFAULT

// PREF: cache memory pool
// Cache v2 provides a memory pool that stores metadata (such as response headers)
// for recently read cache entries [1]. It is managed by a cache thread, and caches with
// metadata in the pool appear to be reused immediately.
// [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=986179
//user_pref("browser.cache.disk.metadata_memory_limit", 500); // default=250 (0.25 MB); limit of recent metadata we keep in memory for faster access

// PREF: number of chunks we preload ahead of read
// Large content such as images will load faster.
// [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=913819,988318
// [2] http://www.janbambas.cz/new-firefox-http-cache-enabled/
//user_pref("browser.cache.disk.preload_chunk_count", 4); // DEFAULT

// PREF: the time period used to re-compute the frecency value of cache entries
// The frequency algorithm is used to select entries, and entries that are recently
// saved or frequently reused are retained. The frecency value determines how
// frequently a page has been accessed and is used by Firefox's cache algorithm.
// The frequency algorithm is used to select entries, and entries that are recently
// saved or frequently reused are retained. The frecency value determines how
// often a page has been accessed and is used by Firefox's cache algorithm.
// When the memory pool becomes full, the oldest data is purged. By default,
// data older than 6 hours is treated as old.
// [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=942835,1012327
// [2] https://bugzilla.mozilla.org/buglist.cgi?bug_id=913808,968101
//user_pref("browser.cache.frecency_half_life_hours", 6); // DEFAULT

// PREF: memory limit (in kB) for new cache data not yet written to disk
// Writes to the cache are buffered and written to disk on background with low priority.
// With a slow persistent storage, these buffers may grow when data is coming
// fast from the network. When the amount of unwritten data is exceeded, new
// writes will simply fail. We have two buckets, one for important data
// (priority) like html, css, fonts and js, and one for other data like images, video, etc.
//user_pref("browser.cache.disk.max_chunks_memory_usage", 40960); // DEFAULT (40 MB)
//user_pref("browser.cache.disk.max_priority_chunks_memory_usage", 40960); // DEFAULT (40 MB)

// PREF: how often to validate document in cache
// [1] https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#1092-1096
// 0 = once-per-session
// 3 = when-appropriate/automatically (default)
//user_pref("browser.cache.check_doc_frequency", 3); // DEFAULT

// PREF: enforce free space checks
// When smartsizing is disabled, we could potentially fill all disk space by
// cache data when the disk capacity is not set correctly. To avoid that, we
// check the free space every time we write some data to the cache. The free
// space is checked against two limits. Once the soft limit is reached we start
// evicting the least useful entries, when we reach the hard limit writing to
// the entry fails.
//user_pref("browser.cache.disk.free_space_soft_limit", 10240); // default=5120 (5 MB)
//user_pref("browser.cache.disk.free_space_hard_limit", 2048); // default=1024 (1 MB)

// PREF: compression level for cached JavaScript bytecode [FF102+]
// [1] https://github.com/yokoffing/Betterfox/issues/247
// 0 = do not compress (default)
// 1 = minimal compression
// 9 = maximal compression
user_pref("browser.cache.jsbc_compression_level", 3);

// PREF: strategy to use for when the bytecode should be encoded and saved [TESTING ONLY]
// -1 makes page load times marginally longer when a page is being loaded for the first time.
// Subsequent reload of websites will be much much faster.
// [1] https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#3461-3488
// [2] https://www.reddit.com/r/firefox/comments/12786yv/improving_performance_in_firefox_android_part_ii/
// -1 = saved as soon as the script is seen for the first time, independently of the size or last access time
// 0 = saved in order to minimize the page-load time (default)
//user_pref("dom.script_loader.bytecode_cache.enabled", true); // DEFAULT
//user_pref("dom.script_loader.bytecode_cache.strategy", 0); // DEFAULT

/****************************************************************************
 * SECTION: MEMORY CACHE                                                   *
****************************************************************************/

// PREF: memory cache
// The "automatic" size selection (default) is based on a decade-old table
// that only contains settings for systems at or below 8GB of system memory [1].
// Waterfox G6 allows it to go above 8GB machines [3].
// Value can be up to the max size of an unsigned 64-bit integer.
// -1=Automatically decide the maximum memory to use to cache decoded images,
// messages, and chrome based on the total amount of RAM
// [1] https://kb.mozillazine.org/Browser.cache.memory.capacity#-1
// [2] https://searchfox.org/mozilla-central/source/netwerk/cache2/CacheObserver.cpp#94-125
// [3] https://github.com/WaterfoxCo/Waterfox/commit/3fed16932c80a2f6b37d126fe10aed66c7f1c214
//user_pref("browser.cache.memory.capacity", -1); // DEFAULT; 256000=256 MB; 512000=500 MB; 1048576=1GB, 2097152=2GB
//user_pref("browser.cache.memory.max_entry_size", 10240); // (10 MB); default=5120 (5 MB)

// PREF: amount of Back/Forward cached pages stored in memory for each tab
// Pages that were recently visited are stored in memory in such a way
// that they don't have to be re-parsed. This improves performance
// when pressing Back and Forward. This pref limits the maximum
// number of pages stored in memory. If you are not using the Back
// and Forward buttons that much, but rather using tabs, then there
// is no reason for Firefox to keep memory for this.
// -1=determine automatically (8 pages)
// [1] https://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers#Possible_values_and_their_effects
//user_pref("browser.sessionhistory.max_total_viewers", 4);

/****************************************************************************
 * SECTION: MEDIA CACHE                                                     *
****************************************************************************/

// PREF: media disk cache
//user_pref("media.cache_size", 512000); // DEFAULT

// PREF: media memory cache
// [1] https://hg.mozilla.org/mozilla-central/file/tip/modules/libpref/init/StaticPrefList.yaml#l9652
// [2] https://github.com/arkenfox/user.js/pull/941
user_pref("media.memory_cache_max_size", 65536); // default=8192; AF=65536; alt=131072
//user_pref("media.memory_caches_combined_limit_kb", 524288); // DEFAULT; alt=1048576
//user_pref("media.memory_caches_combined_limit_pc_sysmem", 5); // DEFAULT; alt=10; the percentage of system memory that Firefox can use for media caches

// PREF: Media Source Extensions (MSE) web standard
// Disabling MSE allows videos to fully buffer, but you're limited to 720p.
// [WARNING] Disabling MSE may break certain videos.
// false=Firefox plays the old WebM format
// true=Firefox plays the new WebM format (default)
// [1] https://support.mozilla.org/en-US/questions/1008271
//user_pref("media.mediasource.enabled", true); // DEFAULT

// PREF: adjust video buffering periods when not using MSE (in seconds)
// [NOTE] Does not affect videos over 720p since they use DASH playback [1]
// [1] https://lifehacker.com/preload-entire-youtube-videos-by-disabling-dash-playbac-1186454034
user_pref("media.cache_readahead_limit", 7200); // 120 min; default=60; stop reading ahead when our buffered data is this many seconds ahead of the current playback
user_pref("media.cache_resume_threshold", 3600); // 60 min; default=30; when a network connection is suspended, don't resume it until the amount of buffered data falls below this threshold

/****************************************************************************
 * SECTION: IMAGE CACHE                                                     *
****************************************************************************/

// PREF: image cache
//user_pref("image.cache.size", 5242880); // DEFAULT; in MiB; alt=10485760 (cache images up to 10MiB in size)
user_pref("image.mem.decode_bytes_at_a_time", 32768); // default=16384; alt=65536; chunk size for calls to the image decoders

// PREF: set minimum timeout to unmap shared surfaces since they have been last used
// This is only used on 32-bit builds of Firefox where there is meaningful
// virtual address space pressure.
// [1] https://phabricator.services.mozilla.com/D109440
// [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1699224
//user_pref("image.mem.shared.unmap.min_expiration_ms", 120000); // default=60000; minimum timeout to unmap shared surfaces since they have been last used

/****************************************************************************
 * SECTION: NETWORK                                                         *
****************************************************************************/

// PREF: use bigger packets
// [WARNING] Cannot open HTML files bigger than 4MB if changed [2].
// Reduce Firefox's CPU usage by requiring fewer application-to-driver data transfers.
// However, it does not affect the actual packet sizes transmitted over the network.
// [1] https://www.mail-archive.com/support-seamonkey@lists.mozilla.org/msg74561.html
// [2] https://github.com/yokoffing/Betterfox/issues/279
//user_pref("network.buffer.cache.size", 262144); // 256 kb; default=32768 (32 kb)
//user_pref("network.buffer.cache.count", 128); // default=24

// PREF: increase the absolute number of HTTP connections
// [1] https://kb.mozillazine.org/Network.http.max-connections
// [2] https://kb.mozillazine.org/Network.http.max-persistent-connections-per-server
// [3] https://www.reddit.com/r/firefox/comments/11m2yuh/how_do_i_make_firefox_use_more_of_my_900_megabit/jbfmru6/
user_pref("network.http.max-connections", 1800); // default=900
user_pref("network.http.max-persistent-connections-per-server", 10); // default=6; download connections; anything above 10 is excessive
    user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // default=3
    //user_pref("network.http.max-persistent-connections-per-proxy", 48); // default=32
//user_pref("network.websocket.max-connections", 200); // DEFAULT

// PREF: pacing requests [FF23+]
// Controls how many HTTP requests are sent at a time.
// Pacing HTTP requests can have some benefits, such as reducing network congestion,
// improving web page loading speed, and avoiding server overload.
// Pacing requests adds a slight delay between requests to throttle them.
// If you have a fast machine and internet connection, disabling pacing
// may provide a small speed boost when loading pages with lots of requests.
// false=Firefox will send as many requests as possible without pacing
// true=Firefox will pace requests (default)
user_pref("network.http.pacing.requests.enabled", false);
    //user_pref("network.http.pacing.requests.min-parallelism", 10); // default=6
    //user_pref("network.http.pacing.requests.burst", 14); // default=10

// PREF: increase DNS cache
// [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Understanding_latency
//user_pref("network.dnsCacheEntries", 1000); // default=400

// PREF: adjust DNS expiration time
// [ABOUT] about:networking#dns
// [NOTE] These prefs will be ignored by DNS resolver if using DoH/TRR.
user_pref("network.dnsCacheExpiration", 3600); // keep entries for 1 hour
    //user_pref("network.dnsCacheExpirationGracePeriod", 240); // default=60; cache DNS entries for 4 minutes after they expire

// PREF: the number of threads for DNS
//user_pref("network.dns.max_high_priority_threads", 40); // DEFAULT [FF 123?]
//user_pref("network.dns.max_any_priority_threads", 24); // DEFAULT [FF 123?]

// PREF: increase TLS token caching 
user_pref("network.ssl_tokens_cache_capacity", 10240); // default=2048; more TLS token caching (fast reconnects)

/****************************************************************************
 * SECTION: SPECULATIVE LOADING                                            *
****************************************************************************/

// These are connections that are not explicitly asked for (e.g., clicked on).
// [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Speculative_loading

// [NOTE] FF85+ partitions (isolates) pooled connections, prefetch connections,
// pre-connect connections, speculative connections, TLS session identifiers,
// and other connections. We can take advantage of the speed of pre-connections
// while preserving privacy. Users may relax hardening to maximize their preference.
// For more information, see SecureFox: "PREF: State Paritioning" and "PREF: Network Partitioning".
// [NOTE] To activate and increase network predictions, go to settings in uBlock Origin and uncheck:
// - "Disable pre-fetching (to prevent any connection for blocked network requests)"
// [NOTE] Add prefs to "MY OVERRIDES" section and uncomment to enable them in your user.js.

// PREF: link-mouseover opening connection to linked server
// When accessing content online, devices use sockets as endpoints.
// The global limit on half-open sockets controls how many speculative
// connection attempts can occur at once when starting new connections [3].
// If the user follows through, pages can load faster since some
// work was done in advance. Firefox opens predictive connections
// to sites when hovering over New Tab thumbnails or starting a
// URL Bar search [1] and hyperlinks within a page [2].
// [NOTE] DNS (if enabled), TCP, and SSL handshakes are set up in advance,
// but page contents are not downloaded until a click on the link is registered.
// [1] https://support.mozilla.org/en-US/kb/how-stop-firefox-making-automatic-connections?redirectslug=how-stop-firefox-automatically-making-connections&redirectlocale=en-US#:~:text=Speculative%20pre%2Dconnections
// [2] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
// [3] https://searchfox.org/mozilla-central/rev/028c68d5f32df54bca4cf96376f79e48dfafdf08/modules/libpref/init/all.js#1280-1282
// [4] https://www.keycdn.com/blog/resource-hints#prefetch
// [5] https://3perf.com/blog/link-rels/#prefetch
//user_pref("network.http.speculative-parallel-limit", 20); // DEFAULT (FF127+?)

// PREF: DNS prefetching for HTMLLinkElement <link rel="dns-prefetch">
// Used for cross-origin connections to provide small performance improvements.
// You can enable rel=dns-prefetch for the HTTPS document without prefetching
// DNS for anchors, whereas the latter makes more specualtive requests [5].
// [1] https://bitsup.blogspot.com/2008/11/dns-prefetching-for-firefox.html
// [2] https://css-tricks.com/prefetching-preloading-prebrowsing/#dns-prefetching
// [3] https://www.keycdn.com/blog/resource-hints#2-dns-prefetching
// [4] http://www.mecs-press.org/ijieeb/ijieeb-v7-n5/IJIEEB-V7-N5-2.pdf
// [5] https://bugzilla.mozilla.org/show_bug.cgi?id=1596935#c28
user_pref("network.dns.disablePrefetch", true);
    user_pref("network.dns.disablePrefetchFromHTTPS", true); // [FF127+ false]

// PREF:  DNS prefetch for HTMLAnchorElement (speculative DNS)
// Disable speculative DNS calls to prevent Firefox from resolving
// hostnames for other domains linked on a page. This may eliminate
// unnecessary DNS lookups, but can increase latency when following external links.
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1596935#c28
// [2] https://github.com/arkenfox/user.js/issues/1870#issuecomment-2220773972
//user_pref("dom.prefetch_dns_for_anchor_http_document", false); // [FF128+]
//user_pref("dom.prefetch_dns_for_anchor_https_document", false); // DEFAULT [FF128+]

// PREF: enable <link rel="preconnect"> tag and Link: rel=preconnect response header handling
//user_pref("network.preconnect", true); // DEFAULT

// PREF: preconnect to the autocomplete URL in the address bar
// Whether to warm up network connections for autofill or search results.
// Firefox preloads URLs that autocomplete when a user types into the address bar.
// Connects to destination server ahead of time, to avoid TCP handshake latency.
// [NOTE] Firefox will perform DNS lookup (if enabled) and TCP and TLS handshake,
// but will not start sending or receiving HTTP data.
// [1] https://www.ghacks.net/2017/07/24/disable-preloading-firefox-autocomplete-urls/
//user_pref("browser.urlbar.speculativeConnect.enabled", false);

// PREF: mousedown speculative connections on bookmarks and history [FF98+]
// Whether to warm up network connections for places:menus and places:toolbar.
//user_pref("browser.places.speculativeConnect.enabled", false);

// PREF: network module preload <link rel="modulepreload"> [FF115+]
// High-priority loading of current page JavaScript modules.
// Used to preload high-priority JavaScript modules for strategic performance improvements.
// Module preloading allows developers to fetch JavaScript modules and dependencies
// earlier to accelerate page loads. The browser downloads, parses, and compiles modules
// referenced by links with this attribute in parallel with other resources, rather
// than sequentially waiting to process each. Preloading reduces overall download times.
// Browsers may also automatically preload dependencies without firing extra events.
// Unlike other pre-connection tags (except rel=preload), this tag is mandatory for the browser.
// [1] https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel/modulepreload
//user_pref("network.modulepreload", true); // DEFAULT

// PREF: link prefetching <link rel="prefetch">
// Pre-populates the HTTP cache by prefetching same-site future navigation
// resources or subresources used on those pages.
// Enabling link prefetching allows Firefox to preload pages tagged as important.
// The browser prefetches links with the prefetch-link tag, fetching resources
// likely needed for the next navigation at low priority. When clicking a link
// or loading a new page, prefetching stops and discards hints. Prefetching
// downloads resources without executing them.
// [NOTE] Since link prefetch uses the HTTP cache, it has a number of issues
// with document prefetches, such as being potentially blocked by Cache-Control headers
// (e.g. cache partitioning).
// [1] https://developer.mozilla.org/en-US/docs/Glossary/Prefetch
// [2] http://www.mecs-press.org/ijieeb/ijieeb-v7-n5/IJIEEB-V7-N5-2.pdf
// [3] https://timkadlec.com/remembers/2020-06-17-prefetching-at-this-age/
// [4] https://3perf.com/blog/link-rels/#prefetch
// [5] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ
user_pref("network.prefetch-next", false);

// PREF: Fetch Priority API [FF119+]
// Indicates whether the `fetchpriority` attribute for elements which support it.
// [1] https://web.dev/articles/fetch-priority
// [2] https://nitropack.io/blog/post/priority-hints
// [2] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/fetchPriority
// [3] https://developer.mozilla.org/en-US/docs/Web/API/HTMLLinkElement/fetchPriority
//user_pref("network.fetchpriority.enabled", true);

// PREF: early hints [FF120+]
// [1] https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/103
// [2] https://developer.chrome.com/blog/early-hints/
// [3] https://blog.cloudflare.com/early-hints/
// [4] https://blog.cloudflare.com/early-hints-performance/
//user_pref("network.early-hints.enabled", true);

// PREF: `Link: rel=preconnect` in 103 Early Hint response [FF120+]
// Used to warm most critical cross-origin connections to provide
// performance improvements when connecting to them.
// [NOTE] When 0, this is limited by "network.http.speculative-parallel-limit".
//user_pref("network.early-hints.preconnect.enabled", true);
//user_pref("network.early-hints.preconnect.max_connections", 10); // DEFAULT

// PREF: Network Predictor (NP)
// When enabled, it trains and uses Firefox's algorithm to preload page resource
// by tracking past page resources. It uses a local file (history) of needed images,
// scripts, etc. to request them preemptively when navigating.
// [NOTE] By default, it only preconnects, doing DNS, TCP, and SSL handshakes.
// No data sends until clicking. With "network.predictor.enable-prefetch" enabled,
// it also performs prefetches.
// [1] https://wiki.mozilla.org/Privacy/Reviews/Necko
// [2] https://www.ghacks.net/2014/05/11/seer-disable-firefox/
// [3] https://github.com/dillbyrne/random-agent-spoofer/issues/238#issuecomment-110214518
// [4] https://www.igvita.com/posa/high-performance-networking-in-google-chrome/#predictor
user_pref("network.predictor.enabled", false);

// PREF: Network Predictor fetch for resources ahead of time
// Prefetch page resources based on past user behavior.
//user_pref("network.predictor.enable-prefetch", false); // DEFAULT

// PREF: make Network Predictor active when hovering over links
// When hovering over links, Network Predictor uses past resource history to
// preemptively request what will likely be needed instead of waiting for the document.
// Predictive connections automatically open when hovering over links to speed up
// loading, starting some work in advance.
//user_pref("network.predictor.enable-hover-on-ssl", false); // DEFAULT

// PREF: assign Network Predictor confidence levels
// [NOTE] Keep in mind that Network Predictor must LEARN your browsing habits.
// Editing these lower will cause more speculative connections to occur,
// which reduces accuracy over time and has privacy implications.
//user_pref("network.predictor.preresolve-min-confidence", 60); // DEFAULT
//user_pref("network.predictor.preconnect-min-confidence", 90); // DEFAULT
//user_pref("network.predictor.prefetch-min-confidence", 100); // DEFAULT

// PREF: other Network Predictor values
// [NOTE] Keep in mmind that Network Predictor must LEARN your browsing habits.
//user_pref("network.predictor.prefetch-force-valid-for", 10); // DEFAULT; how long prefetched resources are considered valid and usable (in seconds) for the prediction modeling
//user_pref("network.predictor.prefetch-rolling-load-count", 10); // DEFAULT; the maximum number of resources that Firefox will prefetch in memory at one time based on prediction modeling
//user_pref("network.predictor.max-resources-per-entry", 250); // default=100
//user_pref("network.predictor.max-uri-length", 1000); // default=500

/****************************************************************************
 * SECTION: EXPERIMENTAL                                                    *
****************************************************************************/

// PREF: CSS Masonry Layout [NIGHTLY]
// [1] https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Masonry_Layout
user_pref("layout.css.grid-template-masonry-value.enabled", true);

// PREF: Prioritized Task Scheduling API [NIGHTLY]
// [1] https://blog.mozilla.org/performance/2022/06/02/prioritized-task-scheduling-api-is-prototyped-in-nightly/
// [2] https://medium.com/airbnb-engineering/building-a-faster-web-experience-with-the-posttask-scheduler-276b83454e91
user_pref("dom.enable_web_task_scheduling", true);

// PREF: HTML Sanitizer API [NIGHTLY]
// [1] https://developer.mozilla.org/en-US/docs/Web/API/Sanitizer
// [2] https://caniuse.com/mdn-api_sanitizer
user_pref("dom.security.sanitizer.enabled", true);

// PREF: WebGPU [HIGHLY EXPERIMENTAL!]
// [WARNING] Do not enable unless you are a web developer!
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1746245
// [2] https://developer.chrome.com/docs/web-platform/webgpu/
// [3] https://github.com/gpuweb/gpuweb/wiki/Implementation-Status
// [4] https://hacks.mozilla.org/2020/04/experimental-webgpu-in-firefox/
//user_pref("dom.webgpu.enabled", true);
    //user_pref("gfx.webgpu.force-enabled", true); // enforce
// enable WebGPU indirect draws/dispatches:
//user_pref("dom.webgpu.indirect-dispatch.enabled", true);

/****************************************************************************
 * SECTION: TAB UNLOAD                                                      *
****************************************************************************/

// PREF: unload tabs on low memory
// [ABOUT] about:unloads
// Firefox will detect if your computer’s memory is running low (less than 200MB)
// and suspend tabs that you have not used in awhile.
// [1] https://support.mozilla.org/en-US/kb/unload-inactive-tabs-save-system-memory-firefox
// [2] https://hacks.mozilla.org/2021/10/tab-unloading-in-firefox-93/
//user_pref("browser.tabs.unloadOnLowMemory", true); // DEFAULT

// PREF: determine when tabs unload [WINDOWS] [LINUX]
// Notify TabUnloader or send the memory pressure if the memory resource
// notification is signaled AND the available commit space is lower than
// this value.
// Set this to some high value, e.g. 2/3 of total memory available in your system:
// 4GB=2640, 8GB=5280, 16GB=10560, 32GB=21120, 64GB=42240
// [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
//user_pref("browser.low_commit_space_threshold_mb", 2640); // default=200; WINDOWS LINUX

// PREF: determine when tabs unload [LINUX]
// On Linux, Firefox checks available memory in comparison to total memory,
// and use this percent value (out of 100) to determine if Firefox is in a
// low memory scenario.
// [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
//user_pref("browser.low_commit_space_threshold_percent", 33); // default=5; LINUX

// PREF: determine how long (in ms) tabs are inactive before they unload
// 60000=1min; 300000=5min; 600000=10min (default)
//user_pref("browser.tabs.min_inactive_duration_before_unload", 300000); // 5min; default=600000

/****************************************************************************
 * SECTION: PROCESS COUNT                                                  *
****************************************************************************/

// PREF: process count
// [ABOUT] View in about:processes.
// With Firefox Quantum (2017), CPU cores = processCount. However, since the
// introduction of Fission [2], the number of website processes is controlled
// by processCount.webIsolated. Disabling fission.autostart or changing
// fission.webContentIsolationStrategy reverts control back to processCount.
// [1] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/
// [2] https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#web-content-processes 
//user_pref("dom.ipc.processCount", 8); // DEFAULT; Shared Web Content
//user_pref("dom.ipc.processCount.webIsolated", 1); // default=4; Isolated Web Content

// PREF: use one process for process preallocation cache
//user_pref("dom.ipc.processPrelaunch.fission.number", 1); // default=3; Process Preallocation Cache

// PREF: configure process isolation
// [1] https://hg.mozilla.org/mozilla-central/file/tip/dom/ipc/ProcessIsolation.cpp#l53
// [2] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/

// OPTION 1: isolate all websites
// Web content is always isolated into its own `webIsolated` content process
// based on site-origin, and will only load in a shared `web` content process
// if site-origin could not be determined.
//user_pref("fission.webContentIsolationStrategy", 1); // DEFAULT
//user_pref("browser.preferences.defaultPerformanceSettings.enabled", true); // DEFAULT
    //user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin

// OPTION 2: isolate only "high value" websites
// Only isolates web content loaded by sites which are considered "high
// value". A site is considered high value if it has been granted a
// `highValue*` permission by the permission manager, which is done in
// response to certain actions.
//user_pref("fission.webContentIsolationStrategy", 2);
//user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
    //user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin (high value)
    //user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors

// OPTION 3: do not isolate websites
// All web content is loaded into a shared `web` content process. This is
// similar to the non-Fission behavior; however, remote subframes may still
// be used for sites with special isolation behavior, such as extension or
// mozillaweb content processes.
//user_pref("fission.webContentIsolationStrategy", 0);
//user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
    //user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors

/****************************************************************************
 * Peskyfox                                                                 *
 * "Aquila non capit muscas"                                                *
 * priority: remove annoyances                                              *
 * version: 128.1                                                           *
 * url: https://github.com/yokoffing/Betterfox                              *
 * credit: Some prefs are reproduced and adapted from the arkenfox project  *
 * credit urL: https://github.com/arkenfox/user.js                          *
 ***************************************************************************/

/****************************************************************************
 * SECTION: MOZILLA UI                                                      *
****************************************************************************/

// PREF: Mozilla VPN
// [1] https://github.com/yokoffing/Betterfox/issues/169
user_pref("browser.privatebrowsing.vpnpromourl", "");
    //user_pref("browser.vpn_promo.enabled", false);

// PREF: disable about:addons' Recommendations pane (uses Google Analytics)
user_pref("extensions.getAddons.showPane", false); // HIDDEN

// PREF: disable recommendations in about:addons' Extensions and Themes panes
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

// PREF: Personalized Extension Recommendations in about:addons and AMO
// [NOTE] This pref has no effect when Health Reports are disabled.
// [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to make personalized extension recommendations
user_pref("browser.discovery.enabled", false);

// PREF: disable Fakespot integration [FF116+]
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1840156#c0
// [2] https://github.com/arkenfox/user.js/issues/1730
// [3] https://www.fakespot.com/
// [4] https://www.ghacks.net/2023/10/12/firefox-will-soon-tell-you-if-product-reviews-are-reliable/
//user_pref("browser.shopping.experience2023.enabled", false); // DEFAULT
//user_pref("browser.shopping.experience2023.ads.exposure", false); // DEFAULT [FF121+]

// PREF: disable Firefox from asking to set as the default browser
// [1] https://github.com/yokoffing/Betterfox/issues/166
user_pref("browser.shell.checkDefaultBrowser", false);

// PREF: disable Extension Recommendations (CFR: "Contextual Feature Recommender")
// [1] https://support.mozilla.org/en-US/kb/extension-recommendations
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// PREF: hide "More from Mozilla" in Settings
user_pref("browser.preferences.moreFromMozilla", false);

// PREF: tab and about:config warnings
//user_pref("browser.tabs.warnOnClose", false); // DEFAULT [FF94+]
//user_pref("browser.tabs.warnOnCloseOtherTabs", true); // DEFAULT
//user_pref("browser.tabs.warnOnOpen", true); // DEFAULT
user_pref("browser.aboutConfig.showWarning", false);

// PREF: disable welcome notices
//user_pref("browser.startup.homepage_override.mstone", "ignore"); // What's New page after updates; master switch
user_pref("browser.aboutwelcome.enabled", false); // disable Intro screens
    //user_pref("startup.homepage_welcome_url", "");
    //user_pref("startup.homepage_welcome_url.additional", "");
    //user_pref("startup.homepage_override_url", ""); // What's New page after updates

// PREF: disable "What's New" toolbar icon [FF69+]
//user_pref("browser.messaging-system.whatsNewPanel.enabled", false);

// PREF: only show List All Tabs icon when needed
// true=always show tab overflow dropdown (FF106+ default)
// false=only display tab dropdown when there are too many tabs
// [1] https://www.ghacks.net/2022/10/19/how-to-hide-firefoxs-list-all-tabs-icon/
user_pref("browser.tabs.tabmanager.enabled", false);

// PREF: enable new screenshot tool [FF122+]
//user_pref("screenshots.browser.component.enabled", true);

/****************************************************************************
 * SECTION: THEME ADJUSTMENTS                                              *
****************************************************************************/

// PREF: enable Firefox to use userChome, userContent, etc.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// PREF: add compact mode back to options
user_pref("browser.compactmode.show", true);

// PREF: remove focus indicator for links
// [1] https://www.askvg.com/firefox-tip-restore-classic-dotted-outline-focus-indicator-for-links/
user_pref("browser.display.focus_ring_on_anything", true); 
user_pref("browser.display.focus_ring_style", 0);
user_pref("browser.display.focus_ring_width", 0);

// PREF: preferred color scheme for websites
// [SETTING] General>Language and Appearance>Website appearance
// By default, color scheme matches the theme of your browser toolbar (3).
// Set this pref to choose Dark on sites that support it (0) or Light (1).
// Before FF95, the pref was 2, which determined site color based on OS theme.
// Dark (0), Light (1), System (2), Browser (3) [DEFAULT FF95+]
// [1] https://www.reddit.com/r/firefox/comments/rfj6yc/how_to_stop_firefoxs_dark_theme_from_overriding/hoe82i5/?context=3
user_pref("layout.css.prefers-color-scheme.content-override", 2);

// PREF: disable always using dark theme for private browsing windows [FF106+]
//user_pref("browser.theme.dark-private-windows", false);

// PREF: prevent private windows being separate from normal windows in taskbar [WINDOWS] [FF106+]
user_pref("browser.privateWindowSeparation.enabled", false);

// PREF: show search bar [FF122+]
// Mozilla has removed the search bar option from the settings window.
//user_pref("browser.search.widget.inNavBar", true);

/****************************************************************************
 * SECTION: COOKIE BANNER HANDLING                                         *
****************************************************************************/

// PREF: Cookie Banner handling
// [NOTE] Feature still enforces Total Cookie Protection to limit 3rd-party cookie tracking [1]
// [1] https://github.com/mozilla/cookie-banner-rules-list/issues/33#issuecomment-1318460084
// [2] https://phabricator.services.mozilla.com/D153642
// [3] https://winaero.com/make-firefox-automatically-click-on-reject-all-in-cookie-banner-consent/
// [4] https://docs.google.com/spreadsheets/d/1Nb4gVlGadyxix4i4FBDnOeT_eJp2Zcv69o-KfHtK-aA/edit#gid=0
// 2: reject banners if it is a one-click option; otherwise, fall back to the accept button to remove banner
// 1: reject banners if it is a one-click option; otherwise, keep banners on screen
// 0: disable all cookie banner handling
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.service.mode.privateBrowsing", 1);

// PREF: Cookie Banner global rules
// Global rules that can handle a list of cookie banner libraries and providers on any site.
// This is used for click rules that can handle common Consent Management Providers (CMP).
//user_pref("cookiebanners.service.enableGlobalRules", true); // DEFAULT [FF121+]
//user_pref("cookiebanners.service.enableGlobalRules.subFrames", true); // DEFAULT [FF121+]

/****************************************************************************
 * SECTION: TRANSLATIONS                                                   *
****************************************************************************/

// PREF: Firefox Translations [FF118+]
// Automated translation of web content is done locally in Firefox, so that
// the text being translated does not leave your machine.
// [ABOUT] Visit about:translations to translate your own text as well.
// [1] https://blog.mozilla.org/en/mozilla/local-translation-add-on-project-bergamot/
// [2] https://blog.nightly.mozilla.org/2023/06/01/firefox-translations-and-other-innovations-these-weeks-in-firefox-issue-139/
// [3] https://www.ghacks.net/2023/08/02/mozilla-firefox-117-beta-brings-an-automatic-language-translator-for-websites-and-it-works-offline/
//user_pref("browser.translations.enable", true); // DEFAULT
    //user_pref("browser.translations.autoTranslate", true);

/****************************************************************************
 * SECTION: FULLSCREEN NOTICE                                               *
****************************************************************************/

// PREF: remove fullscreen delay
user_pref("full-screen-api.transition-duration.enter", "0 0"); // default=200 200
user_pref("full-screen-api.transition-duration.leave", "0 0"); // default=200 200

// PREF: disable fullscreen notice
user_pref("full-screen-api.warning.delay", -1); // default=500
user_pref("full-screen-api.warning.timeout", 0); // default=3000

/****************************************************************************
 * SECTION: FONT APPEARANCE                                                 *
****************************************************************************/

// PREF: smoother font
// [1] https://reddit.com/r/firefox/comments/wvs04y/windows_11_firefox_v104_font_rendering_different/?context=3
//user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);

// PREF: use DirectWrite everywhere like Chrome [WINDOWS]
// [1] https://kb.mozillazine.org/Thunderbird_6.0,_etc.#Font_rendering_and_performance_issues
// [2] https://reddit.com/r/firefox/comments/wvs04y/comment/ilklzy1/?context=3
//user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);
//user_pref("gfx.font_rendering.cleartype_params.cleartype_level", 100);
//user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "");
//user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_max_size", 6);
//user_pref("gfx.font_rendering.directwrite.use_gdi_table_loading", false);
// Some users find these helpful:
    //user_pref("gfx.font_rendering.cleartype_params.gamma", 1750);
    //user_pref("gfx.font_rendering.cleartype_params.enhanced_contrast", 100);
    //user_pref("gfx.font_rendering.cleartype_params.pixel_structure", 1);

// PREF: use macOS Appearance Panel text smoothing setting when rendering text [macOS]
//user_pref("gfx.use_text_smoothing_setting", true);

/****************************************************************************
 * SECTION: URL BAR                                                         *
****************************************************************************/

// PREF: minimize URL bar suggestions (bookmarks, history, open tabs)
// Dropdown options in the URL bar:
//user_pref("browser.urlbar.suggest.history", false);
//user_pref("browser.urlbar.suggest.bookmark", true); // DEFAULT
//user_pref("browser.urlbar.suggest.clipboard", false);
//user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.engines", false);
    //user_pref("browser.urlbar.suggest.searches", false);
//user_pref("browser.urlbar.quickactions.enabled", false);
//user_pref("browser.urlbar.shortcuts.quickactions", false);
//user_pref("browser.urlbar.suggest.weather", true); // DEFAULT [FF108]
    //user_pref("browser.urlbar.weather.ignoreVPN", false); // DEFAULT
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);

// PREF: disable dropdown suggestions with empty query
//user_pref("browser.urlbar.suggest.topsites", false);

// PREF: disable urlbar trending search suggestions [FF118+]
// [SETTING] Search>Search Suggestions>Show trending search suggestions (FF119)
user_pref("browser.urlbar.trending.featureGate", false);
//user_pref("browser.urlbar.suggest.trending", false);

// PREF: disable urlbar suggestions
//user_pref("browser.urlbar.addons.featureGate", false); // [FF115+]
//user_pref("browser.urlbar.mdn.featureGate", false); // [FF117+] [HIDDEN PREF]
//user_pref("browser.urlbar.pocket.featureGate", false); // [FF116+] [DEFAULT: false]
//user_pref("browser.urlbar.weather.featureGate", false); // [FF108+] [DEFAULT: false]
//user_pref("browser.urlbar.clipboard.featureGate", false); // [FF118+] [DEFAULT: true FF125+]
//user_pref("browser.urlbar.yelp.featureGate", false); // [FF124+] [DEFAULT: false]

// PREF: disable tab-to-search [FF85+]
// Alternatively, you can exclude on a per-engine basis by unchecking them in Options>Search
// [SETTING] Privacy & Security>Address Bar>When using the address bar, suggest>Search engines
//user_pref("browser.urlbar.suggest.engines", false);

// PREF: Adaptive History Autofill
// [1] https://docs.google.com/document/u/1/d/e/2PACX-1vRBLr_2dxus-aYhZRUkW9Q3B1K0uC-a0qQyE3kQDTU3pcNpDHb36-Pfo9fbETk89e7Jz4nkrqwRhi4j/pub
//user_pref("browser.urlbar.autoFill", true); // [DEFAULT]
//user_pref("browser.urlbar.autoFill.adaptiveHistory.enabled", false);

// PREF: adjust the amount of Address bar / URL bar dropdown results
// This value controls the total number of entries to appear in the location bar dropdown.
// [NOTE] Items (bookmarks/history/openpages) with a high "frequency"/"bonus" will always
// be displayed (no we do not know how these are calculated or what the threshold is),
// and this does not affect the search by search engine suggestion.
// disable=0
//user_pref("browser.urlbar.maxRichResults", 5); // default=10

// PREF: text fragments [FF126+ NIGHTLY]
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1753933#c6
// [2] https://developer.mozilla.org/en-US/docs/Web/Text_fragments
// [3] https://web.dev/articles/text-fragments
//user_pref("dom.text_fragments.enabled", true);

/****************************************************************************
 * SECTION: AUTOPLAY                                                        *
****************************************************************************/

// PREF: do not autoplay media audio
// [NOTE] You can set exceptions under site permissions
// [SETTING] Privacy & Security>Permissions>Autoplay>Settings>Default for all websites
// 0=Allow all, 1=Block non-muted media (default), 5=Block all
//user_pref("media.autoplay.default", 1); // DEFAULT
//user_pref("media.block-autoplay-until-in-foreground", true); // DEFAULT

// PREF: disable autoplay of HTML5 media if you interacted with the site [FF78+]
// 0=sticky (default), 1=transient, 2=user
// Firefox's Autoplay Policy Documentation (PDF) is linked below via SUMO
// [NOTE] If you have trouble with some video sites (e.g. YouTube), then add an exception (see previous PREF)
// [1] https://support.mozilla.org/questions/1293231
//user_pref("media.autoplay.blocking_policy", 2);

/****************************************************************************
 * SECTION: NEW TAB PAGE                                                    *
****************************************************************************/

// PREF: startup / new tab page
// 0=blank, 1=home, 2=last visited page, 3=resume previous session
// [NOTE] Session Restore is cleared with history and not used in Private Browsing mode
// [SETTING] General>Startup>Open previous windows and tabs
//user_pref("browser.startup.page", 3);

// PREF: set HOME+NEW WINDOW page to blank tab
// about:home=Activity Stream, custom URL, about:blank
// [SETTING] Home>New Windows and Tabs>Homepage and new windows
// [Custom URLs] Set two or more websites in Home Page Field – delimited by |
// [1] https://support.mozilla.org/en-US/questions/1271888#answer-1262899
//user_pref("browser.startup.homepage", "about:blank");

// PREF: set NEWTAB page to blank tab
// true=Firefox Home, false=blank page
// [SETTING] Home>New Windows and Tabs>New tabs
//user_pref("browser.newtabpage.enabled", false);

// PREF: Pinned Shortcuts on New Tab
// [SETTINGS] Home>Firefox Home Content
// [1] https://github.com/arkenfox/user.js/issues/1556
//user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
//user_pref("browser.newtabpage.activity-stream.showSearch", true); // NTP Web Search [DEFAULT]
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false); // Shortcuts
      //user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // Shortcuts > Sponsored shortcuts [FF83+]
//user_pref("browser.newtabpage.activity-stream.showWeather", false); // Weather [FF128+ NIGHTLY]
    //user_pref("browser.newtabpage.activity-stream.system.showWeather", false); // Weather [FF128+ NIGHTLY]
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false); // Recommended by Pocket
      //user_pref("browser.newtabpage.activity-stream.showSponsored", false); // Sponsored Stories [FF58+]  
//user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false); // Recent Activity [DEFAULT]
      //user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
      //user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
      //user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
      //user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
//user_pref("browser.newtabpage.activity-stream.feeds.snippets", false); // [DEFAULT]

// PREF: wallpapers on New Tab [FF128+ NIGHTLY]
//user_pref("browser.newtabpage.activity-stream.newtabWallpapers.enabled", false); // Wallpapers

// PREF: clear default topsites
// [NOTE] This does not block you from adding your own.
//user_pref("browser.newtabpage.activity-stream.default.sites", "");

// PREF: keep search in the search box; prevent from jumping to address bar
// [1] https://www.reddit.com/r/firefox/comments/oxwvbo/firefox_start_page_search_options/
//user_pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false);
      
// PREF: Firefox logo to always show
//user_pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", true); // DEFAULT

// PREF: Bookmarks Toolbar visibility
// always, never, or newtab
//user_pref("browser.toolbars.bookmarks.visibility", "newtab"); // DEFAULT

/******************************************************************************
 * SECTION: POCKET                                                            *
******************************************************************************/

// PREF: Disable built-in Pocket extension
user_pref("extensions.pocket.enabled", false);
      //user_pref("extensions.pocket.api"," ");
      //user_pref("extensions.pocket.oAuthConsumerKey", " ");
      //user_pref("extensions.pocket.site", " ");
      //user_pref("extensions.pocket.showHome", false);

/******************************************************************************
 * SECTION: DOWNLOADS                                 *
******************************************************************************/

// PREF: choose download location
// [SETTING] To set your default "downloads": General>Downloads>Save files to...
// 0=desktop, 1=downloads (default), 2=last used
//user_pref("browser.download.folderList", 1); // DEFAULT

// PREF: always ask how to handle new mimetypes [FF101+]
// Enforce user interaction for greater security.
// [SETTING] General>Files and Applications>Applications>What should Firefox do with other files?
// false=Save files
// true=Ask whether to open or save files
user_pref("browser.download.always_ask_before_handling_new_types", true);

// PREF: always ask where to download
// [OPTIONAL HARDENING] Enforce user interaction for greater security.
// [SETTING] General>Files and Applications>Downloads>Always ask you where to save files
// [DIALOGUE] "Ask whether to open or save files"
// true=direct download (default)
// false=the user is asked what to do
// [1] https://github.com/yokoffing/Betterfox/issues/267
//user_pref("browser.download.useDownloadDir", false);
    //user_pref("browser.download.dir", "C:\Users\<YOUR_USERNAME>\AppData\Local\Temp"); // [WINDOWS]

// PREF: autohide the downloads button
//user_pref("browser.download.autohideButton", true); // DEFAULT

// PREF: disable download panel opening on every download [non-functional?]
// Controls whether to open the download panel every time a download begins.
// [NOTE] The first download ever ran in a new profile will still open the panel.
//user_pref("browser.download.alwaysOpenPanel", false);

// PREF: disable adding downloads to the system's "recent documents" list 
user_pref("browser.download.manager.addToRecentDocs", false);

/****************************************************************************
 * SECTION: PDF                                                             *
****************************************************************************/

// PREF: enforce Firefox's built-in PDF reader
// This setting controls if the option "Display in Firefox" is available in the setting below
// and by effect controls whether PDFs are handled in-browser or externally ("Ask" or "Open With").
// [1] https://mozilla.github.io/pdf.js/
//user_pref("pdfjs.disabled", false); // DEFAULT

// PREF: allow viewing of PDFs even if the response HTTP headers
// include Content-Disposition:attachment. 
//user_pref("browser.helperApps.showOpenOptionForPdfJS", true); // DEFAULT

// PREF: open PDFs inline (FF103+)
user_pref("browser.download.open_pdf_attachments_inline", true);

// PREF: PDF sidebar on load
// 2=table of contents (if not available, will default to 1)
// 1=view pages
// 0=disabled
// -1=remember previous state (default)
//user_pref("pdfjs.sidebarViewOnLoad", 2);

// PREF: default zoom for PDFs [HIDDEN]
// [NOTE] "page-width" not needed if using sidebar on load
//user_pref("pdfjs.defaultZoomValue", page-width);

/****************************************************************************
 * SECTION: TAB BEHAVIOR                                                    *
****************************************************************************/

// PREF: search query opens in a new tab (instead of the current tab)
//user_pref("browser.search.openintab", true); // SEARCH BOX
//user_pref("browser.urlbar.openintab", true); // URL BAR

// PREF: control behavior of links that would normally open in a new window
// [NOTE] You can still right-click a link and open in a new window
// 3 (default) = in a new tab; pop-up windows are treated like regular tabs
// 2 = in a new window
// 1 = in the current tab
//user_pref("browser.link.open_newwindow", 3); // DEFAULT

// PREF: determine the behavior of pages opened by JavaScript (like popups)
// 2 (default) = catch new windows opened by JavaScript that do not have
// specific values set (how large the window should be, whether it
// should have a status bar, etc.) 
// 1 = let all windows opened by JavaScript open in new windows
// 0 = force all new windows opened by JavaScript into tabs
// [NOTE] Most advertising popups also open in new windows with values set
// [1] https://kb.mozillazine.org/About:config_entries
//user_pref("browser.link.open_newwindow.restriction", 0);

// PREF: override <browser.link.open_newwindow> for external links
// Set if a different destination for external links is needed
// 3=Open in a new tab in the current window
// 2=Open in a new window
// 1=Open in the current tab/window
// -1=no overrides (default)
//user_pref("browser.link.open_newwindow.override.external", -1); // DEFAULT

// PREF: focus behavior for new tabs from links
// Determine whether a link opens in the foreground or background on left-click
// [SETTINGS] Settings>General>Tabs>"When you open a link, image or media in a new tab, switch to it immediately"
// true(default) = opens new tabs by left-click in the background, leaving focus on the current tab
// false = opens new tabs by left-click in the foreground, putting focus on the new tab
// [NOTE] CTRL+SHIFT+CLICK will open new tabs in foreground (default); switching PREF to false will reverse this behavior
// [1] https://kb.mozillazine.org/About:config_entries
//user_pref("browser.tabs.loadInBackground", true); // DEFAULT

// PREF: determines whether pages normally meant to open in a new window (such as
// target="_blank" or from an external program), but that have instead been loaded in a new tab
// This pref takes effect when Firefox has diverted a new window to a new tab instead, then:
// true = loads the new tab in the background, leaving focus on the current tab
// false(default) = loads the new tab in the foreground, taking the focus from the current tab
// [NOTE] Setting this preference to true will still bring the browser to the front when opening links from outside the browser
// [1] https://kb.mozillazine.org/About:config_entries
//user_pref("browser.tabs.loadDivertedInBackground", false); // DEFAULT

// PREF: force bookmarks to open in a new tab, not the current tab
//user_pref("browser.tabs.loadBookmarksInTabs", true);
    //user_pref("browser.tabs.loadBookmarksInBackground", true); // load bookmarks in background

// PREF: leave Bookmarks Menu open when selecting a site
user_pref("browser.bookmarks.openInTabClosesMenu", false);

// PREF: restore "View image info" on right-click
user_pref("browser.menu.showViewImageInfo", true);

// PREF: show all matches in Findbar
user_pref("findbar.highlightAll", true);

// PREF: force disable finding text on page without prompting
// [NOTE] Not as powerful as using Ctrl+F.
// [SETTINGS] General>Browsing>"Search for text when you start typing"
// [1] https://github.com/yokoffing/Betterfox/issues/212
//user_pref("accessibility.typeaheadfind", false); // enforce DEFAULT

// PREF: disable middle mouse click opening links from clipboard
// It's been default in Linux since at least FF102.
// [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/10089
//user_pref("middlemouse.contentLoadURL", false);

// PREF: Prevent scripts from moving and resizing open windows
//user_pref("dom.disable_window_move_resize", true);

// PREF: insert new tabs after groups like it
// true(default) = open new tabs to the right of the parent tab
// false = new tabs are opened at the far right of the tab bar
//user_pref("browser.tabs.insertRelatedAfterCurrent", true); // DEFAULT

// PREF: insert new tabs immediately after the current tab
//user_pref("browser.tabs.insertAfterCurrent", true);

// PREF: leave the browser window open even after you close the last tab
//user_pref("browser.tabs.closeWindowWithLastTab", false);

// PREF: stop websites from reloading pages automatically
// [WARNING] Breaks some sites.
// [1] https://www.ghacks.net/2018/08/19/stop-websites-from-reloading-pages-automatically/
//user_pref("accessibility.blockautorefresh", true);
//user_pref("browser.meta_refresh_when_inactive.disabled", true);

// PREF: do not select the space next to a word when selecting a word
user_pref("layout.word_select.eat_space_to_next_word", false);

// PREF: controls if a double-click word selection also deletes one adjacent whitespace
// This mimics native behavior on macOS.
//user_pref("editor.word_select.delete_space_after_doubleclick_selection", true);

// PREF: do not hide the pointer while typing [LINUX]
//user_pref("widget.gtk.hide-pointer-while-typing.enabled", false);

// PREF: limit events that can cause a pop-up
// Firefox provides an option to provide exceptions for sites, remembered in your Site Settings.
// (default) "change click dblclick auxclick mouseup pointerup notificationclick reset submit touchend contextmenu"
// (alternate) user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown");
//user_pref("dom.popup_allowed_events", "click dblclick");
//user_pref("dom.disable_open_during_load", true); // DEFAULT
//user_pref("privacy.popups.showBrowserMessage", true); // DEFAULT

// PREF: enable Tab Previews [FF122+, FF128+]
// [1] https://github.com/yokoffing/Betterfox/issues/309
//user_pref("browser.tabs.hoverPreview.enabled", true);
    //user_pref("browser.tabs.hoverPreview.showThumbnails", true); // DEFAULT

/****************************************************************************
 * SECTION: UNCATEGORIZED                                                   *
****************************************************************************/

// PREF: disable backspace action
// 0=previous page, 1=scroll up, 2=do nothing
//user_pref("browser.backspace_action", 2); // DEFAULT

// PREF: disable Reader mode
// [TIP] Use about:reader?url=%s as a keyword to open links automatically in reader mode [1].
// Firefox will not have to parse webpage for Reader when navigating.
// Extremely minimal performance impact, if you disable.
// [1] https://www.reddit.com/r/firefox/comments/621sr2/i_found_out_how_to_automatically_open_a_url_in/ 
//user_pref("reader.parse-on-load.enabled", false);

// PREF: disable ALT key toggling the menu bar
//user_pref("ui.key.menuAccessKeyFocuses", false);
    //user_pref("ui.key.menuAccessKey", 18); // DEFAULT

// PREF: cycle through tabs in recently used order
// [SETTING] Ctrl+Tab cycles through tabs in recently used order
//user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// PREF: Spell-check
// 0=none, 1-multi-line, 2=multi-line & single-line
//user_pref("layout.spellcheckDefault", 1); // DEFAULT

// PREF: Spell Checker underline styles [HIDDEN]
// [1] https://kb.mozillazine.org/Ui.SpellCheckerUnderlineStyle#Possible_values_and_their_effects
//user_pref("ui.SpellCheckerUnderlineStyle", 1);

// PREF: limit the number of bookmark backups Firefox keeps
//user_pref("browser.bookmarks.max_backups", 1); // default=15

// PREF: zoom only text on webpage, not other elements
//user_pref("browser.zoom.full", false);

// PREF: allow for more granular control of zoom levels
// Especially useful if you want to set your default zoom to a custom level.
//user_pref("toolkit.zoomManager.zoomValues", ".3,.5,.67,.8,.9,.95,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,2,2.4,3");

// PREF: restore zooming behavior [macOS] [FF109+]
// On macOS, Ctrl or Cmd + trackpad or mouse wheel now scrolls the page instead of zooming.
// This avoids accidental zooming and matches Safari's and Chrome's behavior.
// The prefs below restores the previous zooming behavior
//user_pref("mousewheel.with_control.action", 3);
//user_pref("mousewheel.with_meta.action", 3);

// PREF: hide image placeholders
//user_pref("browser.display.show_image_placeholders", false);

// PREF: wrap long lines of text when using source / debugger
//user_pref("view_source.wrap_long_lines", true);
//user_pref("devtools.debugger.ui.editor-wrapping", true);

// PREF: enable ASRouter Devtools at about:newtab#devtools (useful if you're making your own CSS theme)
// [1] https://firefox-source-docs.mozilla.org/browser/components/newtab/content-src/asrouter/docs/debugging-docs.html
//user_pref("browser.newtabpage.activity-stream.asrouter.devtoolsEnabled", true);
// show user agent styles in the inspector
//user_pref("devtools.inspector.showUserAgentStyles", true);
// show native anonymous content (like scrollbars or tooltips) and user agent shadow roots (like the components of an <input> element) in the inspector
//user_pref("devtools.inspector.showAllAnonymousContent", true);

// PREF: print preview
//user_pref("print.tab_modal.enabled", true); // DEFAULT

// PREF: adjust the minimum tab width
// Can be overridden by userChrome.css
//user_pref("browser.tabs.tabMinWidth", 120); // default=76

// PREF: remove underlined characters from various settings
//user_pref("ui.key.menuAccessKey", 0);

// PREF: disable websites overriding Firefox's keyboard shortcuts [FF58+]
// 0=ask (default), 1=allow, 2=block
// [SETTING] to add site exceptions: Ctrl+I>Permissions>Override Keyboard Shortcuts ***/
//user_pref("permissions.default.shortcuts", 2);

// PREF: JPEG XL image format [NIGHTLY]
// May not affect anything on ESR/Stable channel [2].
// [TEST] https://jpegxl.io/tutorials/firefox/#firefoxjpegxltutorial
// [1] https://cloudinary.com/blog/the-case-for-jpeg-xl
// [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1539075#c51
//user_pref("image.jxl.enabled", true);

// PREF: enable CSS moz document rules
// Still needed for Stylus?
// [1] https://reddit.com/r/FirefoxCSS/comments/8x2q97/reenabling_mozdocument_rules_in_firefox_61/
//user_pref("layout.css.moz-document.content.enabled", true);

// PREF: always underline links [FF120+]
//user_pref("layout.css.always_underline_links", false); // DEFAULT

// PREF: hide frequent sites on right-click of taskbar icon [WINDOWS?]
//user_pref("browser.taskbar.lists.frequent.enabled", false);


/****************************************************************************************
 * OPTION: INSTANT SCROLLING (SIMPLE ADJUSTMENT)                                       *
****************************************************************************************/
// recommended for 60hz+ displays
user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("mousewheel.default.delta_multiplier_y", 275); // 250-400; adjust this number to your liking
// Firefox Nightly only:
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1846935
user_pref("general.smoothScroll.msdPhysics.enabled", false); // [FF122+ Nightly]


/****************************************************************************************
 * OPTION: NATURAL SMOOTH SCROLLING V3 [MODIFIED]                                      *
****************************************************************************************/
// credit: https://github.com/AveYo/fox/blob/cf56d1194f4e5958169f9cf335cd175daa48d349/Natural%20Smooth%20Scrolling%20for%20user.js
// recommended for 120hz+ displays
// largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
//user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
//user_pref("general.smoothScroll", true); // DEFAULT
//user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
//user_pref("general.smoothScroll.msdPhysics.enabled", true);
//user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
//user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
//user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
//user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
//user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
//user_pref("general.smoothScroll.currentVelocityWeighting", "1");
//user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
//user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking
//
/******
*    name: arkenfox user.js
*    date: 7 June 2024
* version: 126
*    urls: https://github.com/arkenfox/user.js [repo]
*        : https://arkenfox.github.io/gui/ [interactive]
* license: MIT: https://github.com/arkenfox/user.js/blob/master/LICENSE.txt

* README:

  1. Consider using Tor Browser if it meets your needs or fits your threat model
       * https://2019.www.torproject.org/about/torusers.html
  2. Read the entire wiki
       * https://github.com/arkenfox/user.js/wiki
  3. If you skipped step 2, return to step 2
  4. Make changes in a user-overrides.js
       * There are often trade-offs and conflicts between security vs privacy vs anti-tracking
         and these need to be balanced against functionality & convenience & breakage
       * Some site breakage and unintended consequences will happen. Everyone's experience will differ
         e.g. some user data is erased on exit (section 2800), change this to suit your needs
       * While not 100% definitive, search for "[SETUP" tags
  5. Some tag info
       [SETUP-SECURITY] it's one item, read it
            [SETUP-WEB] can cause some websites to break
         [SETUP-CHROME] changes how Firefox itself behaves (i.e. not directly website related)
  6. Override Recipes: https://github.com/arkenfox/user.js/issues/1080

* RELEASES: https://github.com/arkenfox/user.js/releases

  * Use the arkenfox release that matches your Firefox version
    - DON'T wait for arkenfox to update Firefox, nothing major changes these days
  * Each release
    - run prefsCleaner to reset prefs made inactive, including deprecated (9999)
  * ESR
    - It is recommended to not use the updater, or you will get a later version which may cause issues.
      So you should manually append your overrides (and keep a copy), and manually update when you
      change ESR releases (arkenfox is already past that release)
    - If you decide to keep updating, then the onus is on you - also see section 9999

* INDEX:

  0100: STARTUP
  0200: GEOLOCATION
  0300: QUIETER FOX
  0400: SAFE BROWSING
  0600: BLOCK IMPLICIT OUTBOUND
  0700: DNS / DoH / PROXY / SOCKS
  0800: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
  0900: PASSWORDS
  1000: DISK AVOIDANCE
  1200: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
  1600: REFERERS
  1700: CONTAINERS
  2000: PLUGINS / MEDIA / WEBRTC
  2400: DOM (DOCUMENT OBJECT MODEL)
  2600: MISCELLANEOUS
  2700: ETP (ENHANCED TRACKING PROTECTION)
  2800: SHUTDOWN & SANITIZING
  4000: FPP (fingerprintingProtection)
  4500: RFP (resistFingerprinting)
  5000: OPTIONAL OPSEC
  5500: OPTIONAL HARDENING
  6000: DON'T TOUCH
  7000: DON'T BOTHER
  8000: DON'T BOTHER: FINGERPRINTING
  9000: NON-PROJECT RELATED
  9999: DEPRECATED / RENAMED

******/

/* START: internal custom pref to test for syntax errors
 * [NOTE] Not all syntax errors cause parsing to abort i.e. reaching the last debug pref
 * no longer necessarily means that all prefs have been applied. Check the console right
 * after startup for any warnings/error messages related to non-applied prefs
 * [1] https://blog.mozilla.org/nnethercote/2018/03/09/a-new-preferences-parser-for-firefox/ ***/
user_pref("_user.js.parrot", "START: Oh yes, the Norwegian Blue... what's wrong with it?");

/* 0000: disable about:config warning ***/
user_pref("browser.aboutConfig.showWarning", false);

/*** [SECTION 0100]: STARTUP ***/
user_pref("_user.js.parrot", "0100 syntax error: the parrot's dead!");
/* 0102: set startup page [SETUP-CHROME]
 * 0=blank, 1=home, 2=last visited page, 3=resume previous session
 * [NOTE] Session Restore is cleared with history (2811), and not used in Private Browsing mode
 * [SETTING] General>Startup>Restore previous session ***/
user_pref("browser.startup.page", 0);
/* 0103: set HOME+NEWWINDOW page
 * about:home=Firefox Home (default, see 0105), custom URL, about:blank
 * [SETTING] Home>New Windows and Tabs>Homepage and new windows ***/
user_pref("browser.startup.homepage", "about:blank");
/* 0104: set NEWTAB page
 * true=Firefox Home (default, see 0105), false=blank page
 * [SETTING] Home>New Windows and Tabs>New tabs ***/
user_pref("browser.newtabpage.enabled", false);
/* 0105: disable sponsored content on Firefox Home (Activity Stream)
 * [SETTING] Home>Firefox Home Content ***/
user_pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+]
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Shortcuts>Sponsored shortcuts
/* 0106: clear default topsites
 * [NOTE] This does not block you from adding your own ***/
user_pref("browser.newtabpage.activity-stream.default.sites", "");

/*** [SECTION 0200]: GEOLOCATION ***/
user_pref("_user.js.parrot", "0200 syntax error: the parrot's definitely deceased!");
/* 0201: use Mozilla geolocation service instead of Google if permission is granted [FF74+]
 * Optionally enable logging to the console (defaults to false) ***/
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
   // user_pref("geo.provider.network.logging.enabled", true); // [HIDDEN PREF]
/* 0202: disable using the OS's geolocation service ***/
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX] [HIDDEN PREF]
user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]

/*** [SECTION 0300]: QUIETER FOX ***/
user_pref("_user.js.parrot", "0300 syntax error: the parrot's not pinin' for the fjords!");
/** RECOMMENDATIONS ***/
/* 0320: disable recommendation pane in about:addons (uses Google Analytics) ***/
user_pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
/* 0321: disable recommendations in about:addons' Extensions and Themes panes [FF68+] ***/
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
/* 0322: disable personalized Extension Recommendations in about:addons and AMO [FF65+]
 * [NOTE] This pref has no effect when Health Reports (0331) are disabled
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to make personalized extension recommendations
 * [1] https://support.mozilla.org/kb/personalized-extension-recommendations ***/
user_pref("browser.discovery.enabled", false);
/* 0323: disable shopping experience [FF116+]
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1840156#c0 ***/
user_pref("browser.shopping.experience2023.enabled", false); // [DEFAULT: false]

/** TELEMETRY ***/
/* 0330: disable new data submission [FF41+]
 * If disabled, no policy is shown or upload takes place, ever
 * [1] https://bugzilla.mozilla.org/1195552 ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
/* 0331: disable Health Reports
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send technical... data ***/
user_pref("datareporting.healthreport.uploadEnabled", false);
/* 0332: disable telemetry
 * The "unified" pref affects the behavior of the "enabled" pref
 * - If "unified" is false then "enabled" controls the telemetry module
 * - If "unified" is true then "enabled" only controls whether to record extended data
 * [NOTE] "toolkit.telemetry.enabled" is now LOCKED to reflect prerelease (true) or release builds (false) [2]
 * [1] https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html
 * [2] https://medium.com/georg-fritzsche/data-preference-changes-in-firefox-58-2d5df9c428b5 ***/
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE]
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]
/* 0333: disable Telemetry Coverage
 * [1] https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/ ***/
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");
/* 0335: disable Firefox Home (Activity Stream) telemetry ***/
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

/** STUDIES ***/
/* 0340: disable Studies
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to install and run studies ***/
user_pref("app.shield.optoutstudies.enabled", false);
/* 0341: disable Normandy/Shield [FF60+]
 * Shield is a telemetry system that can push and test "recipes"
 * [1] https://mozilla.github.io/normandy/ ***/
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** CRASH REPORTS ***/
/* 0350: disable Crash Reports ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]
   // user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // [FF51+] [DEFAULT: false]
/* 0351: enforce no submission of backlogged Crash Reports [FF58+]
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send backlogged crash reports  ***/
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [DEFAULT: false]

/** OTHER ***/
/* 0360: disable Captive Portal detection
 * [1] https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy ***/
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false); // [FF52+]
/* 0361: disable Network Connectivity checks [FF65+]
 * [1] https://bugzilla.mozilla.org/1460537 ***/
user_pref("network.connectivity-service.enabled", false);

/*** [SECTION 0400]: SAFE BROWSING (SB)
   SB has taken many steps to preserve privacy. If required, a full url is never sent
   to Google, only a part-hash of the prefix, hidden with noise of other real part-hashes.
   Firefox takes measures such as stripping out identifying parameters and since SBv4 (FF57+)
   doesn't even use cookies. (#Turn on browser.safebrowsing.debug to monitor this activity)

   [1] https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
   [2] https://wiki.mozilla.org/Security/Safe_Browsing
   [3] https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work
   [4] https://educatedguesswork.org/posts/safe-browsing-privacy/
***/
user_pref("_user.js.parrot", "0400 syntax error: the parrot's passed on!");
/* 0401: disable SB (Safe Browsing)
 * [WARNING] Do this at your own risk! These are the master switches
 * [SETTING] Privacy & Security>Security>... Block dangerous and deceptive content ***/
   // user_pref("browser.safebrowsing.malware.enabled", false);
   // user_pref("browser.safebrowsing.phishing.enabled", false);
/* 0402: disable SB checks for downloads (both local lookups + remote)
 * This is the master switch for the safebrowsing.downloads* prefs (0403, 0404)
 * [SETTING] Privacy & Security>Security>... "Block dangerous downloads" ***/
   // user_pref("browser.safebrowsing.downloads.enabled", false);
/* 0403: disable SB checks for downloads (remote)
 * To verify the safety of certain executable files, Firefox may submit some information about the
 * file, including the name, origin, size and a cryptographic hash of the contents, to the Google
 * Safe Browsing service which helps Firefox determine whether or not the file should be blocked
 * [SETUP-SECURITY] If you do not understand this, or you want this protection, then override this ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
   // user_pref("browser.safebrowsing.downloads.remote.url", ""); // Defense-in-depth
/* 0404: disable SB checks for unwanted software
 * [SETTING] Privacy & Security>Security>... "Warn you about unwanted and uncommon software" ***/
   // user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
   // user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
/* 0405: disable "ignore this warning" on SB warnings [FF45+]
 * If clicked, it bypasses the block for that session. This is a means for admins to enforce SB
 * [TEST] see https://github.com/arkenfox/user.js/wiki/Appendix-A-Test-Sites#-mozilla
 * [1] https://bugzilla.mozilla.org/1226490 ***/
   // user_pref("browser.safebrowsing.allowOverride", false);

/*** [SECTION 0600]: BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on] ***/
user_pref("_user.js.parrot", "0600 syntax error: the parrot's no more!");
/* 0601: disable link prefetching
 * [1] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ ***/
user_pref("network.prefetch-next", false);
/* 0602: disable DNS prefetching
 * [1] https://developer.mozilla.org/docs/Web/HTTP/Headers/X-DNS-Prefetch-Control ***/
user_pref("network.dns.disablePrefetch", true);
   // user_pref("network.dns.disablePrefetchFromHTTPS", true); // [DEFAULT: true]
/* 0603: disable predictor / prefetching ***/
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false); // [FF48+] [DEFAULT: false]
/* 0604: disable link-mouseover opening connection to linked server
 * [1] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests ***/
user_pref("network.http.speculative-parallel-limit", 0);
/* 0605: disable mousedown speculative connections on bookmarks and history [FF98+] ***/
user_pref("browser.places.speculativeConnect.enabled", false);
/* 0610: enforce no "Hyperlink Auditing" (click tracking)
 * [1] https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/ ***/
   // user_pref("browser.send_pings", false); // [DEFAULT: false]

/*** [SECTION 0700]: DNS / DoH / PROXY / SOCKS ***/
user_pref("_user.js.parrot", "0700 syntax error: the parrot's given up the ghost!");
/* 0702: set the proxy server to do any DNS lookups when using SOCKS
 * e.g. in Tor, this stops your local DNS server from knowing your Tor destination
 * as a remote Tor node will handle the DNS request
 * [1] https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers ***/
user_pref("network.proxy.socks_remote_dns", true);
/* 0703: disable using UNC (Uniform Naming Convention) paths [FF61+]
 * [SETUP-CHROME] Can break extensions for profiles on network shares
 * [1] https://bugzilla.mozilla.org/1413868 ***/
user_pref("network.file.disable_unc_paths", true); // [HIDDEN PREF]
/* 0704: disable GIO as a potential proxy bypass vector
 * Gvfs/GIO has a set of supported protocols like obex, network, archive, computer,
 * dav, cdda, gphoto2, trash, etc. From FF87-117, by default only sftp was accepted
 * [1] https://bugzilla.mozilla.org/1433507
 * [2] https://en.wikipedia.org/wiki/GVfs
 * [3] https://en.wikipedia.org/wiki/GIO_(software) ***/
user_pref("network.gio.supported-protocols", ""); // [HIDDEN PREF] [DEFAULT: "" FF118+]
/* 0705: disable proxy direct failover for system requests [FF91+]
 * [WARNING] Default true is a security feature against malicious extensions [1]
 * [SETUP-CHROME] If you use a proxy and you trust your extensions
 * [1] https://blog.mozilla.org/security/2021/10/25/securing-the-proxy-api-for-firefox-add-ons/ ***/
   // user_pref("network.proxy.failover_direct", false);
/* 0706: disable proxy bypass for system request failures [FF95+]
 * RemoteSettings, UpdateService, Telemetry [1]
 * [WARNING] If false, this will break the fallback for some security features
 * [SETUP-CHROME] If you use a proxy and you understand the security impact
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1732792,1733994,1733481 ***/
   // user_pref("network.proxy.allow_bypass", false);
/* 0710: enable DNS-over-HTTPS (DoH) [FF60+]
 * 0=default, 2=increased (TRR (Trusted Recursive Resolver) first), 3=max (TRR only), 5=off (no rollout)
 * see "doh-rollout.home-region": USA 2019, Canada 2021, Russia/Ukraine 2022 [3]
 * [SETTING] Privacy & Security>DNS over HTTPS
 * [1] https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/
 * [2] https://wiki.mozilla.org/Security/DOH-resolver-policy
 * [3] https://support.mozilla.org/en-US/kb/firefox-dns-over-https
 * [4] https://www.eff.org/deeplinks/2020/12/dns-doh-and-odoh-oh-my-year-review-2020 ***/
   // user_pref("network.trr.mode", 3);
/* 0712: set DoH provider
 * The custom uri is the value shown when you "Choose provider>Custom>"
 * [NOTE] If you USE custom then "network.trr.uri" should be set the same
 * [SETTING] Privacy & Security>DNS over HTTPS>Increased/Max>Choose provider ***/
   // user_pref("network.trr.uri", "https://example.dns");
   // user_pref("network.trr.custom_uri", "https://example.dns");

/*** [SECTION 0800]: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS ***/
user_pref("_user.js.parrot", "0800 syntax error: the parrot's ceased to be!");
/* 0801: disable location bar making speculative connections [FF56+]
 * [1] https://bugzilla.mozilla.org/1348275 ***/
user_pref("browser.urlbar.speculativeConnect.enabled", false);
/* 0802: disable location bar contextual suggestions
 * [NOTE] The UI is controlled by the .enabled pref
 * [SETTING] Search>Address Bar>Suggestions from...
 * [1] https://blog.mozilla.org/data/2021/09/15/data-and-firefox-suggest/ ***/
   // user_pref("browser.urlbar.quicksuggest.enabled", false); // [FF92+] [DEFAULT: false]
   // user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false); // [FF95+] [DEFAULT: false]
   // user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // [FF92+] [DEFAULT: false]
/* 0803: disable live search suggestions
 * [NOTE] Both must be true for live search to work in the location bar
 * [SETUP-CHROME] Override these if you trust and use a privacy respecting search engine
 * [SETTING] Search>Provide search suggestions | Show search suggestions in address bar results ***/
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
/* 0805: disable urlbar trending search suggestions [FF118+]
 * [SETTING] Search>Search Suggestions>Show trending search suggestions (FF119) ***/
user_pref("browser.urlbar.trending.featureGate", false);
/* 0806: disable urlbar suggestions ***/
user_pref("browser.urlbar.addons.featureGate", false); // [FF115+]
user_pref("browser.urlbar.mdn.featureGate", false); // [FF117+] [HIDDEN PREF]
user_pref("browser.urlbar.pocket.featureGate", false); // [FF116+] [DEFAULT: false]
user_pref("browser.urlbar.weather.featureGate", false); // [FF108+] [DEFAULT: false]
user_pref("browser.urlbar.yelp.featureGate", false); // [FF124+] [DEFAULT: false]
/* 0807: disable urlbar clipboard suggestions [FF118+] ***/
   // user_pref("browser.urlbar.clipboard.featureGate", false);
/* 0810: disable search and form history
 * [SETUP-WEB] Be aware that autocomplete form data can be read by third parties [1][2]
 * [NOTE] We also clear formdata on exit (2811)
 * [SETTING] Privacy & Security>History>Custom Settings>Remember search and form history
 * [1] https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
 * [2] https://bugzilla.mozilla.org/381681 ***/
user_pref("browser.formfill.enable", false);
/* 0815: disable tab-to-search [FF85+]
 * Alternatively, you can exclude on a per-engine basis by unchecking them in Options>Search
 * [SETTING] Search>Address Bar>When using the address bar, suggest>Search engines ***/
   // user_pref("browser.urlbar.suggest.engines", false);
/* 0820: disable coloring of visited links
 * [SETUP-HARDEN] Bulk rapid history sniffing was mitigated in 2010 [1][2]. Slower and more expensive
 * redraw timing attacks were largely mitigated in FF77+ [3]. Using RFP (4501) further hampers timing
 * attacks. Don't forget clearing history on exit (2811). However, social engineering [2#limits][4][5]
 * and advanced targeted timing attacks could still produce usable results
 * [1] https://developer.mozilla.org/docs/Web/CSS/Privacy_and_the_:visited_selector
 * [2] https://dbaron.org/mozilla/visited-privacy
 * [3] https://bugzilla.mozilla.org/1632765
 * [4] https://earthlng.github.io/testpages/visited_links.html (see github wiki APPENDIX A on how to use)
 * [5] https://lcamtuf.blogspot.com/2016/08/css-mix-blend-mode-is-bad-for-keeping.html ***/
   // user_pref("layout.css.visited_links_enabled", false);
/* 0830: enable separate default search engine in Private Windows and its UI setting
 * [SETTING] Search>Default Search Engine>Choose a different default search engine for Private Windows only ***/
user_pref("browser.search.separatePrivateDefault", true); // [FF70+]
user_pref("browser.search.separatePrivateDefault.ui.enabled", true); // [FF71+]

/*** [SECTION 0900]: PASSWORDS
   [1] https://support.mozilla.org/kb/use-primary-password-protect-stored-logins-and-pas
***/
user_pref("_user.js.parrot", "0900 syntax error: the parrot's expired!");
/* 0903: disable auto-filling username & password form fields
 * can leak in cross-site forms *and* be spoofed
 * [NOTE] Username & password is still available when you enter the field
 * [SETTING] Privacy & Security>Logins and Passwords>Autofill logins and passwords
 * [1] https://freedom-to-tinker.com/2017/12/27/no-boundaries-for-user-identities-web-trackers-exploit-browser-login-managers/
 * [2] https://homes.esat.kuleuven.be/~asenol/leaky-forms/ ***/
user_pref("signon.autofillForms", false);
/* 0904: disable formless login capture for Password Manager [FF51+] ***/
user_pref("signon.formlessCapture.enabled", false);
/* 0905: limit (or disable) HTTP authentication credentials dialogs triggered by sub-resources [FF41+]
 * hardens against potential credentials phishing
 * 0 = don't allow sub-resources to open HTTP authentication credentials dialogs
 * 1 = don't allow cross-origin sub-resources to open HTTP authentication credentials dialogs
 * 2 = allow sub-resources to open HTTP authentication credentials dialogs (default) ***/
user_pref("network.auth.subresource-http-auth-allow", 1);
/* 0906: enforce no automatic authentication on Microsoft sites [FF91+] [WINDOWS 10+]
 * [SETTING] Privacy & Security>Logins and Passwords>Allow Windows single sign-on for...
 * [1] https://support.mozilla.org/kb/windows-sso ***/
   // user_pref("network.http.windows-sso.enabled", false); // [DEFAULT: false]

/*** [SECTION 1000]: DISK AVOIDANCE ***/
user_pref("_user.js.parrot", "1000 syntax error: the parrot's gone to meet 'is maker!");
/* 1001: disable disk cache
 * [SETUP-CHROME] If you think disk cache helps perf, then feel free to override this
 * [NOTE] We also clear cache on exit (2811) ***/
user_pref("browser.cache.disk.enable", false);
/* 1002: disable media cache from writing to disk in Private Browsing
 * [NOTE] MSE (Media Source Extensions) are already stored in-memory in PB ***/
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true); // [FF75+]
user_pref("media.memory_cache_max_size", 65536);
/* 1003: disable storing extra session data [SETUP-CHROME]
 * define on which sites to save extra session data such as form content, cookies and POST data
 * 0=everywhere, 1=unencrypted sites, 2=nowhere ***/
user_pref("browser.sessionstore.privacy_level", 2);
/* 1005: disable automatic Firefox start and session restore after reboot [FF62+] [WINDOWS]
 * [1] https://bugzilla.mozilla.org/603903 ***/
user_pref("toolkit.winRegisterApplicationRestart", false);
/* 1006: disable favicons in shortcuts [WINDOWS]
 * URL shortcuts use a cached randomly named .ico file which is stored in your
 * profile/shortcutCache directory. The .ico remains after the shortcut is deleted
 * If set to false then the shortcuts use a generic Firefox icon ***/
user_pref("browser.shell.shortcutFavicons", false);

/*** [SECTION 1200]: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
   Your cipher and other settings can be used in server side fingerprinting
   [TEST] https://www.ssllabs.com/ssltest/viewMyClient.html
   [TEST] https://browserleaks.com/ssl
   [TEST] https://ja3er.com/
   [1] https://www.securityartwork.es/2017/02/02/tls-client-fingerprinting-with-bro/
***/
user_pref("_user.js.parrot", "1200 syntax error: the parrot's a stiff!");
/** SSL (Secure Sockets Layer) / TLS (Transport Layer Security) ***/
/* 1201: require safe negotiation
 * Blocks connections to servers that don't support RFC 5746 [2] as they're potentially vulnerable to a
 * MiTM attack [3]. A server without RFC 5746 can be safe from the attack if it disables renegotiations
 * but the problem is that the browser can't know that. Setting this pref to true is the only way for the
 * browser to ensure there will be no unsafe renegotiations on the channel between the browser and the server
 * [SETUP-WEB] SSL_ERROR_UNSAFE_NEGOTIATION: is it worth overriding this for that one site?
 * [STATS] SSL Labs (May 2024) reports over 99.7% of top sites have secure renegotiation [4]
 * [1] https://wiki.mozilla.org/Security:Renegotiation
 * [2] https://datatracker.ietf.org/doc/html/rfc5746
 * [3] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-3555
 * [4] https://www.ssllabs.com/ssl-pulse/ ***/
user_pref("security.ssl.require_safe_negotiation", true);
/* 1206: disable TLS1.3 0-RTT (round-trip time) [FF51+]
 * This data is not forward secret, as it is encrypted solely under keys derived using
 * the offered PSK. There are no guarantees of non-replay between connections
 * [1] https://github.com/tlswg/tls13-spec/issues/1001
 * [2] https://www.rfc-editor.org/rfc/rfc9001.html#name-replay-attacks-with-0-rtt
 * [3] https://blog.cloudflare.com/tls-1-3-overview-and-q-and-a/ ***/
user_pref("security.tls.enable_0rtt_data", false);

/** OCSP (Online Certificate Status Protocol)
   [1] https://scotthelme.co.uk/revocation-is-broken/
   [2] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
***/
/* 1211: enforce OCSP fetching to confirm current validity of certificates
 * 0=disabled, 1=enabled (default), 2=enabled for EV certificates only
 * OCSP (non-stapled) leaks information about the sites you visit to the CA (cert authority)
 * It's a trade-off between security (checking) and privacy (leaking info to the CA)
 * [NOTE] This pref only controls OCSP fetching and does not affect OCSP stapling
 * [SETTING] Privacy & Security>Security>Certificates>Query OCSP responder servers...
 * [1] https://en.wikipedia.org/wiki/Ocsp ***/
user_pref("security.OCSP.enabled", 1); // [DEFAULT: 1]
/* 1212: set OCSP fetch failures (non-stapled, see 1211) to hard-fail
 * [SETUP-WEB] SEC_ERROR_OCSP_SERVER_ERROR
 * When a CA cannot be reached to validate a cert, Firefox just continues the connection (=soft-fail)
 * Setting this pref to true tells Firefox to instead terminate the connection (=hard-fail)
 * It is pointless to soft-fail when an OCSP fetch fails: you cannot confirm a cert is still valid (it
 * could have been revoked) and/or you could be under attack (e.g. malicious blocking of OCSP servers)
 * [1] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
 * [2] https://www.imperialviolet.org/2014/04/19/revchecking.html ***/
user_pref("security.OCSP.require", true);

/** CERTS / HPKP (HTTP Public Key Pinning) ***/
/* 1223: enable strict PKP (Public Key Pinning)
 * 0=disabled, 1=allow user MiTM (default; such as your antivirus), 2=strict
 * [SETUP-WEB] MOZILLA_PKIX_ERROR_KEY_PINNING_FAILURE ***/
user_pref("security.cert_pinning.enforcement_level", 2);
/* 1224: enable CRLite [FF73+]
 * 0 = disabled
 * 1 = consult CRLite but only collect telemetry
 * 2 = consult CRLite and enforce both "Revoked" and "Not Revoked" results
 * 3 = consult CRLite and enforce "Not Revoked" results, but defer to OCSP for "Revoked" (default)
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1429800,1670985,1753071
 * [2] https://blog.mozilla.org/security/tag/crlite/ ***/
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);

/** MIXED CONTENT ***/
/* 1241: disable insecure passive content (such as images) on https pages ***/
   // user_pref("security.mixed_content.block_display_content", true); // Defense-in-depth (see 1244)
/* 1244: enable HTTPS-Only mode in all windows
 * When the top-level is HTTPS, insecure subresources are also upgraded (silent fail)
 * [SETTING] to add site exceptions: Padlock>HTTPS-Only mode>On (after "Continue to HTTP Site")
 * [SETTING] Privacy & Security>HTTPS-Only Mode (and manage exceptions)
 * [TEST] http://example.com [upgrade]
 * [TEST] http://httpforever.com/ | http://http.rip [no upgrade] ***/
user_pref("dom.security.https_only_mode", true); // [FF76+]
   // user_pref("dom.security.https_only_mode_pbm", true); // [FF80+]
/* 1245: enable HTTPS-Only mode for local resources [FF77+] ***/
   // user_pref("dom.security.https_only_mode.upgrade_local", true);
/* 1246: disable HTTP background requests [FF82+]
 * When attempting to upgrade, if the server doesn't respond within 3 seconds, Firefox sends
 * a top-level HTTP request without path in order to check if the server supports HTTPS or not
 * This is done to avoid waiting for a timeout which takes 90 seconds
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1642387,1660945 ***/
user_pref("dom.security.https_only_mode_send_http_background_request", false);

/** UI (User Interface) ***/
/* 1270: display warning on the padlock for "broken security" (if 1201 is false)
 * Bug: warning padlock not indicated for subresources on a secure page! [2]
 * [1] https://wiki.mozilla.org/Security:Renegotiation
 * [2] https://bugzilla.mozilla.org/1353705 ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
/* 1272: display advanced information on Insecure Connection warning pages
 * only works when it's possible to add an exception
 * i.e. it doesn't work for HSTS discrepancies (https://subdomain.preloaded-hsts.badssl.com/)
 * [TEST] https://expired.badssl.com/ ***/
user_pref("browser.xul.error_pages.expert_bad_cert", true);

/*** [SECTION 1600]: REFERERS
                  full URI: https://example.com:8888/foo/bar.html?id=1234
     scheme+host+port+path: https://example.com:8888/foo/bar.html
          scheme+host+port: https://example.com:8888
   [1] https://feeding.cloud.geek.nz/posts/tweaking-referrer-for-privacy-in-firefox/
***/
user_pref("_user.js.parrot", "1600 syntax error: the parrot rests in peace!");
/* 1602: control the amount of cross-origin information to send [FF52+]
 * 0=send full URI (default), 1=scheme+host+port+path, 2=scheme+host+port ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/*** [SECTION 1700]: CONTAINERS ***/
user_pref("_user.js.parrot", "1700 syntax error: the parrot's bit the dust!");
/* 1701: enable Container Tabs and its UI setting [FF50+]
 * [SETTING] General>Tabs>Enable Container Tabs
 * https://wiki.mozilla.org/Security/Contextual_Identity_Project/Containers ***/
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);
/* 1702: set behavior on "+ Tab" button to display container menu on left click [FF74+]
 * [NOTE] The menu is always shown on long press and right click
 * [SETTING] General>Tabs>Enable Container Tabs>Settings>Select a container for each new tab ***/
   // user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", true);
/* 1703: set external links to open in site-specific containers [FF123+]
 * [SETUP-WEB] Depending on your container extension(s) and their settings
 * true=Firefox will not choose a container (so your extension can)
 * false=Firefox will choose the container/no-container (default)
 * [1] https://bugzilla.mozilla.org/1874599 ***/
   // user_pref("browser.link.force_default_user_context_id_for_external_opens", true);

/*** [SECTION 2000]: PLUGINS / MEDIA / WEBRTC ***/
user_pref("_user.js.parrot", "2000 syntax error: the parrot's snuffed it!");
/* 2002: force WebRTC inside the proxy [FF70+] ***/
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
/* 2003: force a single network interface for ICE candidates generation [FF42+]
 * When using a system-wide proxy, it uses the proxy interface
 * [1] https://developer.mozilla.org/en-US/docs/Web/API/RTCIceCandidate
 * [2] https://wiki.mozilla.org/Media/WebRTC/Privacy ***/
user_pref("media.peerconnection.ice.default_address_only", true);
/* 2004: force exclusion of private IPs from ICE candidates [FF51+]
 * [SETUP-HARDEN] This will protect your private IP even in TRUSTED scenarios after you
 * grant device access, but often results in breakage on video-conferencing platforms ***/
   // user_pref("media.peerconnection.ice.no_host", true);
/* 2020: disable GMP (Gecko Media Plugins)
 * [1] https://wiki.mozilla.org/GeckoMediaPlugins ***/
   // user_pref("media.gmp-provider.enabled", false);

/*** [SECTION 2400]: DOM (DOCUMENT OBJECT MODEL) ***/
user_pref("_user.js.parrot", "2400 syntax error: the parrot's kicked the bucket!");
/* 2402: prevent scripts from moving and resizing open windows ***/
user_pref("dom.disable_window_move_resize", true);

/*** [SECTION 2600]: MISCELLANEOUS ***/
user_pref("_user.js.parrot", "2600 syntax error: the parrot's run down the curtain!");
/* 2603: remove temp files opened from non-PB windows with an external application
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=302433,1738574 ***/
user_pref("browser.download.start_downloads_in_tmp_dir", true); // [FF102+]
user_pref("browser.helperApps.deleteTempFileOnExit", true);
/* 2606: disable UITour backend so there is no chance that a remote page can use it ***/
user_pref("browser.uitour.enabled", false);
   // user_pref("browser.uitour.url", ""); // Defense-in-depth
/* 2608: reset remote debugging to disabled
 * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222 ***/
user_pref("devtools.debugger.remote-enabled", false); // [DEFAULT: false]
/* 2615: disable websites overriding Firefox's keyboard shortcuts [FF58+]
 * 0 (default) or 1=allow, 2=block
 * [SETTING] to add site exceptions: Ctrl+I>Permissions>Override Keyboard Shortcuts ***/
   // user_pref("permissions.default.shortcuts", 2);
/* 2616: remove special permissions for certain mozilla domains [FF35+]
 * [1] resource://app/defaults/permissions ***/
user_pref("permissions.manager.defaultsUrl", "");
/* 2617: remove webchannel whitelist ***/
user_pref("webchannel.allowObject.urlWhitelist", "");
/* 2619: use Punycode in Internationalized Domain Names to eliminate possible spoofing
 * [SETUP-WEB] Might be undesirable for non-latin alphabet users since legitimate IDN's are also punycoded
 * [TEST] https://www.xn--80ak6aa92e.com/ (www.apple.com)
 * [1] https://wiki.mozilla.org/IDN_Display_Algorithm
 * [2] https://en.wikipedia.org/wiki/IDN_homograph_attack
 * [3] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=punycode+firefox
 * [4] https://www.xudongz.com/blog/2017/idn-phishing/ ***/
user_pref("network.IDN_show_punycode", true);
/* 2620: enforce PDFJS, disable PDFJS scripting
 * This setting controls if the option "Display in Firefox" is available in the setting below
 *   and by effect controls whether PDFs are handled in-browser or externally ("Ask" or "Open With")
 * [WHY] pdfjs is lightweight, open source, and secure: the last exploit was June 2015 [1]
 *   It doesn't break "state separation" of browser content (by not sharing with OS, independent apps).
 *   It maintains disk avoidance and application data isolation. It's convenient. You can still save to disk.
 * [NOTE] JS can still force a pdf to open in-browser by bundling its own code
 * [SETUP-CHROME] You may prefer a different pdf reader for security/workflow reasons
 * [SETTING] General>Applications>Portable Document Format (PDF)
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=pdf.js+firefox ***/
user_pref("pdfjs.disabled", false); // [DEFAULT: false]
user_pref("pdfjs.enableScripting", false); // [FF86+]
/* 2624: disable middle click on new tab button opening URLs or searches using clipboard [FF115+] */
user_pref("browser.tabs.searchclipboardfor.middleclick", false); // [DEFAULT: false NON-LINUX]
/* 2630: disable content analysis by DLP (Data Loss Prevention) agents
 * DLP agents are background processes on managed computers that allow enterprises to monitor locally running
 * applications for data exfiltration events, which they can allow/block based on customer defined DLP policies.
 * [1] https://github.com/chromium/content_analysis_sdk */
user_pref("browser.contentanalysis.default_allow", false); // [FF124+] [DEFAULT: false]

/** DOWNLOADS ***/
/* 2651: enable user interaction for security by always asking where to download
 * [SETUP-CHROME] On Android this blocks longtapping and saving images
 * [SETTING] General>Downloads>Always ask you where to save files ***/
user_pref("browser.download.useDownloadDir", false);
/* 2652: disable downloads panel opening on every download [FF96+] ***/
user_pref("browser.download.alwaysOpenPanel", false);
/* 2653: disable adding downloads to the system's "recent documents" list ***/
user_pref("browser.download.manager.addToRecentDocs", false);
/* 2654: enable user interaction for security by always asking how to handle new mimetypes [FF101+]
 * [SETTING] General>Files and Applications>What should Firefox do with other files ***/
user_pref("browser.download.always_ask_before_handling_new_types", true);

/** EXTENSIONS ***/
/* 2660: limit allowed extension directories
 * 1=profile, 2=user, 4=application, 8=system, 16=temporary, 31=all
 * The pref value represents the sum: e.g. 5 would be profile and application directories
 * [SETUP-CHROME] Breaks usage of files which are installed outside allowed directories
 * [1] https://archive.is/DYjAM ***/
user_pref("extensions.enabledScopes", 5); // [HIDDEN PREF]
   // user_pref("extensions.autoDisableScopes", 15); // [DEFAULT: 15]
/* 2661: disable bypassing 3rd party extension install prompts [FF82+]
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1659530,1681331 ***/
user_pref("extensions.postDownloadThirdPartyPrompt", false);
/* 2662: disable webextension restrictions on certain mozilla domains (you also need 4503) [FF60+]
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1384330,1406795,1415644,1453988 ***/
   // user_pref("extensions.webextensions.restrictedDomains", "");

/*** [SECTION 2700]: ETP (ENHANCED TRACKING PROTECTION) ***/
user_pref("_user.js.parrot", "2700 syntax error: the parrot's joined the bleedin' choir invisible!");
/* 2701: enable ETP Strict Mode [FF86+]
 * ETP Strict Mode enables Total Cookie Protection (TCP)
 * [NOTE] Adding site exceptions disables all ETP protections for that site and increases the risk of
 * cross-site state tracking e.g. exceptions for SiteA and SiteB means PartyC on both sites is shared
 * [1] https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/
 * [SETTING] to add site exceptions: Urlbar>ETP Shield
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Enhanced Tracking Protection>Manage Exceptions ***/
user_pref("browser.contentblocking.category", "strict"); // [HIDDEN PREF]
/* 2702: disable ETP web compat features [FF93+]
 * [SETUP-HARDEN] Includes skip lists, heuristics (SmartBlock) and automatic grants
 * Opener and redirect heuristics are granted for 30 days, see [3]
 * [1] https://blog.mozilla.org/security/2021/07/13/smartblock-v2/
 * [2] https://hg.mozilla.org/mozilla-central/rev/e5483fd469ab#l4.12
 * [3] https://developer.mozilla.org/en-US/docs/Web/Privacy/State_Partitioning#storage_access_heuristics ***/
   // user_pref("privacy.antitracking.enableWebcompat", false);

/*** [SECTION 2800]: SHUTDOWN & SANITIZING ***/
user_pref("_user.js.parrot", "2800 syntax error: the parrot's bleedin' demised!");
/* 2810: enable Firefox to clear items on shutdown
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes | Settings ***/
user_pref("privacy.sanitize.sanitizeOnShutdown", true);

/** SANITIZE ON SHUTDOWN: IGNORES "ALLOW" SITE EXCEPTIONS | v2 migration is FF128+ ***/
/* 2811: set/enforce what items to clear on shutdown (if 2810 is true) [SETUP-CHROME]
 * [NOTE] If "history" is true, downloads will also be cleared ***/
user_pref("privacy.clearOnShutdown.cache", true);     // [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.cache", true);  // [FF128+] [DEFAULT: true]
user_pref("privacy.clearOnShutdown.downloads", true); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.formdata", true);  // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.history", true);   // [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true); // [FF128+] [DEFAULT: true]
   // user_pref("privacy.clearOnShutdown.siteSettings", false); // [DEFAULT: false]
   // user_pref("privacy.clearOnShutdown_v2.siteSettings", false); // [FF128+] [DEFAULT: false]
/* 2812: set Session Restore to clear on shutdown (if 2810 is true) [FF34+]
 * [NOTE] Not needed if Session Restore is not used (0102) or it is already cleared with history (2811)
 * [NOTE] If true, this prevents resuming from crashes (also see 5008) ***/
   // user_pref("privacy.clearOnShutdown.openWindows", true);

/** SANITIZE ON SHUTDOWN: RESPECTS "ALLOW" SITE EXCEPTIONS FF103+ | v2 migration is FF128+ ***/
/* 2815: set "Cookies" and "Site Data" to clear on shutdown (if 2810 is true) [SETUP-CHROME]
 * [NOTE] Exceptions: A "cookie" block permission also controls "offlineApps" (see note below).
 * serviceWorkers require an "Allow" permission. For cross-domain logins, add exceptions for
 * both sites e.g. https://www.youtube.com (site) + https://accounts.google.com (single sign on)
 * [NOTE] "offlineApps": Offline Website Data: localStorage, service worker cache, QuotaManager (IndexedDB, asm-cache)
 * [NOTE] "sessions": Active Logins (has no site exceptions): refers to HTTP Basic Authentication [1], not logins via cookies
 * [WARNING] Be selective with what sites you "Allow", as they also disable partitioning (1767271)
 * [SETTING] to add site exceptions: Ctrl+I>Permissions>Cookies>Allow (when on the website in question)
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings
 * [1] https://en.wikipedia.org/wiki/Basic_access_authentication ***/
user_pref("privacy.clearOnShutdown.cookies", true); // Cookies
user_pref("privacy.clearOnShutdown.offlineApps", true); // Site Data
user_pref("privacy.clearOnShutdown.sessions", true);  // Active Logins [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true); // Cookies, Site Data, Active Logins [FF128+]

/** SANITIZE SITE DATA: IGNORES "ALLOW" SITE EXCEPTIONS ***/
/* 2820: set manual "Clear Data" items [SETUP-CHROME] [FF128+]
 * Firefox remembers your last choices. This will reset them when you start Firefox
 * [SETTING] Privacy & Security>Browser Privacy>Cookies and Site Data>Clear Data ***/
user_pref("privacy.clearSiteData.cache", true);
user_pref("privacy.clearSiteData.cookiesAndStorage", false); // keep false until it respects "allow" site exceptions
user_pref("privacy.clearSiteData.historyFormDataAndDownloads", true);
   // user_pref("privacy.clearSiteData.siteSettings", false);

/** SANITIZE HISTORY: IGNORES "ALLOW" SITE EXCEPTIONS | clearHistory migration is FF128+ ***/
/* 2830: set manual "Clear History" items, also via Ctrl-Shift-Del [SETUP-CHROME]
 * Firefox remembers your last choices. This will reset them when you start Firefox
 * [NOTE] Regardless of what you set "downloads" to, as soon as the dialog
 * for "Clear Recent History" is opened, it is synced to the same as "history"
 * [SETTING] Privacy & Security>History>Custom Settings>Clear History ***/
user_pref("privacy.cpd.cache", true);    // [DEFAULT: true]
user_pref("privacy.clearHistory.cache", true);
user_pref("privacy.cpd.formdata", true); // [DEFAULT: true]
user_pref("privacy.cpd.history", true);  // [DEFAULT: true]
   // user_pref("privacy.cpd.downloads", true); // not used, see note above
user_pref("privacy.clearHistory.historyFormDataAndDownloads", true);
user_pref("privacy.cpd.cookies", false);
user_pref("privacy.cpd.sessions", true); // [DEFAULT: true]
user_pref("privacy.cpd.offlineApps", false); // [DEFAULT: false]
user_pref("privacy.clearHistory.cookiesAndStorage", false);
   // user_pref("privacy.cpd.openWindows", false); // Session Restore
   // user_pref("privacy.cpd.passwords", false);
   // user_pref("privacy.cpd.siteSettings", false);
   // user_pref("privacy.clearHistory.siteSettings", false);

/** SANITIZE MANUAL: TIMERANGE ***/
/* 2840: set "Time range to clear" for "Clear Data" (2820) and "Clear History" (2830)
 * Firefox remembers your last choice. This will reset the value when you start Firefox
 * 0=everything, 1=last hour, 2=last two hours, 3=last four hours, 4=today
 * [NOTE] Values 5 (last 5 minutes) and 6 (last 24 hours) are not listed in the dropdown,
 * which will display a blank value, and are not guaranteed to work ***/
user_pref("privacy.sanitize.timeSpan", 0);

/*** [SECTION 4000]: FPP (fingerprintingProtection)
   RFP (4501) overrides FPP

   In FF118+ FPP is on by default in private windows (4001) and in FF119+ is controlled
   by ETP (2701). FPP will also use Remote Services in future to relax FPP protections
   on a per site basis for compatibility (4003).

   1826408 - restrict fonts to system (kBaseFonts + kLangPackFonts) (Windows, Mac, some Linux)
      https://searchfox.org/mozilla-central/search?path=StandardFonts*.inc
   1858181 - subtly randomize canvas per eTLD+1, per session and per window-mode (FF120+)
***/
user_pref("_user.js.parrot", "4000 syntax error: the parrot's bereft of life!");
/* 4001: enable FPP in PB mode [FF114+]
 * [NOTE] In FF119+, FPP for all modes (7016) is enabled with ETP Strict (2701) ***/
   // user_pref("privacy.fingerprintingProtection.pbmode", true); // [DEFAULT: true FF118+]
/* 4002: set global FPP overrides [FF114+]
 * Controls what protections FPP uses globally, including "RFPTargets" (despite the name these are
 * not used by RFP) e.g. "+AllTargets,-CSSPrefersColorScheme" or "-AllTargets,+CanvasRandomization"
 * [NOTE] Be aware that not all RFP protections are necessarily in RFPTargets
 * [WARNING] Not recommended. Either use RFP or FPP at defaults
 * [1] https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc ***/
   // user_pref("privacy.fingerprintingProtection.overrides", "");
/* 4003: disable remote FPP overrides [FF127+] ***/
   // user_pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);

/*** [SECTION 4500]: RFP (resistFingerprinting)
   RFP overrides FPP (4000)

   It is an all-or-nothing buy in: you cannot pick and choose what parts you want
   [TEST] https://arkenfox.github.io/TZP/tzp.html

   [WARNING] DO NOT USE extensions to alter RFP protected metrics

    418986 - limit window.screen & CSS media queries (FF41)
   1281949 - spoof screen orientation (FF50)
   1360039 - spoof navigator.hardwareConcurrency as 2 (FF55)
 FF56
   1333651 - spoof User Agent & Navigator API
      version: android version spoofed as ESR (FF119 or lower)
      OS: JS spoofed as Windows 10, OS 10.15, Android 10, or Linux | HTTP Headers spoofed as Windows or Android
   1369319 - disable device sensor API
   1369357 - disable site specific zoom
   1337161 - hide gamepads from content
   1372072 - spoof network information API as "unknown" when dom.netinfo.enabled = true
   1333641 - reduce fingerprinting in WebSpeech API
 FF57
   1369309 - spoof media statistics
   1382499 - reduce screen co-ordinate fingerprinting in Touch API
   1217290 & 1409677 - enable some fingerprinting resistance for WebGL
   1354633 - limit MediaError.message to a whitelist
 FF58+
   1372073 - spoof/block fingerprinting in MediaDevices API (FF59)
      Spoof: enumerate devices as one "Internal Camera" and one "Internal Microphone"
      Block: suppresses the ondevicechange event
   1039069 - warn when language prefs are not set to "en*" (FF59)
   1222285 & 1433592 - spoof keyboard events and suppress keyboard modifier events (FF59)
      Spoofing mimics the content language of the document. Currently it only supports en-US.
      Modifier events suppressed are SHIFT and both ALT keys. Chrome is not affected.
   1337157 - disable WebGL debug renderer info (FF60)
   1459089 - disable OS locale in HTTP Accept-Language headers (ANDROID) (FF62)
   1479239 - return "no-preference" with prefers-reduced-motion (FF63)
   1363508 - spoof/suppress Pointer Events (FF64)
   1492766 - spoof pointerEvent.pointerid (FF65)
   1485266 - disable exposure of system colors to CSS or canvas (FF67)
   1494034 - return "light" with prefers-color-scheme (FF67)
   1564422 - spoof audioContext outputLatency (FF70)
   1595823 - return audioContext sampleRate as 44100 (FF72)
   1607316 - spoof pointer as coarse and hover as none (ANDROID) (FF74)
   1621433 - randomize canvas (previously FF58+ returned an all-white canvas) (FF78)
   1506364 - return "no-preference" with prefers-contrast (FF80)
   1653987 - limit font visibility to bundled and "Base Fonts" (Windows, Mac, some Linux) (FF80)
   1461454 - spoof smooth=true and powerEfficient=false for supported media in MediaCapabilities (FF82)
    531915 - use fdlibm's sin, cos and tan in jsmath (FF93, ESR91.1)
   1756280 - enforce navigator.pdfViewerEnabled as true and plugins/mimeTypes as hard-coded values (FF100-115)
   1692609 - reduce JS timing precision to 16.67ms (previously FF55+ was 100ms) (FF102)
   1422237 - return "srgb" with color-gamut (FF110)
   1794628 - return "none" with inverted-colors (FF114)
   1554751 - return devicePixelRatio as 2 (previously FF41+ was 1) (FF127)
   1787790 - normalize system fonts (FF128)
   1835987 - spoof timezone as Atlantic/Reykjavik (previously FF55+ was UTC) (FF128)
***/
user_pref("_user.js.parrot", "4500 syntax error: the parrot's popped 'is clogs");
/* 4501: enable RFP
 * [SETUP-WEB] RFP can cause some website breakage: mainly canvas, use a canvas site exception via the urlbar.
 * RFP also has a few side effects: mainly timezone is UTC, and websites will prefer light theme
 * [NOTE] pbmode applies if true and the original pref is false
 * [1] https://bugzilla.mozilla.org/418986 ***/
user_pref("privacy.resistFingerprinting", true); // [FF41+]
   // user_pref("privacy.resistFingerprinting.pbmode", true); // [FF114+]
/* 4502: set new window size rounding max values [FF55+]
 * [SETUP-CHROME] sizes round down in hundreds: width to 200s and height to 100s, to fit your screen
 * [1] https://bugzilla.mozilla.org/1330882 ***/
user_pref("privacy.window.maxInnerWidth", 1600);
user_pref("privacy.window.maxInnerHeight", 900);
/* 4503: disable mozAddonManager Web API [FF57+]
 * [NOTE] To allow extensions to work on AMO, you also need 2662
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1384330,1406795,1415644,1453988 ***/
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);
/* 4504: enable RFP letterboxing [FF67+]
 * Dynamically resizes the inner window by applying margins in stepped ranges [2]
 * If you use the dimension pref, then it will only apply those resolutions.
 * The format is "width1xheight1, width2xheight2, ..." (e.g. "800x600, 1000x1000")
 * [SETUP-WEB] This is independent of RFP (4501). If you're not using RFP, or you are but
 * dislike the margins, then flip this pref, keeping in mind that it is effectively fingerprintable
 * [WARNING] DO NOT USE: the dimension pref is only meant for testing
 * [1] https://bugzilla.mozilla.org/1407366
 * [2] https://hg.mozilla.org/mozilla-central/rev/6d2d7856e468#l2.32 ***/
user_pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN PREF]
   // user_pref("privacy.resistFingerprinting.letterboxing.dimensions", ""); // [HIDDEN PREF]
/* 4505: experimental RFP [FF91+]
 * [WARNING] DO NOT USE unless testing, see [1] comment 12
 * [1] https://bugzilla.mozilla.org/1635603 ***/
   // user_pref("privacy.resistFingerprinting.exemptedDomains", "*.example.invalid");
/* 4506: disable RFP spoof english prompt [FF59+]
 * 0=prompt, 1=disabled, 2=enabled (requires RFP)
 * [NOTE] When changing from value 2, preferred languages ('intl.accept_languages') is not reset.
 * [SETUP-WEB] when enabled, sets 'en-US, en' for displaying pages and 'en-US' as locale.
 * [SETTING] General>Language>Choose your preferred language for displaying pages>Choose>Request English... ***/
user_pref("privacy.spoof_english", 1);
/* 4510: disable using system colors
 * [SETTING] General>Language and Appearance>Fonts and Colors>Colors>Use system colors ***/
user_pref("browser.display.use_system_colors", false); // [DEFAULT: false NON-WINDOWS]
/* 4511: enforce non-native widget theme
 * Security: removes/reduces system API calls, e.g. win32k API [1]
 * Fingerprinting: provides a uniform look and feel across platforms [2]
 * [1] https://bugzilla.mozilla.org/1381938
 * [2] https://bugzilla.mozilla.org/1411425 ***/
user_pref("widget.non-native-theme.enabled", true); // [DEFAULT: true]
/* 4512: enforce links targeting new windows to open in a new tab instead
 * 1=most recent window or tab, 2=new window, 3=new tab
 * Stops malicious window sizes and some screen resolution leaks.
 * You can still right-click a link and open in a new window
 * [SETTING] General>Tabs>Open links in tabs instead of new windows
 * [TEST] https://arkenfox.github.io/TZP/tzp.html#screen
 * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881 ***/
user_pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
/* 4513: set all open window methods to abide by "browser.link.open_newwindow" (4512)
 * [1] https://searchfox.org/mozilla-central/source/dom/tests/browser/browser_test_new_window_from_content.js ***/
user_pref("browser.link.open_newwindow.restriction", 0);
/* 4520: disable WebGL (Web Graphics Library)
 * [SETUP-WEB] If you need it then override it. RFP still randomizes canvas for naive scripts ***/
user_pref("webgl.disabled", true);

/*** [SECTION 5000]: OPTIONAL OPSEC
   Disk avoidance, application data isolation, eyeballs...
***/
user_pref("_user.js.parrot", "5000 syntax error: the parrot's taken 'is last bow");
/* 5001: start Firefox in PB (Private Browsing) mode
 * [NOTE] In this mode all windows are "private windows" and the PB mode icon is not displayed
 * [NOTE] The P in PB mode can be misleading: it means no "persistent" disk state such as history,
 * caches, searches, cookies, localStorage, IndexedDB etc (which you can achieve in normal mode).
 * In fact, PB mode limits or removes the ability to control some of these, and you need to quit
 * Firefox to clear them. PB is best used as a one off window (Menu>New Private Window) to provide
 * a temporary self-contained new session. Close all private windows to clear the PB session.
 * [SETTING] Privacy & Security>History>Custom Settings>Always use private browsing mode
 * [1] https://wiki.mozilla.org/Private_Browsing
 * [2] https://support.mozilla.org/kb/common-myths-about-private-browsing ***/
   // user_pref("browser.privatebrowsing.autostart", true);
/* 5002: disable memory cache
 * capacity: -1=determine dynamically (default), 0=none, n=memory capacity in kibibytes ***/
   // user_pref("browser.cache.memory.enable", false);
   // user_pref("browser.cache.memory.capacity", 0);
/* 5003: disable saving passwords
 * [NOTE] This does not clear any passwords already saved
 * [SETTING] Privacy & Security>Logins and Passwords>Ask to save logins and passwords for websites ***/
   // user_pref("signon.rememberSignons", false);
/* 5004: disable permissions manager from writing to disk [FF41+] [RESTART]
 * [NOTE] This means any permission changes are session only
 * [1] https://bugzilla.mozilla.org/967812 ***/
   // user_pref("permissions.memory_only", true); // [HIDDEN PREF]
/* 5005: disable intermediate certificate caching [FF41+] [RESTART]
 * [NOTE] This affects login/cert/key dbs. The effect is all credentials are session-only.
 * Saved logins and passwords are not available. Reset the pref and restart to return them ***/
   // user_pref("security.nocertdb", true);
/* 5006: disable favicons in history and bookmarks
 * [NOTE] Stored as data blobs in favicons.sqlite, these don't reveal anything that your
 * actual history (and bookmarks) already do. Your history is more detailed, so
 * control that instead; e.g. disable history, clear history on exit, use PB mode
 * [NOTE] favicons.sqlite is sanitized on Firefox close ***/
   // user_pref("browser.chrome.site_icons", false);
/* 5007: exclude "Undo Closed Tabs" in Session Restore ***/
   // user_pref("browser.sessionstore.max_tabs_undo", 0);
/* 5008: disable resuming session from crash
 * [TEST] about:crashparent ***/
   // user_pref("browser.sessionstore.resume_from_crash", false);
/* 5009: disable "open with" in download dialog [FF50+]
 * Application data isolation [1]
 * [1] https://bugzilla.mozilla.org/1281959 ***/
   // user_pref("browser.download.forbid_open_with", true);
/* 5010: disable location bar suggestion types
 * [SETTING] Search>Address Bar>When using the address bar, suggest ***/
   // user_pref("browser.urlbar.suggest.history", false);
   // user_pref("browser.urlbar.suggest.bookmark", false);
   // user_pref("browser.urlbar.suggest.openpage", false);
   // user_pref("browser.urlbar.suggest.topsites", false); // [FF78+]
/* 5011: disable location bar dropdown
 * This value controls the total number of entries to appear in the location bar dropdown ***/
   // user_pref("browser.urlbar.maxRichResults", 0);
/* 5012: disable location bar autofill
 * [1] https://support.mozilla.org/kb/address-bar-autocomplete-firefox#w_url-autocomplete ***/
   // user_pref("browser.urlbar.autoFill", false);
/* 5013: disable browsing and download history
 * [NOTE] We also clear history and downloads on exit (2811)
 * [SETTING] Privacy & Security>History>Custom Settings>Remember browsing and download history ***/
   // user_pref("places.history.enabled", false);
/* 5014: disable Windows jumplist [WINDOWS] ***/
   // user_pref("browser.taskbar.lists.enabled", false);
   // user_pref("browser.taskbar.lists.frequent.enabled", false);
   // user_pref("browser.taskbar.lists.recent.enabled", false);
   // user_pref("browser.taskbar.lists.tasks.enabled", false);
/* 5016: discourage downloading to desktop
 * 0=desktop, 1=downloads (default), 2=custom
 * [SETTING] To set your custom default "downloads": General>Downloads>Save files to ***/
   // user_pref("browser.download.folderList", 2);
/* 5017: disable Form Autofill
 * If .supportedCountries includes your region (browser.search.region) and .supported
 * is "detect" (default), then the UI will show. Stored data is not secure, uses JSON
 * [SETTING] Privacy & Security>Forms and Autofill>Autofill addresses
 * [1] https://wiki.mozilla.org/Firefox/Features/Form_Autofill ***/
   // user_pref("extensions.formautofill.addresses.enabled", false); // [FF55+]
   // user_pref("extensions.formautofill.creditCards.enabled", false); // [FF56+]
/* 5018: limit events that can cause a pop-up ***/
   // user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown");
/* 5019: disable page thumbnail collection ***/
   // user_pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN PREF]
/* 5020: disable Windows native notifications and use app notications instead [FF111+] [WINDOWS] ***/
   // user_pref("alerts.useSystemBackend.windows.notificationserver.enabled", false);
/* 5021: disable location bar using search
 * Don't leak URL typos to a search engine, give an error message instead
 * Examples: "secretplace,com", "secretplace/com", "secretplace com", "secret place.com"
 * [NOTE] This does not affect explicit user action such as using search buttons in the
 * dropdown, or using keyword search shortcuts you configure in options (e.g. "d" for DuckDuckGo) ***/
   // user_pref("keyword.enabled", false);

/*** [SECTION 5500]: OPTIONAL HARDENING
   Not recommended. Overriding these can cause breakage and performance issues,
   they are mostly fingerprintable, and the threat model is practically nonexistent
***/
user_pref("_user.js.parrot", "5500 syntax error: this is an ex-parrot!");
/* 5501: disable MathML (Mathematical Markup Language) [FF51+]
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml ***/
   // user_pref("mathml.disabled", true); // 1173199
/* 5502: disable in-content SVG (Scalable Vector Graphics) [FF53+]
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg ***/
   // user_pref("svg.disabled", true); // 1216893
/* 5503: disable graphite
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite
 * [2] https://en.wikipedia.org/wiki/Graphite_(SIL) ***/
   // user_pref("gfx.font_rendering.graphite.enabled", false);
/* 5504: disable asm.js [FF22+]
 * [1] http://asmjs.org/
 * [2] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=asm.js
 * [3] https://rh0dev.github.io/blog/2017/the-return-of-the-jit/ ***/
   // user_pref("javascript.options.asmjs", false);
/* 5505: disable Ion and baseline JIT to harden against JS exploits
 * [NOTE] When both Ion and JIT are disabled, and trustedprincipals
 * is enabled, then Ion can still be used by extensions (1599226)
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+jit
 * [2] https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/ ***/
   // user_pref("javascript.options.ion", false);
   // user_pref("javascript.options.baselinejit", false);
   // user_pref("javascript.options.jit_trustedprincipals", true); // [FF75+] [HIDDEN PREF]
/* 5506: disable WebAssembly [FF52+]
 * Vulnerabilities [1] have increasingly been found, including those known and fixed
 * in native programs years ago [2]. WASM has powerful low-level access, making
 * certain attacks (brute-force) and vulnerabilities more possible
 * [STATS] ~0.2% of websites, about half of which are for cryptomining / malvertising [2][3]
 * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=wasm
 * [2] https://spectrum.ieee.org/tech-talk/telecom/security/more-worries-over-the-security-of-web-assembly
 * [3] https://www.zdnet.com/article/half-of-the-websites-using-webassembly-use-it-for-malicious-purposes ***/
   // user_pref("javascript.options.wasm", false);
/* 5507: disable rendering of SVG OpenType fonts ***/
   // user_pref("gfx.font_rendering.opentype_svg.enabled", false);
/* 5508: disable all DRM content (EME: Encryption Media Extension)
 * Optionally hide the UI setting which also disables the DRM prompt
 * [SETTING] General>DRM Content>Play DRM-controlled content
 * [TEST] https://bitmovin.com/demos/drm
 * [1] https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next ***/
   // user_pref("media.eme.enabled", false);
   // user_pref("browser.eme.ui.enabled", false);
/* 5509: disable IPv6 if using a VPN
 * This is an application level fallback. Disabling IPv6 is best done at an OS/network
 * level, and/or configured properly in system wide VPN setups.
 * [SETUP-WEB] PR_CONNECT_RESET_ERROR
 * [NOTE] PHP defaults to IPv6 with "localhost". Use "php -S 127.0.0.1:PORT"
 * [TEST] https://ipleak.org/
 * [1] https://www.internetsociety.org/tag/ipv6-security/ (Myths 2,4,5,6) ***/
   // user_pref("network.dns.disableIPv6", true);
/* 5510: control when to send a cross-origin referer
 * 0=always (default), 1=only if base domains match, 2=only if hosts match
 * [NOTE] Will cause breakage: older modems/routers and some sites e.g banks, vimeo, icloud, instagram ***/
   // user_pref("network.http.referer.XOriginPolicy", 2);
/* 5511: set DoH bootstrap address [FF89+]
 * Firefox uses the system DNS to initially resolve the IP address of your DoH server.
 * When set to a valid, working value that matches your "network.trr.uri" (0712) Firefox
 * won't use the system DNS. If the IP doesn't match then DoH won't work ***/
   // user_pref("network.trr.bootstrapAddr", "10.0.0.1"); // [HIDDEN PREF]

/*** [SECTION 6000]: DON'T TOUCH ***/
user_pref("_user.js.parrot", "6000 syntax error: the parrot's 'istory!");
/* 6001: enforce Firefox blocklist
 * [WHY] It includes updates for "revoked certificates"
 * [1] https://blog.mozilla.org/security/2015/03/03/revoking-intermediate-certificates-introducing-onecrl/ ***/
user_pref("extensions.blocklist.enabled", true); // [DEFAULT: true]
/* 6002: enforce no referer spoofing
 * [WHY] Spoofing can affect CSRF (Cross-Site Request Forgery) protections ***/
user_pref("network.http.referer.spoofSource", false); // [DEFAULT: false]
/* 6004: enforce a security delay on some confirmation dialogs such as install, open/save
 * [1] https://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/ ***/
user_pref("security.dialog_enable_delay", 1000); // [DEFAULT: 1000]
/* 6008: enforce no First Party Isolation [FF51+]
 * [WARNING] Replaced with network partitioning (FF85+) and TCP (2701), and enabling FPI
 * disables those. FPI is no longer maintained except at Tor Project for Tor Browser's config ***/
user_pref("privacy.firstparty.isolate", false); // [DEFAULT: false]
/* 6009: enforce SmartBlock shims (about:compat) [FF81+]
 * [1] https://blog.mozilla.org/security/2021/03/23/introducing-smartblock/ ***/
user_pref("extensions.webcompat.enable_shims", true); // [HIDDEN PREF] [DEFAULT: true]
/* 6010: enforce no TLS 1.0/1.1 downgrades
 * [TEST] https://tls-v1-1.badssl.com:1010/ ***/
user_pref("security.tls.version.enable-deprecated", false); // [DEFAULT: false]
/* 6011: enforce disabling of Web Compatibility Reporter [FF56+]
 * Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla
 * [WHY] To prevent wasting Mozilla's time with a custom setup ***/
user_pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT: false]
/* 6012: enforce Quarantined Domains [FF115+]
 * [WHY] https://support.mozilla.org/kb/quarantined-domains */
user_pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT: true]
/* 6050: prefsCleaner: previously active items removed from arkenfox 115-127 ***/
   // user_pref("accessibility.force_disabled", "");
   // user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", "");
   // user_pref("network.protocol-handler.external.ms-windows-store", "");
   // user_pref("privacy.partition.always_partition_third_party_non_cookie_storage", "");
   // user_pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", "");
   // user_pref("privacy.partition.serviceWorkers", "");

/*** [SECTION 7000]: DON'T BOTHER ***/
user_pref("_user.js.parrot", "7000 syntax error: the parrot's pushing up daisies!");
/* 7001: disable APIs
 * Location-Aware Browsing, Full Screen
 * [WHY] The API state is easily fingerprintable.
 * Geo is behind a prompt (7002). Full screen requires user interaction ***/
   // user_pref("geo.enabled", false);
   // user_pref("full-screen-api.enabled", false);
/* 7002: set default permissions
 * Location, Camera, Microphone, Notifications [FF58+] Virtual Reality [FF73+]
 * 0=always ask (default), 1=allow, 2=block
 * [WHY] These are fingerprintable via Permissions API, except VR. Just add site
 * exceptions as allow/block for frequently visited/annoying sites: i.e. not global
 * [SETTING] to add site exceptions: Ctrl+I>Permissions>
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings ***/
   // user_pref("permissions.default.geo", 0);
   // user_pref("permissions.default.camera", 0);
   // user_pref("permissions.default.microphone", 0);
   // user_pref("permissions.default.desktop-notification", 0);
   // user_pref("permissions.default.xr", 0); // Virtual Reality
/* 7003: disable non-modern cipher suites [1]
 * [WHY] Passive fingerprinting. Minimal/non-existent threat of downgrade attacks
 * [1] https://browserleaks.com/ssl ***/
   // user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false);
   // user_pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false);
   // user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false);
   // user_pref("security.ssl3.ecdhe_rsa_aes_256_sha", false);
   // user_pref("security.ssl3.rsa_aes_128_gcm_sha256", false); // no PFS
   // user_pref("security.ssl3.rsa_aes_256_gcm_sha384", false); // no PFS
   // user_pref("security.ssl3.rsa_aes_128_sha", false); // no PFS
   // user_pref("security.ssl3.rsa_aes_256_sha", false); // no PFS
/* 7004: control TLS versions
 * [WHY] Passive fingerprinting and security ***/
   // user_pref("security.tls.version.min", 3); // [DEFAULT: 3]
   // user_pref("security.tls.version.max", 4);
/* 7005: disable SSL session IDs [FF36+]
 * [WHY] Passive fingerprinting and perf costs. These are session-only
 * and isolated with network partitioning (FF85+) and/or containers ***/
   // user_pref("security.ssl.disable_session_identifiers", true);
/* 7006: onions
 * [WHY] Firefox doesn't support hidden services. Use Tor Browser ***/
   // user_pref("dom.securecontext.allowlist_onions", true); // [FF97+] 1382359/1744006
   // user_pref("network.http.referer.hideOnionSource", true); // 1305144
/* 7007: referers
 * [WHY] Only cross-origin referers (1602, 5510) matter ***/
   // user_pref("network.http.sendRefererHeader", 2);
   // user_pref("network.http.referer.trimmingPolicy", 0);
/* 7008: set the default Referrer Policy [FF59+]
 * 0=no-referer, 1=same-origin, 2=strict-origin-when-cross-origin, 3=no-referrer-when-downgrade
 * [WHY] Defaults are fine. They can be overridden by a site-controlled Referrer Policy ***/
   // user_pref("network.http.referer.defaultPolicy", 2); // [DEFAULT: 2]
   // user_pref("network.http.referer.defaultPolicy.pbmode", 2); // [DEFAULT: 2]
/* 7010: disable HTTP Alternative Services [FF37+]
 * [WHY] Already isolated with network partitioning (FF85+) ***/
   // user_pref("network.http.altsvc.enabled", false);
/* 7011: disable website control over browser right-click context menu
 * [WHY] Just use Shift-Right-Click ***/
   // user_pref("dom.event.contextmenu.enabled", false);
/* 7012: disable icon fonts (glyphs) and local fallback rendering
 * [WHY] Breakage, font fallback is equivalency, also RFP
 * [1] https://bugzilla.mozilla.org/789788
 * [2] https://gitlab.torproject.org/legacy/trac/-/issues/8455 ***/
   // user_pref("gfx.downloadable_fonts.enabled", false); // [FF41+]
   // user_pref("gfx.downloadable_fonts.fallback_delay", -1);
/* 7013: disable Clipboard API
 * [WHY] Fingerprintable. Breakage. Cut/copy/paste require user
 * interaction, and paste is limited to focused editable fields ***/
   // user_pref("dom.event.clipboardevents.enabled", false);
/* 7014: disable System Add-on updates
 * [WHY] It can compromise security. System addons ship with prefs, use those ***/
   // user_pref("extensions.systemAddon.update.enabled", false); // [FF62+]
   // user_pref("extensions.systemAddon.update.url", ""); // [FF44+]
/* 7015: enable the DNT (Do Not Track) HTTP header
 * [WHY] DNT is enforced with Tracking Protection which is used in ETP Strict (2701) ***/
   // user_pref("privacy.donottrackheader.enabled", true);
/* 7016: customize ETP settings
 * [NOTE] FPP (fingerprintingProtection) is ignored when RFP (4501) is enabled
 * [WHY] Arkenfox only supports strict (2701) which sets these at runtime ***/
   // user_pref("network.cookie.cookieBehavior", 5); // [DEFAULT: 5]
   // user_pref("privacy.fingerprintingProtection", true); // [FF114+] [ETP FF119+]
   // user_pref("network.http.referer.disallowCrossSiteRelaxingDefault", true);
   // user_pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true); // [FF100+]
   // user_pref("privacy.partition.network_state.ocsp_cache", true); // [DEFAULT: true FF123+]
   // user_pref("privacy.query_stripping.enabled", true); // [FF101+]
   // user_pref("privacy.trackingprotection.enabled", true);
   // user_pref("privacy.trackingprotection.socialtracking.enabled", true);
   // user_pref("privacy.trackingprotection.cryptomining.enabled", true); // [DEFAULT: true]
   // user_pref("privacy.trackingprotection.fingerprinting.enabled", true); // [DEFAULT: true]
/* 7017: disable service workers
 * [WHY] Already isolated with TCP (2701) behind a pref (2710) ***/
   // user_pref("dom.serviceWorkers.enabled", false);
/* 7018: disable Web Notifications [FF22+]
 * [WHY] Web Notifications are behind a prompt (7002)
 * [1] https://blog.mozilla.org/en/products/firefox/block-notification-requests/ ***/
   // user_pref("dom.webnotifications.enabled", false);
/* 7019: disable Push Notifications [FF44+]
 * [WHY] Website "push" requires subscription, and the API is required for CRLite (1224)
 * [NOTE] To remove all subscriptions, reset "dom.push.userAgentID"
 * [1] https://support.mozilla.org/kb/push-notifications-firefox ***/
   // user_pref("dom.push.enabled", false);
/* 7020: disable WebRTC (Web Real-Time Communication)
 * [WHY] Firefox desktop uses mDNS hostname obfuscation and the private IP is never exposed until
 * required in TRUSTED scenarios; i.e. after you grant device (microphone or camera) access
 * [TEST] https://browserleaks.com/webrtc
 * [1] https://groups.google.com/g/discuss-webrtc/c/6stQXi72BEU/m/2FwZd24UAQAJ
 * [2] https://datatracker.ietf.org/doc/html/draft-ietf-mmusic-mdns-ice-candidates#section-3.1.1 ***/
   // user_pref("media.peerconnection.enabled", false);
/* 7021: enable GPC (Global Privacy Control) in non-PB windows
 * [WHY] Passive and active fingerprinting. Mostly redundant with Tracking Protection
 * in ETP Strict (2701) and sanitizing on close (2800s) ***/
   // user_pref("privacy.globalprivacycontrol.enabled", true);

/*** [SECTION 8000]: DON'T BOTHER: FINGERPRINTING
   [WHY] They are insufficient to help anti-fingerprinting and do more harm than good
   [WARNING] DO NOT USE with RFP. RFP already covers these and they can interfere
***/
user_pref("_user.js.parrot", "8000 syntax error: the parrot's crossed the Jordan");
/* 8001: prefsCleaner: reset items useless for anti-fingerprinting ***/
   // user_pref("browser.display.use_document_fonts", "");
   // user_pref("browser.zoom.siteSpecific", "");
   // user_pref("device.sensors.enabled", "");
   // user_pref("dom.enable_performance", "");
   // user_pref("dom.enable_resource_timing", "");
   // user_pref("dom.gamepad.enabled", "");
   // user_pref("dom.maxHardwareConcurrency", "");
   // user_pref("dom.w3c_touch_events.enabled", "");
   // user_pref("dom.webaudio.enabled", "");
   // user_pref("font.system.whitelist", "");
   // user_pref("general.appname.override", "");
   // user_pref("general.appversion.override", "");
   // user_pref("general.buildID.override", "");
   // user_pref("general.oscpu.override", "");
   // user_pref("general.platform.override", "");
   // user_pref("general.useragent.override", "");
   // user_pref("media.navigator.enabled", "");
   // user_pref("media.ondevicechange.enabled", "");
   // user_pref("media.video_stats.enabled", "");
   // user_pref("media.webspeech.synth.enabled", "");
   // user_pref("ui.use_standins_for_native_colors", "");
   // user_pref("webgl.enable-debug-renderer-info", "");

/*** [SECTION 9000]: NON-PROJECT RELATED ***/
user_pref("_user.js.parrot", "9000 syntax error: the parrot's cashed in 'is chips!");
/* 9001: disable welcome notices ***/
user_pref("browser.startup.homepage_override.mstone", "ignore"); // [HIDDEN PREF]
/* 9002: disable General>Browsing>Recommend extensions/features as you browse [FF67+] ***/
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
/* 9004: disable search terms [FF110+]
 * [SETTING] Search>Search Bar>Use the address bar for search and navigation>Show search terms instead of URL... ***/
user_pref("browser.urlbar.showSearchTerms.enabled", false);

/*** [SECTION 9999]: DEPRECATED / RENAMED ***/
user_pref("_user.js.parrot", "9999 syntax error: the parrot's shuffled off 'is mortal coil!");
/* ESR115.x still uses all the following prefs
// [NOTE] replace the * with a slash in the line above to re-enable active ones
// FF116
// 4506: set RFP's font visibility level (1402) [FF94+]
   // [-] https://bugzilla.mozilla.org/1838415
   // user_pref("layout.css.font-visibility.resistFingerprinting", 1); // [DEFAULT: 1]
// FF117
// 1221: disable Windows Microsoft Family Safety cert [FF50+] [WINDOWS]
   // 0=disable detecting Family Safety mode and importing the root
   // 1=only attempt to detect Family Safety mode (don't import the root)
   // 2=detect Family Safety mode and import the root
   // [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/21686
   // [-] https://bugzilla.mozilla.org/1844908
user_pref("security.family_safety.mode", 0);
// 7018: disable service worker Web Notifications [FF44+]
   // [WHY] Web Notifications are behind a prompt (7002)
   // [1] https://blog.mozilla.org/en/products/firefox/block-notification-requests/
   // [-] https://bugzilla.mozilla.org/1842457
   // user_pref("dom.webnotifications.serviceworker.enabled", false);
// FF118
// 1402: limit font visibility (Windows, Mac, some Linux) [FF94+]
   // Uses hardcoded lists with two parts: kBaseFonts + kLangPackFonts [1], bundled fonts are auto-allowed
   // In normal windows: uses the first applicable: RFP over TP over Standard
   // In Private Browsing windows: uses the most restrictive between normal and private
   // 1=only base system fonts, 2=also fonts from optional language packs, 3=also user-installed fonts
   // [1] https://searchfox.org/mozilla-central/search?path=StandardFonts*.inc
   // [-] https://bugzilla.mozilla.org/1847599
   // user_pref("layout.css.font-visibility.private", 1);
   // user_pref("layout.css.font-visibility.standard", 1);
   // user_pref("layout.css.font-visibility.trackingprotection", 1);
// 2623: disable permissions delegation [FF73+]
   // Currently applies to cross-origin geolocation, camera, mic and screen-sharing
   // permissions, and fullscreen requests. Disabling delegation means any prompts
   // for these will show/use their correct 3rd party origin
   // [1] https://groups.google.com/forum/#!topic/mozilla.dev.platform/BdFOMAuCGW8/discussion
   // [-] https://bugzilla.mozilla.org/1697151
   // user_pref("permissions.delegation.enabled", false);
// FF119
// 0211: use en-US locale regardless of the system or region locale
   // [SETUP-WEB] May break some input methods e.g xim/ibus for CJK languages [1]
   // [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=867501,1629630
   // [-] https://bugzilla.mozilla.org/1846224
   // user_pref("javascript.use_us_english_locale", true); // [HIDDEN PREF]
// 0711: disable skipping DoH when parental controls are enabled [FF70+]
   // [-] https://bugzilla.mozilla.org/1586941
user_pref("network.dns.skipTRR-when-parental-control-enabled", false);
// FF123
// 0334: disable PingCentre telemetry (used in several System Add-ons) [FF57+]
   // Defense-in-depth: currently covered by 0331
   // [-] https://bugzilla.mozilla.org/1868988
user_pref("browser.ping-centre.telemetry", false);
// FF126
// 9003: disable What's New toolbar icon [FF69+]
   // [-] https://bugzilla.mozilla.org/1724300
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
// ***/

/* END: internal custom pref to test for syntax errors ***/
user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");


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




