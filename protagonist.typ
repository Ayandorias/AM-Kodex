// Import deines Theme-Moduls (Pfad anpassen!)
// #import "/theme/am-boxes.typ": plate, sheet, frame
// #import "/theme/am.typ"
// #import "/theme/am-theme.typ"

#import "@local/arcana-mechanica:0.1.0" as am


// #let bg-color = white
#let bg-color = am.amber.at("100")
#let mod-color = am.gray.at("400")
// --- SEITEN-SETUP ---
// #set page(
//   margin: (
//     // x: 20mm, 
//     y: 1.2cm + am.bleed
//   ),
//   background: rect(fill: bg-color, width: 100%, height: 100%)
// )
// #set text(font: "New Computer Modern", size: 10pt, fill: am.amber.at("900"))

// --- KOMPONENTEN ---

#let header-line(titel) = block(width: 100%, inset: (y: 6pt), {
  let schiene = am.amber.at("400")
  grid(
    columns: (1fr, auto, 1fr),
    align: horizon,
    stack(dir: ltr, circle(fill: am.amber.at("800"), radius: 1.5pt), line(length: 100%, stroke: 0.5pt + schiene)),
    pad(x: 12pt, text(size: 11pt, weight: "bold", tracking: 2pt, upper(titel))),
    stack(dir: ltr, line(length: 100%, stroke: 0.5pt + schiene), circle(fill: am.amber.at("800"), radius: 1.5pt))
  )
})


#let header(titel_sekundaer) = {
  context {
    let seite = here().page()
    let ist_ungerade = calc.even(seite)
    
    let spalten_inhalt = if ist_ungerade {
      (
        align(left)[#text(size: 20pt, weight: "bold", tracking: 1pt, font: "Steamwreck", "ArcanA MechanicA")],
        align(right + bottom)[#text(size: 14pt, titel_sekundaer)]
      )
    } else {
      (
        align(left + bottom)[#text(size: 14pt, titel_sekundaer)],
        align(right)[#text(size: 20pt, weight: "bold", tracking: 1pt, font: "Steamwreck", "ArcanA MechanicA")]
      )
    }

    grid(
      columns: (1fr, 1fr),
      ..spalten_inhalt
    )
    v(-5pt)
    line(length: 100%, stroke: 1pt + am.amber.at("800"))
    v(10pt)
  }
}

// Der standardisierte Footer
#let footer_old(seite: "") = {
  v(5pt)
  line(length: 100%, stroke: 0.5pt + am.amber.at("400"))
  grid(
    columns: (1fr, 1fr),
    text(size: 7pt, [© 2026 #text(font: "steamwreck", size: 8pt)[ArcanA MechanicA]]),
    align(right, text(size: 7pt, "Darf zum persönlichen Gebrauch kopiert werden" + if seite != "" { " | Seite " + seite }))
  )
}

// Der standardisierte Footer
#let footer(seite: "") = {
  place(bottom)[
    #v(5pt)
    #line(length: 100%, stroke: 0.5pt + am.amber.at("400"))
    #grid(
      columns: (1fr, 1fr),
      text(size: 7pt, [© 2026 #text(font: "steamwreck", size: 8pt)[ArcanA MechanicA]]),
      align(right, text(size: 7pt, "Darf zum persönlichen Gebrauch kopiert werden" + if seite != "" { " | Seite " + seite }))
    )
  ]
}

// Hilfsfunktion für Schreiblinien mit Nieten an den Enden
#let schienen-linie() = grid(
  columns: (auto, 1fr, auto),
  align: horizon, // Hier funktioniert align: horizon einwandfrei
  circle(fill: am.amber.at("800"), radius: 1.2pt),
  line(length: 100%, stroke: 0.4pt + am.amber.at("400").lighten(20%)),
  circle(fill: am.amber.at("800"), radius: 1.2pt)
)

#let schreiblinien(anzahl, abstand: 18pt) = {
  stack(
    spacing: abstand,
    ..range(anzahl).map(_ => schienen-linie())
  )
}

#let info-line() = block(width: 100%, inset: (y: 6pt), {
  let schiene = am.amber.at("400")
  grid(
    columns: (1fr, auto, 1fr),
    align: horizon,
    stack(dir: ltr, circle(fill: am.amber.at("800"), radius: 1.5pt), line(length: 100%, stroke: 0.5pt + schiene)),
    stack(dir: ltr, line(length: 100%, stroke: 0.5pt + schiene), circle(fill: am.amber.at("800"), radius: 1.5pt))
  )
})

