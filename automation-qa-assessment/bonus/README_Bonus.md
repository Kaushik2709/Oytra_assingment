# Bonus Task — Uptime Monitor & Daily Digest

## Logic Overview
This workflow serves as a lightweight monitoring solution for the RealWorld demo application. It checks for availability, measures performance, and logs results for long-term analysis.

### Workflow Steps:
1.  **Trigger**: Runs every 5 minutes to ensure high-frequency monitoring.
2.  **Health Check**: Performs an `HTTP GET` request to `demo.realworld.io`. It includes a 10s timeout and `Continue On Fail` to handle network timeouts gracefully.
3.  **Validation (IF Node)**: 
    -   If the status code is **200**, it proceeds to performance analysis.
    -   If the status code is **anything else** (or the request fails), it triggers an immediate Discord alert.
4.  **Performance Analysis**: A Code node calculates the request duration. If the duration exceeds **3000ms**, the status is flagged as "slow" instead of "healthy".
5.  **Data Persistence**: All results (timestamp, status code, response time, health status) are appended to a Google Sheet via the Google Sheets API.
6.  **Daily Summary**: An additional IF node checks if the current hour is **9 AM**. If so, it sends a consolidated status summary to Discord.

## Credentials Required
-   **Discord Webhook**: For real-time alerts and daily summaries.
-   **Google Sheets API**: For appending rows to the tracking spreadsheet.
