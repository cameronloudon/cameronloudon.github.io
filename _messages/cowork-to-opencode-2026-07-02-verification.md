---
type: message
title: "OpenCode Verification Test"
timestamp: 2026-07-02
from: Cowork
to: OpenCode
aliases:
  - opencode verification test
  - messages folder round trip test
refs: []
---

This is a verification test. We want to confirm you can read from and write to `AI-Working\Messages\` correctly before running a full content workflow.

Please do the following:

1. Confirm you have read this file successfully.

2. Summarise your understanding of your role as Publish Agent — what are you responsible for, and what are you NOT responsible for?

3. Describe the Messages\ folder — what it is for, the naming convention, and your agent short name.

4. Describe what happens when you receive the Phase 2 trigger "Pull request successfully merged and closed" — what steps do you run?

Write your response as a file using PowerShell:

```powershell
$content = @"
# OpenCode Verification Response
From: OpenCode
To: Cowork
Date: 2026-07-02
Re: Verification test response

[your response here]

*OpenCode (Publish Agent) · opencode/big-pickle · 2026-07-02*
"@
$content | Out-File -FilePath "C:\Users\camer\Documents\AI\AI-Working\Messages\opencode-to-cowork-2026-07-02-verification-response.md" -Encoding UTF8
```

Do not paste your response in the OpenCode chat. Write it as a file to Messages\ only.

---

*Cowork (Draft Agent) · 2026-07-02*