#let data-line(label) = stack(
  spacing: 2pt,
  text(size: 8pt, weight: "bold", fill: am.amber.at("800"), label + ":"),
  line(length: 100%, stroke: 0.5pt + am.amber.at("400"))
)

#let attr-cell(label, formula: "", mod: true, h: 64pt) = rect(
  width: 100%, height: h, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%),
  stack(
    block(width: 100%, fill: am.amber.at("800"), inset: 2pt, 
      align(center, text(fill: am.amber.at("100"), size: 7pt, weight: "bold", label))
    ),
    align(center + horizon, text(size: 7pt, weight: "bold", fill: am.gray.at("400"), formula)),
    if mod {
      place(
        bottom + right,
        dx: 3pt,
        dy: 19.5pt, 
        block(width: 30pt, height: 30pt, stroke: 0.5pt + am.amber.at("400"), fill: none, radius: 15pt, 
          align(
            center + horizon, 
            text(size: 7pt, fill: mod-color, style: "italic", $plus.minus$ + "Mod")
          )
        )
      )
    },
  )
)

#let grundwert-box(label) = rect(
  width: 100%, height: 48pt, stroke: 0.5pt + am.amber.at("400"), inset: 6pt, fill: white.darken(1%),
  stack(
    align(center, text(size: 7pt, weight: "bold", fill: am.amber.at("800"), label)),
    v(4pt),
    align(center, text(size: 14pt, ""))
  )
)

#let attribute() = {
  // 2. ATTRIBUTE
  header-line("PHYSISCHE & GEISTIGE ATTRIBUTE")
  grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    column-gutter: 6pt,
    attr-cell("GES"), attr-cell("KON"), attr-cell("MUT"), attr-cell("INT"), 
    attr-cell("STU"), attr-cell("ERG"), attr-cell("WIL")
  )
}

// Header für die Fertigkeiten-Liste mit dunklem Hintergrund
#let fertigkeiten-header() = {
  let hintergrund = am.amber.at("800")
  let trenner = am.amber.at("100")
  
  rect(
    width: 100%, 
    fill: hintergrund, 
    stroke: none, 
    inset: (y: 4pt, x: 5pt),
    grid(
      columns: (1fr, 1pt, 35pt, 1pt, 35pt, 1pt, 1fr, 1pt, 35pt, 1pt, 33pt),
      column-gutter: 3pt,
      align: center + horizon,
      
      // 1. Fertigkeit (Links)
      align(left, text(size: 10pt, weight: "bold", fill: trenner, "FERTIGKEIT")),
      line(start: (0pt, 2pt), end: (0pt, 8pt), stroke: 0.5pt + trenner),
      
      // 2. Attribut
      text(size: 10pt, weight: "bold", fill: trenner, "ATT"),
      line(start: (0pt, 2pt), end: (0pt, 8pt), stroke: 0.5pt + trenner),
      
      // 3. FW
      text(size: 10pt, weight: "bold", fill: trenner, "FW"),
      line(start: (0pt, 2pt), end: (0pt, 8pt), stroke: 0.5pt + trenner),
      
      // 4. Spezialisierung (Links)
      align(left, text(size: 10pt, weight: "bold", fill: trenner, "SPEZIALISIERUNG")),
      line(start: (0pt, 2pt), end: (0pt, 8pt), stroke: 0.5pt + trenner),
      
      // 5. S.FW
      text(size: 10pt, weight: "bold", fill: trenner, "S.FW"),
      line(start: (0pt, 2pt), end: (0pt, 8pt), stroke: 0.5pt + trenner),
      
      // 6. GES
      text(size: 10pt, weight: "bold", fill: trenner, "GES")
    )
  )
}

