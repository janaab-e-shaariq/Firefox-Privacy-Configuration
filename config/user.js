// Firefox Privacy Configuration (reviewed subset)
// Derived from an uploaded profile. No unique IDs, paths, secrets or browser state.
// This does NOT recreate every pref in the original profile.
// Settings in user.js reapply at every startup until edited/removed.
// DNS-over-HTTPS strict mode (network.trr.mode=3) can break some networks.
// Brave Search default is NOT forcibly set; select via Firefox Search settings.

user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("dom.security.https_only_mode", true);
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.clearSiteData.browsingHistoryAndDownloads", true);
user_pref("privacy.clearSiteData.formdata", true);
user_pref("privacy.clearSiteData.siteSettings", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false);
user_pref("browser.urlbar.merino.endpointURL", "");
