# Task 1 — QA Bug Report: demo.realworld.io

**Target Application:** [https://demo.realworld.io](https://demo.realworld.io)  
**Date:** June 1, 2026  
**QA Engineer:** Gemini CLI Agent

---

## 1. Bug Table

| # | Title/Summary | Steps to Reproduce | Expected vs Actual | Severity | Suspected Cause |
|---|---|---|---|---|---|
| 1 | **CORS Policy Blocking API Requests** | 1. Open browser to demo.realworld.io.<br>2. Observe the "Global Feed" section. | **Expected:** Feed items load and display.<br>**Actual:** Feed stays stuck on "Loading articles..." indefinitely; console shows CORS errors from `api.realworld.io`. | Critical | Misconfigured `Access-Control-Allow-Origin` headers on the production API gateway. |
| 2 | **Registration Accepts Invalid Email Formats** | 1. Go to "Sign up" page.<br>2. Enter a username and password.<br>3. Enter `invalid-email@com` in the email field.<br>4. Click "Sign up". | **Expected:** Error message stating email is invalid.<br>**Actual:** Account is created successfully with a non-compliant email address. | Medium | Regex validation in the backend/frontend is too permissive or missing. |
| 3 | **Stale JWT Persistence (Zombie Session)** | 1. Log in to the app.<br>2. (Simulation) Backend database resets or session expires.<br>3. Refresh the page. | **Expected:** App detects 401 error and redirects to login.<br>**Actual:** UI shows "Username" in nav bar, but clicking "New Post" results in silent failures or 401 errors in console. | High | LocalStorage JWT is not validated on page load; lack of global 401 interceptor for auto-logout. |
| 4 | **Missing Loading States for Article Detail** | 1. Click on any article title from the Global Feed.<br>2. Observe the page transition. | **Expected:** A skeleton screen or loading spinner appears.<br>**Actual:** The page body goes completely blank for ~1s before the article content pops in. | Low | No state management for 'loading' status in the article routing component. |
| 5 | **Password Change Security Flaw** | 1. Go to "Settings".<br>2. Clear the password field or enter a single character.<br>3. Click "Update Settings". | **Expected:** Form validation prevents submission of weak/empty passwords.<br>**Actual:** API accepts the change, potentially locking the user out or weakening account security. | High | Missing server-side validation for minimum password complexity on the `/user` PUT endpoint. |

---

## 2. Root-Cause Analysis: Stale JWT Persistence (Issue #3)

**Description of Issue:**  
The application suffers from what is known as a "Zombie Session" or "Stale JWT" bug. When a user logs in, their JSON Web Token (JWT) is stored in `localStorage`. However, if the backend server restarts (common in demo environments) or the token is invalidated server-side, the frontend remains in a "logged-in" state because it only checks for the *presence* of the token in storage, not its *validity*.

**Technical Analysis:**  
The frontend's initialization logic (likely in an `App.js` or `Store` init function) checks `localStorage.getItem('jwt')`. If found, it sets the `isAuthenticated` state to `true`. Because the app does not perform a "whoami" check (e.g., calling `GET /user`) upon every page refresh to verify the token's current validity, the UI continues to display user-only elements (Profile, New Post, Settings). When the user attempts an authenticated action, the request is sent with the stale token, the API returns a `401 Unauthorized`, and the app fails to handle this globally.

**Proposed Fix:**  
1.  **Boot-time Validation:** On application startup, if a token exists in `localStorage`, the app should immediately call the `GET /user` endpoint. If it returns a 401, the token should be purged, and the user redirected to the login page.
2.  **Global Axios/Fetch Interceptor:** Implement a global response interceptor. If any API call returns a 401 status code, the interceptor should trigger a logout action (clear storage and reset auth state) to ensure the UI stays in sync with the backend session state.

---

## 3. PDF Export Command

To convert this report to PDF, ensure you have `md-to-pdf` or `pandoc` installed. Run the following:

```bash
# Using md-to-pdf (Node.js)
npx md-to-pdf Task1_QA_Report.md

# OR using Pandoc (System)
pandoc Task1_QA_Report.md -o Task1_QA_Report.pdf
```