#let fertigkeit() = {
  let trenner = am.amber.at("800")
  let zeilen-hoehe = 23pt
  let luecke = 7pt
  
  grid(
    columns: (1fr, 1pt, 35pt, 1pt, 35pt, 1pt, 1fr, 1pt, 35pt, 1pt, 33pt),
    column-gutter: 3pt,
    
    // 1. Name
    align(bottom, line(length: 100%, stroke: 0.4pt + am.amber.at("400"))),
    // Vertikaler Strich
    grid.cell(align: horizon, block(height: zeilen-hoehe - (2 * luecke), width: 0pt, stroke: (left: 0.5pt + trenner))),
    
    // 2. Attribut
    align(bottom, line(length: 100%, stroke: 0.4pt + am.amber.at("400"))),
    grid.cell(align: horizon, block(height: zeilen-hoehe - (2 * luecke), width: 0pt, stroke: (left: 0.5pt + trenner))),
    
    // 3. FW
    align(bottom, line(length: 100%, stroke: 0.5pt + trenner)),
    grid.cell(align: horizon, block(height: zeilen-hoehe - (2 * luecke), width: 0pt, stroke: (left: 0.5pt + trenner))),
    
    // 4. Spezialisierung
    align(bottom, line(length: 100%, stroke: 0.3pt + am.amber.at("400").lighten(40%))),
    grid.cell(align: horizon, block(height: zeilen-hoehe - (2 * luecke), width: 0pt, stroke: (left: 0.5pt + trenner))),
    
    // 5. Spez-FW
    align(bottom, line(length: 100%, stroke: 0.3pt + am.amber.at("400").lighten(40%))),
    grid.cell(align: horizon, block(height: zeilen-hoehe - (2 * luecke), width: 0pt, stroke: (left: 0.5pt + trenner))),
    
    // 6. Gesamt FW Box
    rect(width: 30pt, height: zeilen-hoehe, stroke: 0.5pt + trenner, fill: am.amber.at("200"))
  )
}

#let notiz-block(zeile: 15) = context {
  let seite = here().page()
  let ist-ungerade = calc.even(seite)
  
  let spalten = if ist-ungerade { (1fr, 2fr) } else { (2fr, 1fr) }
  
  let l-block = rect(
    width: 100%, 
    height: 324pt, 
    stroke: 0.5pt + am.amber.at("400"), 
    fill: white,
    pad(top: 14pt, x: 5pt, schreiblinien(zeile))
  )
  
  let r-block = rect(
    width: 100%, 
    height: 324pt, 
    stroke: 0.5pt + am.amber.at("400"), 
    fill: white
  )

  grid(
    columns: spalten,
    column-gutter: 5pt,
    // Die Inhalte werden hier einzeln durch das if-else gereicht
    if ist-ungerade { r-block } else { l-block },
    if ist-ungerade { l-block } else { r-block }
    
  )
}

#let fortschritts-leiste(anzahl: 30) = {
  let dicke-linie = 1.5pt + am.amber.at("800")
  let feine-linie = 0.5pt + am.amber.at("800")
  
  // Der äußere Rahmen um die gesamte Leiste
  block(
    width: 100%,
    stroke: feine-linie,
    fill: white.darken(1%),
    grid(
      columns: (1fr,) * anzahl,
      rows: 12pt, // Die Höhe des Balkens
      ..range(anzahl).map(i => {
        let ist-fünfer = calc.rem(i + 1, 5) == 0 and (i + 1) < anzahl
        
        // Jede Zelle bekommt einen rechten Rahmen
        // Wenn es ein 5er-Schritt ist, wird dieser Rahmen fett
        grid.cell(
          stroke: (
            right: if ist-fünfer { dicke-linie } else { feine-linie }
          ),
          []
        )
      })
    )
  )
}



