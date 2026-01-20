# Segunda División 2024/25 — Contextual League Analysis

This project applies the same analytical framework previously used for La Liga to Spain’s Segunda División, with one central question in mind:

> **How does the analytical context change when moving from La Liga to Segunda División?**

Rather than introducing new metrics or models, the goal is to **observe how the same questions behave under a different competitive environment**.

---

## 🎯 Project Objective

To build a **contextual, league-level understanding** of the Segunda División by:
- Reusing a proven analytical framework
- Adapting it honestly to data availability and league structure
- Avoiding premature rankings or player-level conclusions

This project focuses on:
- league structure
- home advantage
- competitive compression
- outcome-based efficiency
- defensive stability

Player-level analysis, recruitment use cases, and predictive modeling are **explicitly out of scope**.

---

## 📊 Data Source & Collection

### Source
- **FBref** — match-level data (Scores & Fixtures)

### Season
- **2024/25** (completed season)

### Scraping Challenges & Resolution

During data collection, FBref implemented an additional anti-bot / security layer, which caused standard HTTP requests to return an interstitial page instead of the actual HTML content.

#### Attempted solutions:
- Direct requests (blocked)
- Export options (no longer available for this competition)
- Static HTML parsing (incomplete)

#### Final solution:
- Use Playwright to load the page in a real browser context
- Extract the rendered HTML
- Parse the table locally

---

## 🧱 Data Model & Pipeline

### Match-level table
`matches`

Each row represents one match, with the following schema:

date
home_team
away_team
score
attendance
venue


> ⚠️ Expected Goals (xG) data is **not available** for this competition and season.

---

### Competition Structure Handling

The Segunda División includes **promotion playoffs**, which are not part of the regular league format.

To preserve analytical consistency:

- **Regular season**: 462 matches  
- **Playoffs**: 6 matches  

Playoffs are **explicitly excluded** from the analytical baseline.

---

### Views Created

#### Match-level
- `matches_regular_season`
- `matches_playoffs`

#### Team-level (duplication applied *after* context separation)
- `team_matches_regular`
- `team_matches_playoffs`

> **Design principle:**  
> Context is resolved *before* duplicating matches into team-level rows.

This avoids playoff leakage into league-wide metrics and simplifies downstream queries.

---

## 🧪 Sanity Checks

A dedicated `00_sanity_checks.sql` file validates:

- correct number of matches (462 regular, 6 playoffs)
- correct team count (22)
- 42 matches per team
- proper home/away duplication
- score format consistency
- absence of NULLs in mandatory fields
- no playoff matches leaking into the regular-season base

All sanity checks pass before analysis begins.

---

## 🔍 Analytical Framework

The analysis follows five structured steps.

### 01 — Season Overview
**Purpose:** describe the league environment.

- total matches
- total goals
- goals per match
- attendance range and average

No comparisons, rankings, or interpretations are made at this stage.

---

### 02 — Home vs Away Context
**Purpose:** understand the role of home advantage.

- goals scored home vs away
- distribution of match results (home win / draw / away win)

Key focus:
> Is home advantage about dominance, or about avoiding defeat?

---

### 03 — Team-Level Context
**Purpose:** observe league compression and competitive structure.

- goals for / against
- goal difference
- points and points per match
- home vs away point accumulation

Rankings are shown for orientation only — the analysis focuses on **distribution and spread**, not “best teams”.

---

### 04 — Outcome Efficiency Outliers
**Purpose:** identify different paths to similar results.

Because xG is unavailable:
- efficiency is **outcome-based**, not process-based
- the key comparison is between:
  - goal difference per match
  - points per match

An `outcome_efficiency_delta` is calculated as a **descriptive aid**, not a ranking metric.

> This step highlights *survivors vs dominators*, not overperformance.

---

### 05 — Defensive Stability
**Purpose:** close the analytical loop.

- goals conceded
- goals conceded per match
- defensive stability vs points

Key insight:
> In Segunda División, defensive solidity is a **baseline requirement for competitiveness**, not a guarantee of success.

---

## 🚫 Explicit Non-Goals

This project does **not** include:

- player-level metrics
- recruitment analysis
- clustering
- predictive models
- cross-season comparisons
- real-time or live data

Those are intentionally deferred to future work.

---

## 🧠 Key Takeaways (High Level)

- The Segunda División is **highly compressed**.
- Home advantage acts more as **protection against defeat** than as dominance.
- Defensive stability keeps teams competitive, but does not guarantee top positions.
- Multiple teams reach similar point totals through **very different competitive paths**.
- Analytical frameworks do not transfer automatically between leagues — even within the same country.

---

## 📦 Outputs

- Clean match-level dataset
- Reproducible SQL queries
- Clear separation of context (regular season vs playoffs)
- A league-level baseline ready for:
  - future player analysis
  - recruitment-oriented extensions
  - cross-league comparison with La Liga

---

## 🧭 Final Note

This project prioritizes **analytical honesty over symmetry**.

Rather than forcing La Liga concepts onto a different competition, the framework adapts to:
- data availability
- league structure
- competitive reality

That adaptation — not the metrics themselves — is the core result.
