# Segunda División 2024/25 — Contextual League Analysis

This project applies the **same analytical framework used for La Liga** to Spain’s Segunda División, with one central question:

> **How does the analytical context change when moving from La Liga to Segunda División?**

Rather than introducing new metrics or models, the objective is to **observe how identical questions behave under a different competitive environment**.

The focus is not comparison for ranking purposes, but **contextual understanding**.

---

## 🎯 Project Objective

Build a **league-level, context-aware understanding** of the Segunda División by:

- Reusing a consistent analytical framework  
- Adapting it honestly to data availability and competition structure  
- Avoiding premature conclusions at player or recruitment level  

This project focuses on:
- league structure  
- home advantage  
- competitive compression  
- outcome-based efficiency  
- defensive stability  

**Out of scope by design:**
- player-level analysis  
- recruitment use cases  
- predictive modeling  

---

## 📊 Data Source & Collection

### Source
- **FBref** — match-level data (Scores & Fixtures)

### Season
- **2024/25** (completed season)

---

### Scraping Constraints & Resolution

During data collection, FBref introduced an additional anti-bot / security layer, causing standard HTTP requests to return an interstitial page instead of the rendered table.

**Attempted approaches:**
- Direct HTTP requests (blocked)  
- Export options (not available for this competition)  
- Static HTML parsing (incomplete)  

**Final solution:**
- Load the page in a real browser context using **Playwright**  
- Extract rendered HTML  
- Parse the table locally  

This approach ensured **data completeness and reproducibility**.

---

## 🧱 Data Model & Pipeline

### Match-level table
`matches`

Each row represents a single match, with the following schema:

- `date`  
- `home_team`  
- `away_team`  
- `score`  
- `attendance`  
- `venue`  

> ⚠️ **Expected Goals (xG) data is not available** for this competition and season.

---

### Competition Structure Handling

The Segunda División includes **promotion playoffs**, which are not part of the regular league format.

To preserve analytical consistency:

- **Regular season:** 462 matches  
- **Playoffs:** 6 matches  

Playoff matches are **explicitly excluded** from the analytical baseline.

---

### Views Created

#### Match-level
- `matches_regular_season`  
- `matches_playoffs`  

#### Team-level  
(duplication applied *after* context separation)

- `team_matches_regular`  
- `team_matches_playoffs`  

> **Design principle:**  
> Context is resolved *before* duplicating matches into team-level rows.  
> This prevents playoff leakage into league-wide metrics and simplifies downstream analysis.

---

## 🧪 Sanity Checks

A dedicated `00_sanity_checks.sql` file validates:

- correct number of matches (462 regular, 6 playoffs)  
- correct team count (22)  
- 42 matches per team  
- correct home/away duplication  
- score format consistency  
- absence of NULLs in mandatory fields  
- no playoff matches leaking into regular-season data  

All checks pass before analysis begins.

---

## 🔍 Analytical Framework

The analysis follows five structured steps.

### 01 — Season Overview  
**Purpose:** describe the league environment.

- total matches  
- total goals  
- goals per match  
- attendance range and average  

No rankings or interpretations at this stage.

---

### 02 — Home vs Away Context  
**Purpose:** understand the role of home advantage.

- goals scored at home vs away  
- distribution of results (home win / draw / away win)  

Key question:
> Is home advantage about dominance, or about avoiding defeat?

---

### 03 — Team-Level Context  
**Purpose:** observe league compression and competitive structure.

- goals for and against  
- goal difference  
- points and points per match  
- home vs away point accumulation  

Rankings are shown for orientation only.  
The analysis focuses on **distribution and spread**, not “best teams”.

---

### 04 — Outcome Efficiency Outliers  
**Purpose:** identify different paths to similar results.

Due to the absence of xG:
- efficiency is **outcome-based**, not process-based  

The key comparison is between:
- goal difference per match  
- points per match  

An `outcome_efficiency_delta` is used as a **descriptive aid**, not a performance metric.

> This highlights *survivors vs dominators*, not overperformance.

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

This project intentionally does **not** include:

- player-level metrics  
- recruitment analysis  
- clustering  
- predictive models  
- cross-season comparisons  
- live or real-time data  

These are deferred to future work.

---

## 🧠 Key Takeaways (High Level)

- The Segunda División is **highly compressed**.  
- Home advantage acts more as **protection against defeat** than dominance.  
- Defensive stability keeps teams competitive, but does not ensure top positions.  
- Similar point totals are achieved through **very different competitive paths**.  
- Analytical frameworks do not transfer automatically between leagues — even within the same country.

---

## 📦 Outputs

- Clean match-level dataset  
- Reproducible SQL queries  
- Clear separation of competition context  
- A league-level baseline suitable for:
  - future player analysis  
  - recruitment-oriented extensions  
  - structured comparison with La Liga  

---

## 🧭 Final Note

This project prioritizes **analytical honesty over symmetry**.

Rather than forcing La Liga assumptions onto a different competition, the framework adapts to:
- data availability  
- league structure  
- competitive reality  

That adaptation — not the metrics themselves — is the core result.