#let status-anzeige() = {
  grid(
    columns: (1fr, 1fr),
    column-gutter: 6pt,
    block({
      am.status-tabelle(titel: "AUSDAUER", spalten: 10, zeilen: 3)
      place(
        top + left,
        dy: 27pt,
        dx: 5%,
        line(length: 90%, stroke: 0.5pt + mod-color)
      )
      place(
        top + left,
        dy: 45pt,
        dx: 5%,
        line(length: 90%, stroke: 0.5pt + mod-color)
      )
      place(
        top + left,
        dy: 45pt,
        dx: 5%,
        line(length: 90%, angle: 358.51deg, stroke: 0.5pt + mod-color)
      )
      place(
        top + left,
        dy: 63pt,
        dx: 5%,
        line(length: 90%, stroke: 0.5pt + mod-color)
      )
      place(
        top + left,
        dy: 63pt,
        dx: 5%,
        line(length: 90%, angle: 358.51deg, stroke: 0.5pt + mod-color)
      )
      place(
        bottom + right,
        dy: -18pt, 
        block(
          width: 10pt,
          height: 10pt,
          align(center + horizon, text(size: 6pt, fill: mod-color,"-1"))
        )
      )
      place(
        bottom + right,
        block(
          width: 10pt,
          height: 10pt,
          align(center + horizon, text(size: 6pt, fill: mod-color,"-2"))
        )
      )
    }),
    stack(spacing: 0pt,
      block({
        am.status-tabelle(titel: "SCHADEN", spalten: 10, zeilen: 1)
        place(
          top + left,
          dy: 27pt,
          dx: 5%,
          line(length: 40%, stroke: 0.5pt + mod-color)
        )
        place(
          top + left,
          dy: 27pt,
          dx: 55%,
          line(length: 40%, stroke: 0.5pt + mod-color)
        )
        place(
          bottom + left,
          dx: 50% - 10pt,
          block(
            width: 10pt,
            height: 10pt,
            align(center + horizon, text(size: 6pt, fill: mod-color,"-3"))
          )
        )
        place(
          bottom + left,
          dx: 100% - 10pt,
          block(
            width: 10pt,
            height: 10pt,
            align(center + horizon, text(size: 6pt, fill: mod-color,"-4"))
          )
        )
      }),
      block( {
        am.status-tabelle(titel: "KRITISCH", spalten: 5, zeilen: 1)
        place(
          top + left,
          dy: 27pt,
          dx: 10%,
          line(length: 40%, stroke: 0.5pt + mod-color)
        )
        place(
          top + left,
          dy: 27pt,
          dx: 70%,
          line(length: 20%, stroke: 0.5pt + mod-color)
        )
        place(
          bottom + left,
          dx: 60% -10pt,
          block(
            width: 10pt,
            height: 10pt,
            align(center + horizon, text(size: 6pt, fill: mod-color,"-5"))
          )
        )
        place(
          bottom + right,
          block(
            width: 10pt,
            height: 10pt,
            align(center + horizon, text(size: 6pt, fill: mod-color,"-6"))
          )
        )
      })
    )
  )
}

#let ruestung(titel: "AUSDAUER") = {
  let primär = am.amber.at("800")
  let sekundär = am.amber.at("400")
  
  block(width: 100%, stroke: 0.5pt + primär, clip: true, {
    stack(
      // 1. Der Header-Balken (Dunkel mit weißem Text)
      grid(
        columns: (3fr, 1fr),
        rect(
          width: 100%, 
          height: 18pt, 
          fill: primär, 
          stroke: none,
          align(left + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper(titel))))
        ),
        rect(
          width: 100%, 
          height: 18pt, 
          fill: primär, 
          stroke: none,
          align(center + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("RS"))))
        )
      ),
      // 2. Das Kästchen-Raster
      grid(
        columns: (3fr, 1fr,),
        rows: 18pt,
        stroke: 0.5pt + primär,
        ..range(2).map(_ => rect(width: 100%, height: 100%, fill: white.darken(1%), stroke: 0.5pt + primär))
      )
    )
  })
}

