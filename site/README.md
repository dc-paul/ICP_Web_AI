# Allusion — site folder for one.com FTP deployment

A static HTML/CSS website ready to upload to `ftp.allusion.be` (one.com hosting).
No build step, no dependencies beyond Google Fonts loaded from a CDN.

## What's in here

```
site/
├── index.html              Home — three pillars, hero, contact teaser
├── ventures.html           Ventures — portfolio (13), approach, ticket info
├── infrastructure.html     ICP node provider, Aviate Labs, ICP Belgium
├── about.html              Team, story, brand palette, 3 logo concept directions
├── contact.html            Address, email, getting-here
├── styles.css              Shared stylesheet — Mazois 5-token palette
├── favicon.svg             Site favicon (italic 'a' + Ochre dot)
├── assets/
│   ├── logo-wordmark.svg   Standalone wordmark SVG
│   └── logo-mark.svg       Standalone monogram-style mark
└── README.md               This file
```

Every page uses the same nav, footer, color tokens and typography — so when
content evolves, the look stays coherent.

---

## Deployment to one.com via FTP

### 1. Get your FTP credentials

In the one.com control panel:
1. Log in to `https://www.one.com/admin/`
2. Choose domain `allusion.be`
3. Open **Files & Security** → **FTP / SFTP**
4. Note: host, username, password, and port (usually 21 for FTP, 22 for SFTP)

### 2. Connect with FileZilla (or your FTP client of choice)

- Host: `ftp.allusion.be` (or whatever one.com gives you)
- Username: from step 1
- Password: from step 1
- Port: 21 (FTP) or 22 (SFTP)
- Protocol: prefer SFTP if available

### 3. Backup the existing site first

Before uploading anything, download the current `httpdocs/` (or `public_html/`)
to a local backup folder. If the new site breaks something unexpected, you
can drag the old files back.

### 4. Upload the contents of `site/` into the web root

Drag every file and folder from inside `site/` (not the `site/` folder itself —
its contents) into `httpdocs/` on the server:

```
httpdocs/
├── index.html
├── ventures.html
├── infrastructure.html
├── about.html
├── contact.html
├── styles.css
├── favicon.svg
└── assets/
    ├── logo-wordmark.svg
    └── logo-mark.svg
```

Overwrite the existing `index.html`, `contact`, `ict` files as needed. The new
`index.html` is the new home page; the old `/ict` slug is now `/infrastructure.html`;
the old `/contact` slug is now `/contact.html`.

### 5. Old URL redirects (optional but recommended)

If you want the old URLs to still work, add a small `.htaccess` file in
`httpdocs/` with the following content:

```
RewriteEngine On
RewriteRule ^ict/?$       /infrastructure.html [R=301,L]
RewriteRule ^contact/?$   /contact.html        [R=301,L]
RewriteRule ^ventures/?$  /ventures.html       [R=301,L]
```

This makes sure inbound links from the wider web still resolve correctly.

### 6. Check that allusion.ventures behaves the way you want

The old `allusion.ventures` site (built by Roald) is now content-duplicate with
`allusion.be/ventures.html`. You have three options:

- **Option A — Hard redirect.** Point `allusion.ventures` to redirect 301 to
  `allusion.be/ventures.html`. Cleanest, but it deprecates Roald's work explicitly.
- **Option B — Leave it standalone.** Both sites coexist. The new `allusion.be`
  doesn't link out to `.ventures`; visitors who go to `.ventures` get the legacy
  version. No conversation needed.
- **Option C — Park it with a notice.** Replace `.ventures` with a single page
  that says "this site has moved to allusion.be" and links over. Middle ground.

**Default recommendation: B.** It avoids the relationship friction with Roald
and lets the new site take the load on its own merit. Revisit once you've
talked to Roald about it.

### 7. Test it

Open in a fresh browser session (or incognito to skip cache):

- `https://allusion.be/` — should show the new home, Petrol hero, three pillars
- `https://allusion.be/ventures.html` — portfolio grid filter should work
- `https://allusion.be/infrastructure.html` — node provider story
- `https://allusion.be/about.html` — team + brand + 3 logo concepts
- `https://allusion.be/contact.html` — contact info

Hard-refresh (`Cmd+Shift+R` on Mac) to bust the browser cache after upload.

---

## Brand notes

- **Palette:** five tokens — Petrol `#1F3539`, Bone `#ECEAE2`, Ochre `#C8932E`,
  Ink `#0F0E0C`, Slate `#6F7C8A`. See `[[Allusion — Brand Palette (Mazois, 5-token)]]`
  in the wiki for full documentation.
- **Typography:** Newsreader (serif, display + body) and Hanken Grotesk
  (sans-serif, UI + eyebrows). Both loaded from Google Fonts CDN.
- **Pairing rules:** one Ochre accent per view. Petrol is a surface, not a band.
  No gradients. Italic is for emphasis.
- **Logo:** the site currently uses Direction 01 (wordmark with Ochre accent dot
  on the 'i') across nav and footer. When Paul picks a final direction, the
  inline HTML in each page can be swapped for the chosen mark.

## Modifying content

- Each page is a self-contained `.html` file with the same nav and footer
  structure. Edit content directly — no templating engine.
- All shared styling lives in `styles.css`. Color tokens are CSS variables
  defined in `:root` — change one place, everything updates.
- The portfolio grid in `ventures.html` is one `<article>` per company.
  Add/remove/edit cards directly. The `data-sector` attribute controls filter
  matching (`digital`, `health`, `energy` — space-separated for multiple).

## What's deliberately not here

- **Contact form.** One.com's Web Editor offers form-handling at extra cost,
  and the current form on `allusion.be/contact` doesn't appear to send anything
  anyway. Replaced by a direct `mailto:` link, which always works and which the
  visitor's mail client can open with one click.
- **Analytics / tracking pixels.** None. Add later if desired.
- **CMS / dashboard.** Static files only. Edit in a text editor, push via FTP.
- **Portfolio company logos.** The grid uses initial-monograms in italic
  Newsreader instead of company logos — keeps the brand identity coherent
  and avoids the brittleness of remote logo files. If you'd rather show actual
  company logos, drop them into `assets/logos/` and replace the `<div class="monogram">`
  in each card with `<img src="assets/logos/companyname.svg">`.

## Open questions for Paul (per the analysis)

1. Confirm which logo direction to ship as primary.
2. Confirm fate of `allusion.ventures` (A / B / C from §6 above).
3. Confirm tone — the new copy drops the "we react fast... or never" line. Reinstate?
4. EST. 2018 vs EST. 2019 — current copy uses 2018 (legally accurate). Change to
   the "ventures since 2019" wording if preferred.
5. Talk to Martine Decroos before finalising any logo work. The current Earth-as-'o'
   is hers, and a respectful redesign starts with a conversation, not a fait accompli.

---

Built 12 May 2026 alongside the wiki analysis at
`Wiki/Analyses/Allusion — Site Consolidation Proposal (12 mei 2026).md`.
