# PassQuest

Gamified web app for teaching SHS students safe password habits — research output for *Analyzing SHS Students' Social Media Password Safety Habits at St. Paul University Manila Toward a Gamified Website Checklist* (St. Paul University Manila).

Created by **Dizon** and **Camantigue**, Grade 12 STEM Researchers & Creators of PassQuest, St. Paul University Manila.

- [How the research shapes PassQuest](#how-the-research-shapes-passquest)
- [Password Games](#password-games)
- [Run it on your computer](#run-it-on-your-computer)
- [The three files](#the-three-files)
- [Where to change things](#where-to-change-things)
- [How data is saved](#how-data-is-saved)
- [Fixed issues and what still needs you](#fixed-issues-and-what-still-needs-you)

---

## How the research shapes PassQuest

PassQuest is built as a **gamified learning + practice checklist**. Every level follows **Learn → Practice → Check → Feedback → Reward**, and Habit Mode adds **Maintain**.

| Level | Topic | Built mainly from |
|---|---|---|
| 1 | Password Basics | Security & Risk Awareness, Personal Experiences |
| 2 | Strong Password Creation | Security & Risk Awareness, Convenience & Memorability |
| 3 | Predictable Passwords & Personal Information | Convenience & Memorability, Personal Experiences, Social Influence |
| 4 | Password Management | Password Management Strategies, Convenience, Social Influence |
| 5 | **Password Maintenance** (SOP 2 lowest: 2.45, “Sometimes”) | Password Management Strategies, Awareness, Personal Experiences |
| 6 | Two-Factor Authentication & Account Protection | Awareness, Password Management Strategies |
| 7 | Phishing & Social Engineering | Awareness, Social Influence, Password Management Strategies |
| 8 | Account Recovery & Data Breaches | Personal Experiences, Awareness, Password Management Strategies |
| 9 | **Safe Login & Device Security** (SOP 2 highest: 3.65, “Always”) | Awareness, Password Management Strategies |
| 10 | Cybersecurity Challenge (capstone) | All five factors |

- **SOP 1 (five factors)** shows up as the scenarios and activities in each level. Every level and scenario is tagged with the factors it came from, and the tags appear on the level page.
- **SOP 2 (grand mean 3.1075, “Often”)** decides the emphasis:
  - Level 5, the monthly check-up, and the maintenance missions focus on the lowest-rated habit, updating passwords. They teach *intentional* maintenance, not constant changes.
  - Level 9 reinforces the highest-rated habit, safe logins on shared devices, with positive feedback.
- The **About the research** page (link in the app footer) and the landing page explain all of this for panelists and visitors.
- The site only ever uses **fictional** passwords and people. It never asks for a real password, and it doesn't claim to guarantee behavior change.

## Password Games

The **🎮 Password Games** tab has three optional mini-games. They practice the same findings as the levels and use the existing XP and badge systems; they don't add new ones.

| Game | How it plays | Research link |
|---|---|---|
| ⚡ **Reflex Sort** | Arcade, 45 seconds. Fictional passwords fly across the screen; tap only the weak ones. Speed goes up over time. Shows score, accuracy, combo (up to x4) and best score. | Security & Risk Awareness, Convenience & Memorability: spotting names, birthdays, common words and keyboard patterns. |
| 🚨 **Escape the Breach** | Timed story, 2 minutes, 4 tasks on the fictional account @mika.draws: spot the phishing message, take back control (including a friend's bad password advice), turn on 2FA and refuse to share the login code, then log out of a library PC and an unknown phone. | Personal Experiences, Awareness, Password Management Strategies, Social Influence. SOP 2: updating the password after a suspicious login (lowest, 2.45) and logging out of shared devices (highest, 3.65). |
| 🧩 **Password Challenge** | Puzzle, any pace. Build one fictional password while 18 rules appear one by one; every earlier rule still counts. Mixes silly rules (a color, an animal, a palindrome, no letter E) with research rules (no dates, no own name, no predictable patterns). Original rules and design, inspired by rule-stacking password games. | Convenience & Memorability, Awareness, Password Management Strategies, Personal Experiences. |

- **Privacy:** before Password Challenge starts, the game shows *"Use a fictional password only. Never enter a password you actually use."* The typed password is checked in the browser only. It is never saved to localStorage or sent to Supabase, and the box is cleared when the game ends.
- **XP:** game XP goes into bonus XP, the same pot as Habit Mode, so it counts toward lifetime and leaderboard XP but never toward level progress or certificates. Each game gives at most **25 XP per day**, so replays can't farm the leaderboard.
  - Reflex Sort: 5 per round, +5 for 80%+ accuracy, +5 for a new best.
  - Escape the Breach: 15 for securing the account, +5 with no mistakes, +5 for a new best; 5 if time runs out.
  - Password Challenge: 20 for finishing all rules, +5 for a new best time; 5 for reaching at least 9 rules.
- **Badges** (in `BADGE_DEFS`, saved like every other badge): 🏆 Reflex Rookie (300+ points with 80%+ accuracy), 🛡️ Breach Defender (secure the account), 🔐 Password Architect (satisfy every rule). There are now 28 badges.
- Each game ends with a results screen: score, time or accuracy, best, XP, any badge, and a short takeaway. Habit Mode's daily mission pool also includes "Play a round of any Password Game".

## Run it on your computer

Plain HTML, CSS and JavaScript: no framework, nothing to install or build.

1. Download or clone this repository.
2. Open the folder in VS Code and install the **Live Server** extension.
3. Right-click `checklist.html` and choose **Open with Live Server**.

Without VS Code, run `python -m http.server` in the folder and open `http://localhost:8000/checklist.html`.

You need an internet connection: the fonts and the Supabase library load from the web.

## The three files

The three files stay separate. `checklist.html` loads the other two.

| File | What it holds |
|---|---|
| `checklist.html` | The page shell: title, Lockie favicon, fonts, the animated background, and two empty boxes (`#toastHost`, `#app`) that `script.js` fills in. |
| `style.css` | All styling. It opens with a table of contents and has 21 numbered sections. |
| `script.js` | All content and behavior. It opens with a table of contents and has 25 numbered sections. |

To jump to a section, search the file for its number and a dot, for example `14.`.

**`script.js` sections**

| # | Section | # | Section |
|---|---|---|---|
| 1 | Supabase client | 14 | Pages: dashboard, learning path, level detail, quiz |
| 2 | Brand icon | 15 | Pages: checklist hub, password checker, Habit Mode |
| 3 | Research links + Foundation Track (Levels 1–5) | 16 | Pages: leaderboard, certificates, profile |
| 4 | Curriculum: Advanced Track (Levels 6–10) + XP totals | 17 | Password Games (Reflex Sort, Escape the Breach, Password Challenge) |
| 5 | Habit Mode content | 18 | Password strength engine + Lockie coach |
| 6 | Badges | 19 | Event wiring |
| 7 | Small helpers | 20 | Action handlers |
| 8 | Local save layer (localStorage) | 21 | Certificate PNG download |
| 9 | App state + boot | 22 | Supabase: data functions |
| 10 | Progress: XP, streak, Habit Mode refresh, badge checks | 23 | Supabase: page-load hooks |
| 11 | Lockie the mascot | 24 | Certificate template images (base64) |
| 12 | Rendering core: router, toasts, effects, celebration popup | 25 | Start the app |
| 13 | Pages: landing, login/register, app shell | | |

**`style.css` sections:** 1 Design tokens · 2 Base & reset · 3 Animated background · 4 Motion · 5 Layout helpers · 6 Shared components · 7 Landing page · 8 Login / register · 9 Modals & popups · 10 App shell · 11 Dashboard · 12 Learning path & level detail · 13 Checklist hub · 14 Password checker · 15 Habit Mode · 16 Leaderboard · 17 Certificates · 18 Toasts · 19 Lockie mascot · 20 Password Games · 21 Responsive

## Where to change things

| To change… | Go to |
|---|---|
| Lesson text, practice activities and scenarios, checklist items, quiz questions (Levels 1–5) | `script.js` section 3 (`CORE_LEVELS`) |
| Same for Levels 6–10 | `script.js` section 4 (`ADV_LEVELS`) |
| SOP 1 factor names, SOP 2 means, dashboard skill areas | `script.js` section 3 (`FACTORS`, `SOP2`, `SKILL_AREAS`) |
| About / research page text | `script.js` section 13 (`researchFindingsMarkup`, `researchBoxMarkup`, `creatorsMarkup`) |
| Daily missions, weekly challenges, tips, monthly check-up, quiz of the day | `script.js` section 5 |
| Badge names, icons, descriptions | `script.js` section 6 (`BADGE_DEFS`) |
| Lockie's look and poses | `script.js` section 11 (`mascotSVG`) |
| Lockie's password-coach lines | `script.js` section 18 (`coachAdvice`) |
| Game names, descriptions, research text, takeaways, daily XP cap | `script.js` section 17 (`GAMES`, `GAME_TAKEAWAYS`, `GAME_XP_DAILY_CAP`) |
| Reflex Sort passwords | `script.js` section 17 (`REFLEX_WEAK`, `REFLEX_STRONG`) |
| Escape the Breach story and choices | `script.js` section 17 (`BREACH_STEPS`) |
| Password Challenge rules and word lists | `script.js` section 17 (`PC_RULES`, `PC_COLORS`, `PC_ANIMALS`, `PC_FOODS`). Any new rule must still be solvable together with all the others. |
| Game look and layout | `style.css` section 20 |
| Landing page text, creators, research blurb | `script.js` section 13 (`viewLanding`) |
| Terms & Conditions text | `script.js` section 13 (`viewAuth`) |
| Top tabs (order and labels) | `script.js` section 13 (`viewAppShell`) |
| Colors, gradients, fonts, corner rounding | `style.css` section 1 |
| Certificate name/date/grade positions | **both** `style.css` section 17 (on-screen preview) **and** `script.js` section 21 (downloaded PNG). Keep them in sync. |
| Certificate template images | `script.js` section 24 |
| Favicon | `<head>` of `checklist.html` |

Each level must add up to 100 XP: Learn + Practice 20 (earned by finishing the practice) + checklist 30 + quiz 50. **Keep checklist `id`s and XP values unchanged.** Saved progress and Supabase records use them.

## How data is saved

Data is saved in two places at once.

**1. The browser (localStorage).** This is what the app itself reads back.

| Key | Holds |
|---|---|
| `passquest_users` | Every account created on that browser (passwords stored as salted SHA-256 hashes) |
| `passquest_session` | Who is logged in |
| `passquest_progress_<username>` | XP, lessons, checklist, quizzes, badges, streak, Habit Mode, Password Games stats (plays, best scores, XP earned today), leaderboard opt-in |
| `passquest_user_id` | The logged-in student's Supabase user id (set at register and login, cleared at logout) |

**2. Supabase** (`script.js` sections 22–23). Written alongside, for the research data.

| Table | Written when |
|---|---|
| `users` | A student registers, or logs in and has no row yet. `grade_level` = grade + strand, e.g. “Grade 12 · STEM” |
| `consent` | A student registers (they must tick the Terms checkbox) |
| `user_progress` | A lesson is marked read or a checklist item is checked |
| `checklist_responses` | A checklist item is checked |
| `user_badges` | A badge is earned (including the three game badges) |
| `leaderboard` | Only for students who opted in; `total_xp` = both tracks + bonus XP (Habit Mode and game XP). Removed when they leave |
| `certificates` | The Foundation certificate page is opened (once per visit) |
| `password_checker_results` | The student pauses typing in the Password Checker: the rating only (Very Weak 0 … Very Strong 4), never the password |

Read-only helpers for `lessons`, `checklist_items`, `checklist_categories`, `badges` and `achievements` exist in section 22 but aren't used by any page yet.

The Password Games add no new tables. Game stats stay in the browser only, and the Password Challenge password is never saved anywhere.

## Fixed issues and what still needs you

**Fixed in the research revision** (checked with an automated walkthrough against a stand-in database, so no real data was touched):

1. The test sign-up form and loose checkbox are removed from every page.
2. Logging in now points Supabase saves at the right student, and logging out clears it, so shared computers no longer mix students up.
3. The Password Checker saves its real rating (Very Weak, Weak, Fair, Strong, Very Strong) once typing pauses. The home page's demo is no longer saved.
4. The leaderboard reads from Supabase, only includes students who opted in, shows names safely, and removes the row when a student leaves.
5. Lifetime and leaderboard XP now include the Advanced Track.
6. `grade_level` gets the grade plus the strand ("Grade 12 · STEM") instead of the strand alone.
8. PassQuest passwords are stored as salted hashes. Older accounts are converted automatically the next time the site opens on that computer.
9. Daily items reset at local midnight, not 8:00 AM.
10. The certificate preview shrinks long dates and grades to fit, like the PNG does.
11. The checklist hub lists all 22 items, in both tracks.
12. Student-typed text is escaped before it's shown.

**Still needs you in the Supabase dashboard:**

- **Old leaderboard rows:** earlier versions added a leaderboard row for every student, including those who never opted in. Delete all rows in the `leaderboard` table once. Opted-in students' rows come back automatically the next time they log in.
- **"Leave leaderboard" needs delete permission:** if leaving doesn't remove the row, your table needs a policy that allows deletes.
- **Column types (issue 7):** checklist items are saved with text ids like `l1c1` in `checklist_responses.checklist_item_id` and `user_progress.lesson_id`. If those columns are number columns, those saves fail; check the browser console for red errors, or change the columns to text.
- **Older research data:**
  - `password_checker_results` rows from before this revision include fake "Very Strong" results from the home page.
  - `checklist_responses` rows from before this revision refer to the old checklist wording. The ids are the same, but some items were reworded to match the research.
  - Filter both by date if you analyze them.
- **Optional:** a `strand` column in `users` would let the strand be stored on its own instead of inside `grade_level`.