#let protokoll-block(zeilen: 28) = context {
  let ist-ungerade = calc.odd(here().page())
  
  // 1. Spalten definieren
  let spalten = if ist-ungerade { (1fr, 100pt) } else { (100pt, 1fr) }
  
  // 2. Die Bausteine
  let h-line = header-line("Protokoll")
  let datum-box = rect(
    width: 100%,
    height: 100%,
    stroke: 0.5pt + am.amber.at("400"),
    fill: white.darken(1%),
    align(center + horizon, text(font: "Controwell", fill: am.gray.at("300"), "Datum"))
  )

  // 3. Der obere Bereich
  block(height: 30pt, {
    grid(
      columns: spalten,
      column-gutter: 20pt,
      align: horizon,
      // Direkte Logik für die Reihenfolge
      if ist-ungerade { h-line } else { datum-box },
      if ist-ungerade { datum-box } else { h-line }
    )
  })


  grid(
    columns:(1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    column-gutter: 6pt,
    grid.cell(
      colspan: 1,
      block(
        width: 100%,
        stroke: none, 
        fill: none
      )
    ),
    grid.cell(
      colspan: 1,
      block(
        width: 100%,
        stroke: none, 
        fill: none
      )
    ),
    grid.cell(
      colspan: 1,
      block(
        width: 100%,
        stroke: none, 
        fill: none
      )
    ),
    grid.cell(colspan: 3, 
      stack(
        status-anzeige(),
      )
    )
  )

  grid(
    columns:(1fr, 1fr),
    column-gutter: 6pt,
    grid.cell(
      colspan: 1,
      stack(
        let primär = am.amber.at("800"),
        let sekundär = am.amber.at("400"),
        
        grid(
          columns: (3fr, 1fr),
          rect(
            width: 100%, 
            height: 18pt, 
            fill: primär, 
            stroke: none,
            align(left + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Proviant"))))
          ),
          rect(
            width: 100%, 
            height: 18pt, 
            fill: primär, 
            stroke: none,
            align(center + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Anzahl"))))
          )
        ),
        grid(
          columns: (3fr, 1fr),
          rows: 18pt,
          stroke: 0.5pt + primär,
          ..range(10 * 2).map(_ => rect(width: 100%, height: 100%, fill: white.darken(1%), stroke: 0.5pt + primär))
        ),
        v(3pt),
        let spalten = 10,
        let zeilen = 5,
        grid(
          columns: (3fr, 1fr),
          rect(
            width: 100%, 
            height: 16pt, 
            fill: primär, 
            stroke: 0.5pt + primär,
            align(left + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Munition"))))
          ),
          rect(
            width: 100%, 
            height: 16pt, 
            fill: primär, 
            stroke: 0.5pt + primär,
            align(center + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Stück"))))
          )
        ),
        grid(
          columns: (3fr, 1fr),
          rows: 17pt,
          stroke: 0.5pt + primär,
          ..range(2).map(_ => rect(width: 100%, height: 100%, fill: white.darken(1%), stroke: 0.5pt + primär))
        ),
        grid(
          columns: (1fr,) * spalten,
          rows: 18pt,
          stroke: 0.5pt + primär,
          ..range(spalten * zeilen).map(_ => rect(width: 100%, height: 100%, fill: white.darken(1%), stroke: 0.5pt + primär))
        )
      )
    ),
    grid.cell(colspan: 1, 
      stack(
        let primär = am.amber.at("800"),
        let sekundär = am.amber.at("400"),
        
        grid(
          columns: (3fr, 2fr),
          rect(
            width: 100%, 
            height: 18pt, 
            fill: primär, 
            stroke: none,
            align(left + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Einnahmen / Ausgaben"))))
          ),
          rect(
            width: 100%, 
            height: 18pt, 
            fill: primär, 
            stroke: none,
            align(center + horizon, pad(x: 5pt, text(fill: white, size: 9pt, weight: "bold", upper("Kontostand"))))
          )
        ),
        grid(
          columns: (3fr, 1fr, 1fr),
          rows: 18pt,
          stroke: 0.5pt + primär,
          ..range(29 * 3).map(_ => rect(width: 100%, height: 100%, fill: white.darken(1%), stroke: 0.5pt + primär))
        )
      )
    )
  )

  // 4. Der untere Bereich
  // rect(
  //   width: 100%, 
  //   height: 1fr, 
  //   stroke: 0.5pt + am.amber.at("400"), 
  //   fill: white.darken(1%), 
  //   pad(top: 14pt, x: 5pt, schreiblinien(zeilen))
  // )
}


// #pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Vorgeschichte des Protagonisten ---
///////////////////////////////////////////////////////////////////////////////
#header("Vorgeschichte")
#header-line("vorgeschichte")
#rect(width: 100%, height: 86%, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%), pad(top: 14pt, x: 5pt, schreiblinien(32)))
#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- DAS CHARAKTERBLATT ---
///////////////////////////////////////////////////////////////////////////////

// 1. HEADER
#header("Stammblatt")

#attribute()

#v(15pt)

// 3. PERSÖNLICHE DATEN & PORTRÄT
#grid(
  columns: (2fr, 1fr), 
  column-gutter: 30pt,
  stack(
    spacing: 20pt,
    header-line("Persönliches"),
    data-line("NAME DES PROTAGONISTEN"),
    grid(
      columns: (1fr, 1fr), 
      column-gutter: 15pt, 
      data-line("ALTER"), 
      data-line("GEBURTSTAG")
    ),
    data-line("HERKUNFT / STADTVIERTEL"),
    data-line("AKTUELLE PROFESSION"),
    data-line("FRAKTION / GILDE"),
    stack(
      header-line("Merkmale"),
      v(5pt),
      rect(width: 100%, height: 165pt, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%),
        pad(top: 14pt, x: 5pt, schreiblinien(7))
      ),
    )
  ),
  stack(
    header-line("GRUNDWERTE"),
    v(5pt),
    grid(
      columns: (1fr, 1fr),
      column-gutter: 10pt,
      row-gutter: 5pt,
      // attr-cell("PSYCH - RES", h: 48pt, mod: false),
      // attr-cell("PHYS - RES", h: 48pt, mod: false),
      attr-cell("EP", h: 48pt, mod: false),
      attr-cell("Stufe", h: 48pt, mod: false),
    ),
    v(5pt),
    header-line("Porträt"),
    v(5pt),
    rect(width: 100%, height: 263pt, stroke: 0.5pt + am.amber.at("800"), fill: white, 
      // align(center + horizon, text(size: 8pt, fill: am.amber.at("400"), "[ VISUELLE ERFASSUNG ]"))

    )
  )
)

#v(15pt)

// 5. TUGENDEN & LASTER
#grid(
  columns: (1fr, 1fr),
  column-gutter: 30pt,
  stack(
    spacing: 5pt,
    header-line("TUGENDEN"),
    rect(width: 100%, height: 80pt, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%),
      pad(top: 14pt, x: 5pt, schreiblinien(3))
    ),
  ),
  stack(
    spacing: 5pt,
    header-line("LASTER"),
    rect(width: 100%, height: 80pt, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%),
      pad(top: 14pt, x: 5pt, schreiblinien(3))
    )
  )
)

