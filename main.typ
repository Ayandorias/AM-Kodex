#import "@local/arcana-mechanica:0.1.0" as am

// Seitenzahlen auf Römisch einstellen
#show: am.use-format.with(format: am.a4-small)
// #show: am.configuration

// --- COVER ---
// #show: am.cover.with(
//     hintergrund: image("/bilder/cover.png")
// )
// #pagebreak() 
#show: am.background.with(
    bg-image: "/bilder/background.webp",
    footersign: false,
    custom-footer: none
)

// --- Restliches Dokument anzeigen lassen.
// #am-theme.am-enable.update(true)
// #include "statuten/statuten.typ"
#include "protagonist.typ"

// // --- BACKCOVER ---
// #pagebreak(to: "even", weak: false) // Beendet die Cover-Seite
// #show: am.cover.with(
//     hintergrund: image("/bilder/backcover.png")
// )
// // --- END BACKCOVER ---