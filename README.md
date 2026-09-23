# PassQuest

Gamified web app for teaching SHS students safe password habits — research output for *Analyzing SHS Students' Social Media Password Safety Habits at St. Paul University Manila Toward a Gamified Website Checklist* (St. Paul University Manila).

Created by **Dizon** and **Camantigue**, Grade 12 STEM Researchers & Creators of PassQuest, St. Paul University Manila.

- [Run it on your computer](#run-it-on-your-computer)
- [The three files](#the-three-files)
- [Where to change things](#where-to-change-things)
- [How data is saved](#how-data-is-saved)
- [Known issues that need a decision](#known-issues-that-need-a-decision)

---

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
| `checklist.html` | The page shell: title, Lockie favicon, fonts, the animated background, and two empty boxes (`#toastHost`, `#app`) that `script.js` fills in. It also has a **test-only** Supabase sign-up form at the bottom (see known issues). |
| `style.css` | All styling. It opens with a table of contents and has 20 numbered sections. |
| `script.js` | All content and behavior. It opens with a table of contents and has 24 numbered sections. |

To jump to a section, search the file for its number and a dot, for example `14.`.

**`script.js` sections**

| # | Section | # | Section |
|---|---|---|---|
| 1 | Supabase client | 13 | Pages: landing, login/register, app shell |
| 2 | Brand icon | 14 | Pages: dashboard, learning path, level detail, quiz |
| 3 | Curriculum: Foundation Track (Levels 1–5) | 15 | Pages: checklist hub, password checker, Habit Mode |
| 4 | Curriculum: Advanced Track (Levels 6–10) + XP totals | 16 | Pages: leaderboard, certificates, profile |
| 5 | Habit Mode content | 17 | Password strength engine + Lockie coach |
| 6 | Badges | 18 | Event wiring |
| 7 | Small helpers | 19 | Action handlers |
| 8 | Local save layer (localStorage) | 20 | Certificate PNG download |
| 9 | App state + boot | 21 | Supabase: data functions |
| 10 | Progress: XP, streak, Habit Mode refresh, badge checks | 22 | Supabase: page-load hooks |
| 11 | Lockie the mascot | 23 | Certificate template images (base64) |
| 12 | Rendering core: router, toasts, effects, celebration popup | 24 | Start the app |

**`style.css` sections:** 1 Design tokens · 2 Base & reset · 3 Animated background · 4 Motion · 5 Layout helpers · 6 Shared components · 7 Landing page · 8 Login / register · 9 Modals & popups · 10 App shell · 11 Dashboard · 12 Learning path & level detail · 13 Checklist hub · 14 Password checker · 15 Habit Mode · 16 Leaderboard · 17 Certificates · 18 Toasts · 19 Lockie mascot · 20 Responsive

## Where to change things

| To change… | Go to |
|---|---|
| Lesson text, checklist items, quiz questions (Levels 1–5) | `script.js` section 3 (`CORE_LEVELS`) |
| Same for Levels 6–10 | `script.js` section 4 (`ADV_LEVELS`) |
| Daily missions, weekly challenges, tips, monthly check-up, quiz of the day | `script.js` section 5 |
| Badge names, icons, descriptions | `script.js` section 6 (`BADGE_DEFS`) |
| Lockie's look and poses | `script.js` section 11 (`mascotSVG`) |
| Lockie's password-coach lines | `script.js` section 17 (`coachAdvice`) |
| Landing page text, creators, research blurb | `script.js` section 13 (`viewLanding`) |
| Terms & Conditions text | `script.js` section 13 (`viewAuth`) |
| Top tabs (order and labels) | `script.js` section 13 (`viewAppShell`) |
| Colors, gradients, fonts, corner rounding | `style.css` section 1 |
| Certificate name/date/grade positions | **both** `style.css` section 17 (on-screen preview) **and** `script.js` section 20 (downloaded PNG). Keep them in sync. |
| Certificate template images | `script.js` section 23 |
| Favicon | `<head>` of `checklist.html` |

Each level must add up to 100 XP: lesson 20 + checklist 30 + quiz 50.

## How data is saved

Data is saved in two places at once.

**1. The browser (localStorage).** This is what the app itself reads back.

| Key | Holds |
|---|---|
| `passquest_users` | Every account created on that browser |
| `passquest_session` | Who is logged in |
| `passquest_progress_<username>` | XP, lessons, checklist, quizzes, badges, streak, Habit Mode, leaderboard opt-in |
| `passquest_user_id` | The student's Supabase user id (set when they register) |

**2. Supabase** (`script.js` sections 21–22). Written alongside, for the research data.

| Table | Written when |
|---|---|
| `users` | A student registers (also by the test form in `checklist.html`) |
| `consent` | A student registers (they must tick the Terms checkbox) |
| `user_progress` | A lesson is marked read or a checklist item is checked |
| `checklist_responses` | A checklist item is checked |
| `user_badges` | A badge is earned |
| `leaderboard` | After every `user_progress` save, and when leaderboard XP changes |
| `certificates` | The Foundation certificate page is opened |
| `password_checker_results` | A strength label appears on the page (see known issues) |

Read-only helpers for `lessons`, `checklist_items`, `checklist_categories`, `badges` and `achievements` exist in section 21 but aren't used by any page yet.

## Known issues that need a decision

These were found while organizing the code. None of them have been changed, because each one affects saved data, research data, or certificate layout.

1. **Test sign-up form on every page.** The form (Full Name, Email, Grade Level, Section) and a loose checkbox show below every page. The form writes to the `users` table.
2. **Supabase user id isn't switched on login.** `passquest_user_id` is only set when someone registers. On a shared computer, the next student's progress is saved under the previous student's id. A student who logs in on a new device saves nothing to Supabase.
3. **Password checker auto-save records the wrong things.** It scans the whole page for the words Weak, Medium, Strong or Very Strong. The checker's labels are Very Weak, Weak, Fair, Strong and Very Strong, so Very Weak and Fair are never saved and Medium never appears. The home page's decorative "Very Strong" demo gets saved as a real result for a remembered student, for example after they log out.
4. **Leaderboard.** The on-site leaderboard uses `window.storage`, which only exists inside Claude's preview, so on a real website it always shows "No rankings yet". The Supabase `leaderboard` table gets a row after a student's first lesson, **even if they never opted in**. Its `total_xp` counts only lessons and checklist items, not quizzes or bonus XP.
5. **Lifetime XP leaves out the Advanced Track.** `grandTotalXP()` is Foundation XP plus bonus XP, and it's the number shown as Lifetime XP and used for leaderboard ranking.
6. **Strand saved as grade level.** Registration sends the strand ("STEM", "ABM"…) into `users.grade_level`.
7. **Mixed id types.** Checklist items are saved with text ids like `l1c1` in `checklist_responses.checklist_item_id` and `user_progress.lesson_id`, while lessons use numbers 1–10. If those columns are number columns in Supabase, these saves fail. Check the browser console for red errors.
8. **Passwords stored in plain text.** `passquest_users` keeps every account's PassQuest password readable in the browser, so on a shared lab computer anyone can open the developer tools and see them. Supabase Auth would fix this.
9. **Daily reset happens at 8:00 AM in Manila, not midnight.** Day keys use UTC, which affects missions, tip, quiz of the day and streaks. The "refreshes in Xh" counter counts to local midnight.
10. **Certificate preview cuts off long text.** On screen, long dates and the grade/section get "…" ("September 2…", "Grade 12 - …"). The downloaded PNG is fine because it shrinks the text to fit.
11. **Checklist hub shows the Foundation Track only.** It's unclear whether that's intended, since the Checklist Master badge also counts only those 11 items.
12. **Names go into the page as raw HTML.** That's harmless while students only see their own name. It should be escaped before a shared leaderboard shows other students' names.