#footer()
#pagebreak()


///////////////////////////////////////////////////////////////////////////////
// --- Stammblatt Seite 2
///////////////////////////////////////////////////////////////////////////////
#header("Stammblatt")
#attribute()

#header-line("BESCHREIBUNG & NOTIZEN")

#rect(width: 100%, height: 1fr, stroke: 0.5pt + am.amber.at("400"), fill: white.darken(1%), pad(top: 14pt, x: 5pt, schreiblinien(26)))

#footer()

#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Fertigkeiten Seite
///////////////////////////////////////////////////////////////////////////////
#header("Fertigkeiten")
#attribute()
#fertigkeiten-header()
#stack(
  spacing: 0pt,
  ..range(24).map(_ => fertigkeit())
)
#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Fertigkeiten Seite
///////////////////////////////////////////////////////////////////////////////
#header("Fertigkeiten")
#attribute()
#fertigkeiten-header()
#stack(
  spacing: 0pt,
  ..range(24).map(_ => fertigkeit())
)
#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Arkanisches System
/////////////////////////////////////////////////////////////////////////////// 
#header("Arkanisches System")
#attribute()

#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Arkanisches System - Seite 2
/////////////////////////////////////////////////////////////////////////////// 
#header("Arkanisches System")
#attribute()

#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Gefechtsbogen Seite 1
///////////////////////////////////////////////////////////////////////////////
#header("Gefechtsbogen")
#attribute()

