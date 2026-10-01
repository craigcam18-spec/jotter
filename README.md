# Jotter Planner

A lesson planner for Ellie's primary class. Set the timetable once, plan lessons into it, tick them off as they're taught, and move everything down a slot when a day gets disrupted. It works offline and syncs between her devices.

## What's in it

- **Today**: the day's blocks with the lesson in each, a "Now" marker, a taught tick, what's still unplanned this week, and **Move lessons down** for a disrupted day.
- **Week**: the whole week as a colour-coded grid. Tap any block to plan it.
- **Subjects**: one subject's lessons in order for the next nine weeks, with gaps showing. "Move down from here" shifts everything after a lesson.
- **Lesson sheet**: title, learning intention, success criteria, Es & Os, activities, support and challenge, resource links, and after-lesson notes. It saves as she types. "Copy to next slot" duplicates a lesson.
- **Setup**: timetable blocks, subjects and colours, holidays and in-service days (lessons skip over them), sync, and a backup download.

It holds lesson plans only, with no pupil names, which keeps it clear of pupil-data questions.

## Put it online (same as the meal-prep app)

1. Create a new GitHub repo (e.g. `jotter`) and upload every file in this folder.
2. In Cloudflare: **Workers & Pages → Create → Pages → Connect to Git**, pick the repo. Framework preset: **None**. Build command: blank. Output directory: `/`.
3. Open the `*.pages.dev` link on Ellie's iPad in Safari → **Share → Add to Home Screen**.

At this point it works, but only saves on the one device.

## Turn on sync (about 10 minutes, free)

1. Go to supabase.com, sign in with GitHub, **New project** (any name, pick the London region, save the database password somewhere).
2. **SQL Editor → New query**, paste everything from `supabase-setup.sql`, press **Run**.
3. **Authentication → Sign In / Providers → Email**: turn **Confirm email** off (simplest), or leave it on and she clicks the email link once.
4. **Project Settings → API**: copy the **Project URL** and the **anon public** key.
5. Paste them into the top of the `<script>` in `index.html`:
   ```js
   const SUPABASE_URL = "https://xxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOi...";
   ```
   Commit, and Cloudflare redeploys. (The anon key is designed to be public; the database rule in the SQL file stops anyone reading someone else's planner.)
6. On each device: **Setup → Sync between devices → Create account** once, then **Sign in** everywhere else with the same email.

The most recent change wins. If she edits the same thing on two devices while both are offline, the later save replaces the earlier one.

Free Supabase projects can be paused after about a week without use. If sync stops working after a long holiday, log in to supabase.com and press **Restore** on the project. Her planner is still saved on each device in the meantime.

## Updating it later

After changing `index.html`, also bump `VERSION` in `sw.js` (e.g. `jotter-v2`) so the iPad picks up the new version.
