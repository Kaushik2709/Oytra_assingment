# Task 2 — GitHub Trending Repos Morning Brief

## Overview
This n8n workflow automates the collection of top-performing JavaScript repositories from GitHub, enriches the data with README content for the highest-ranked repo, and delivers a formatted digest to a Discord channel every hour.

## APIs Used
1.  **GitHub Search API (`/search/repositories`)**: Used to fetch the top 10 JavaScript repositories sorted by stars. This endpoint provides broad metadata (name, stars, description, etc.).
2.  **GitHub Repos README API (`/repos/{owner}/{repo}/readme`)**: Used specifically for the #1 ranked repository to fetch its README content in base64 format. This provides deeper context for the "Trending" highlight.
3.  **Discord Webhook API**: Used to deliver the final digest and error notifications to a Discord channel.

## Workflow Logic
-   **Trigger**: A `Schedule Trigger` initiates the flow every 60 minutes.
-   **Transformation**: A `Code Node` filters the initial 10 results down to the Top 5 and extracts only the relevant fields (name, full_name, stars, etc.) to keep the data lightweight.
-   **Enrichment**: An `HTTP Request` node fetches the README for the first item in the list. The `continueOnFail: true` setting ensures that if a README is missing, the workflow still proceeds.
-   **Conditional Logic**: An `IF Node` checks if the top repository has >= 1000 stars to apply a "🔥 Trending" vs "📌 Notable" label.
-   **Digest Formatting**: A final `Code Node` aggregates the data into a clean Markdown string, decodes the base64 README, and truncates it to 300 characters for readability.

## Error Handling
-   **Node Level**: The "Enrich Top Repo" node has `Continue On Fail` enabled to prevent minor API hiccups from stopping the entire brief.
-   **Global Level**: An `Error Trigger` node is connected to a dedicated Discord webhook node. If any non-ignored node fails, a specialized alert message is sent to Discord with the error details.