// Aufruf der beiden Tabellen nebeneinander
#grid(
  columns:(1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  column-gutter: 6pt,
  attr-cell("BWR", mod: false, h: 72pt, formula: $ floor(("GES" + "MUT") / 4) $),
  attr-cell("Überlebenswille", mod: false, h: 72pt, formula: $ "KON" / 2 $),
  grid.cell(
    colspan: 1,
    block(
      width: 100%,
      stroke: none, 
      fill: none
    )
  ),
  grid.cell(colspan: 4, 
    stack(
      status-anzeige()
      // grid(
      //   columns: (1fr, 1fr),
      //   column-gutter: 6pt,
      //   block({
      //     status-tabelle(titel: "AUSDAUER", spalten: 10, zeilen: 3)
      //     place(
      //       top + left,
      //       dy: 27pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //       dx: 5%,   // Startet leicht eingerückt
      //       line(length: 90%, stroke: 0.5pt + mod-color)
      //     )
      //     place(
      //       top + left,
      //       dy: 45pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //       dx: 5%,   // Startet leicht eingerückt
      //       line(length: 90%, stroke: 0.5pt + mod-color)
      //     )
      //     place(
      //       top + left,
      //       dy: 45pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //       dx: 5%,   // Startet leicht eingerückt
      //       line(length: 90%, angle: 358.51deg, stroke: 0.5pt + mod-color)
      //     )
      //     place(
      //       top + left,
      //       dy: 63pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //       dx: 5%,   // Startet leicht eingerückt
      //       line(length: 90%, stroke: 0.5pt + mod-color)
      //     )
      //     place(
      //       top + left,
      //       dy: 63pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //       dx: 5%,   // Startet leicht eingerückt
      //       line(length: 90%, angle: 358.51deg, stroke: 0.5pt + mod-color)
      //     )
      //     place(
      //       bottom + right,
      //       dy: -18pt, 
      //       block(
      //         width: 10pt,
      //         height: 10pt,
      //         align(center + horizon, text(size: 6pt, fill: mod-color,"-1"))
      //       )
      //     )
      //     place(
      //       bottom + right,
      //       block(
      //         width: 10pt,
      //         height: 10pt,
      //         align(center + horizon, text(size: 6pt, fill: mod-color,"-2"))
      //       )
      //     )
      //   }),
      //   stack(spacing: 0pt,
      //     block({
      //       status-tabelle(titel: "SCHADEN", spalten: 10, zeilen: 1)
      //       place(
      //         top + left,
      //         dy: 27pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //         dx: 5%,   // Startet leicht eingerückt
      //         line(length: 40%, stroke: 0.5pt + mod-color)
      //       )
      //       place(
      //         top + left,
      //         dy: 27pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //         dx: 55%,   // Startet leicht eingerückt
      //         line(length: 40%, stroke: 0.5pt + mod-color)
      //       )
      //       place(
      //         bottom + left,
      //         dx: 55pt,
      //         block(
      //           width: 10pt,
      //           height: 10pt,
      //           align(center + horizon, text(size: 6pt, fill: mod-color,"-3"))
      //         )
      //       )
      //       place(
      //         bottom + left,
      //         dx: 118pt,
      //         block(
      //           width: 10pt,
      //           height: 10pt,
      //           align(center + horizon, text(size: 6pt, fill: mod-color,"-4"))
      //         )
      //       )
      //     }),
      //     block( {
      //       status-tabelle(titel: "KRITISCH", spalten: 5, zeilen: 1)
      //       place(
      //         top + left,
      //         dy: 27pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //         dx: 10%,   // Startet leicht eingerückt
      //         line(length: 40%, stroke: 0.5pt + mod-color)
      //       )
      //       place(
      //         top + left,
      //         dy: 27pt, // Ein kleiner Abstand (3pt) zur Tabelle
      //         dx: 70%,   // Startet leicht eingerückt
      //         line(length: 20%, stroke: 0.5pt + mod-color)
      //       )
      //       place(
      //         bottom + right,
      //         dx: -55pt,
      //         block(
      //           width: 10pt,
      //           height: 10pt,
      //           align(center + horizon, text(size: 6pt, fill: mod-color,"-5"))
      //         )
      //       )
      //       place(
      //         bottom + right,
      //         block(
      //           width: 10pt,
      //           height: 10pt,
      //           align(center + horizon, text(size: 6pt, fill: mod-color,"-6"))
      //         )
      //       )
      //     })
      //   )
      // )
    )
  )
)
#v(5pt)
#header-line("Rüstung")
#v(5pt)

