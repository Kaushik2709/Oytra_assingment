# Project Accomplishments Summary

This document provides a comprehensive overview of the work performed during the Automation & QA Assessment. The project focused on manual and automated testing, API integration, and workflow automation.

---

## 1. Task 1: QA Bug Report (demo.realworld.io)
**Deliverable:** `automation-qa-assessment/Task1_QA_Report.md`

Conducted a thorough manual and exploratory testing session of the Conduit application to identify critical and medium-severity issues.

### Key Bugs Identified:
1.  **Critical: CORS Policy Blocking API Requests** - Identified that the Global Feed fails to load due to missing `Access-Control-Allow-Origin` headers on the backend.
2.  **High: Stale JWT Persistence (Zombie Session)** - Analyzed how the UI remains in an authenticated state even when the token is invalidated, leading to silent failures.
3.  **High: Password Change Security Flaw** - Found that the system accepts single-character or empty passwords in settings, compromising account security.
4.  **Medium: Permissive Email Validation** - Discovered that the registration system accepts invalid email formats (e.g., `user@com`).
5.  **Low: Missing UI Loading States** - Noted a lack of visual feedback during article page transitions.

### Root-Cause Analysis (Issue #3):
Provided a detailed technical breakdown of the "Zombie Session" bug, explaining the lack of boot-time token validation and the absence of global 401 interceptors. Proposed a two-step fix: boot-time validation via `GET /user` and a global Axios/Fetch response interceptor.

### Utilities:
-   **`convert_to_pdf.sh`**: A shell script located in `task1/` to automate the conversion of the Markdown report into a professional PDF using `md-to-pdf` or `pandoc`.

---

## 2. Task 2: GitHub Trending Repos Morning Brief (n8n Workflow)
**Deliverable:** `automation-qa-assessment/task2/Task2_Workflow.json`

Developed a production-ready n8n workflow that fetches, processes, and delivers a daily summary of JavaScript trends.

### Technical Implementation:
-   **Scheduling**: Configured to run every hour via a `Schedule Trigger`.
-   **Multi-Stage API Consumption**:
    -   Used **GitHub Search API** to fetch top 10 repos.
    -   Used **GitHub README API** to fetch content for the #1 repo.
-   **Data Processing**: 
    -   Implemented a `Code Node` to filter the Top 5 results and minimize payload size.
    -   Decoded Base64 README content and truncated it to 300 characters for readability.
-   **Conditional Formatting**: Added logic to tag repositories with "🔥 Trending" or "📌 Notable" based on star counts (>= 1000).
-   **Discord Integration**: Formatted a clean Markdown digest for delivery via Discord Webhooks.

### Resilience Features:
-   **Continue On Fail**: Enabled on non-critical nodes (e.g., README fetching) to ensure the brief is sent even if one repository has missing documentation.
-   **Global Error Handling**: Integrated an `Error Trigger` node that sends an immediate diagnostic alert to a dedicated Discord channel if the workflow crashes.

---

## 3. Bonus Task: Uptime Monitor & Daily Health Digest
**Deliverable:** `automation-qa-assessment/bonus/Bonus_UptimeMonitor.json`

Engineered a robust uptime monitoring solution specifically for the `demo.realworld.io` application.

### Workflow Logic:
-   **High-Frequency Probing**: Runs every 5 minutes.
-   **Advanced Health Validation**: 
    -   Checks status codes (success vs. failure).
    -   Calculates response latency; flags results as "Slow" if the duration exceeds 3000ms.
-   **Persistence**: Logs every probe result (timestamp, health status, response time) into a **Google Sheet** for long-term SLA reporting.
-   **Intelligent Alerting**:
    -   **Immediate**: Sends a Discord notification the moment a downtime is detected.
    -   **Scheduled**: Sends a consolidated health summary at 9 AM daily.

---

## 4. Technical Stack
-   **Testing**: Chrome DevTools, Postman.
-   **Automation**: n8n (Workflow Automation Platform).
-   **Scripting**: Bash, JavaScript (within n8n nodes).
-   **Integrations**: GitHub API, Discord Webhooks, Google Sheets API.
-   **Documentation**: Markdown.

---

## 5. Directory Structure
```text
automation-qa-assessment/
├── Task1_QA_Report.md      # Detailed Bug Report & RCA
├── task1/
│   └── convert_to_pdf.sh   # PDF Export Utility
├── task2/
│   ├── Task2_Workflow.json # GitHub Digest Workflow
│   └── README_Task2.md     # Task 2 Documentation
└── bonus/
    ├── Bonus_UptimeMonitor.json # Uptime Monitor Workflow
    └── README_Bonus.md     # Bonus Task Documentation
```