#block(
  height: 1fr, {
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 5pt,
    stack(
      ruestung(titel: "Kopf"),
      v(100pt),
      ruestung(titel: "Rechter Arm"),
      v(100pt),
      ruestung(titel: "Rechtes Bein"),
      v(90pt),
      ruestung(titel: "Rechter Fuß")
    ),
    block(
      width: 100%,
      height: 1fr, 
      stroke: none,
      fill: none,
      align(
        center + horizon,
        image("/bilder/mensch.webp", height: 100%)
      )
    ),
    stack(
      ruestung(titel: "Torso"),
      v(100pt),
      ruestung(titel: "Linker Arm"),
      v(100pt),
      ruestung(titel: "Linkes Bein"),
      v(90pt),
      ruestung(titel: "Linker Fuß")
    )
  )
  place(
    top + left,
    dy: 18pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: 32.5%,   // Startet leicht eingerückt
    line(length: 18%, angle: 15deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + right,
    dy: 39pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: -32.5%,   // Startet leicht eingerückt
    line(length: 18%, angle: 345deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + left,
    dy: 154pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: 32.5%,   // Startet leicht eingerückt
    line(length: 10%, angle: 15deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + right,
    dy: 166pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: -32.5%,   // Startet leicht eingerückt
    line(length: 10%, angle: 345deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + left,
    dy: 290pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: 32.5%,   // Startet leicht eingerückt
    line(length: 14%, angle: 15deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + right,
    dy: 306pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: -32.5%,   // Startet leicht eingerückt
    line(length: 14%, angle: 345deg, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + left,
    dy: 416pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: 32.5%,   // Startet leicht eingerückt
    line(length: 12%, stroke: 0.5pt + am.amber.at("800"))
  )
  place(
    top + right,
    dy: 416pt, // Ein kleiner Abstand (3pt) zur Tabelle
    dx: -32.5%,   // Startet leicht eingerückt
    line(length: 15%, stroke: 0.5pt + am.amber.at("800"))
  )
})



#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Gefechtsbogen Seite 2
/////////////////////////////////////////////////////////////////////////////// 
#header("Gefechtsbogen")
#attribute()

#grid(
  columns: (1fr,) * 7,
  column-gutter: 6pt,
  grid.cell(
    colspan: 6,
    align: horizon,
    header-line("Waffenloser Kampf")
  ),
  attr-cell("FW", mod: false, h: 48pt)
)
#grid(
  columns: (3fr, 2fr),
  gutter: 5pt,
  attr-cell("Waffenstil", mod: false),
  attr-cell("Modifikatoren", mod: false)
)


#grid(
  columns: (1fr,) * 7,
  column-gutter: 6pt,
  grid.cell(
    colspan: 6,
    align: horizon,
    header-line("Bewaffneter Nahkampf")
  ),
  attr-cell("FW", mod: false, h: 48pt)
)
#grid(
  columns: (3fr, 2fr),
  gutter: 5pt,
  attr-cell("Waffe | Stufe | FW", mod: false),
  attr-cell("Modifikatoren", mod: false)
)


#grid(
  columns: (1fr,) * 7,
  column-gutter: 6pt,
  grid.cell(
    colspan: 6,
    align: horizon,
    header-line("Fernkampf")
  ),
  attr-cell("FW", mod: false, h: 48pt)
)

#grid(
  columns: (3fr, 2fr),
  gutter: 5pt,
  attr-cell("Waffe | Stufe | FW", mod: false, h: 100pt),
  attr-cell("Modifikatoren", mod: false, h: 100pt)
)
#block(height: 1fr)

#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Persönlichkeiten Variante 1
///////////////////////////////////////////////////////////////////////////////
#header("Persönlichkeiten")
#notiz-block()
#notiz-block()
// #notiz-block(zeile: 10)
#footer()
#pagebreak()

///////////////////////////////////////////////////////////////////////////////
// --- Persönlichkeiten Variante 2
///////////////////////////////////////////////////////////////////////////////
#header("Persönlichkeiten")
#notiz-block()
#notiz-block()
// #notiz-block(zeile: 10)
#footer()
#pagebreak()


///////////////////////////////////////////////////////////////////////////////
// --- Protokoll ---
///////////////////////////////////////////////////////////////////////////////
#pagebreak()
#header("Protokoll")
#protokoll-block()
#footer()
