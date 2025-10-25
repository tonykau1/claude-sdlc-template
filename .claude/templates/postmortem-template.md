# Postmortem: [INCIDENT TITLE]

**Date of Incident:** [YYYY-MM-DD]

**Duration:** [Start time] to [End time] ([X hours/minutes])

**Severity:** [Critical | High | Medium | Low]

**Status:** [Draft | Under Review | Approved]

**Author(s):** [Names]

**Reviewers:** [Names]

**Last Updated:** [YYYY-MM-DD]

---

## Executive Summary

**In 2-3 sentences, what happened?**

Example:
> On October 25, 2025, from 14:32 to 16:45 UTC, our API experienced a complete outage affecting all users globally. The root cause was a database connection pool exhaustion triggered by a code deployment that introduced an unintentional connection leak. We restored service by rolling back the deployment and restarting the database connection pools.

**Impact:**
- **Users Affected:** [Number or percentage]
- **Duration:** [X hours Y minutes]
- **Revenue Impact:** [$X estimated or N/A]
- **Customer Complaints:** [Number]

---

## Timeline (All times in UTC)

| Time | Event |
|------|-------|
| 14:32 | Deployment of v2.5.0 begins |
| 14:35 | Deployment completes successfully |
| 14:38 | First alerts: API response times increasing |
| 14:40 | Error rate spikes to 15% |
| 14:42 | On-call engineer paged |
| 14:45 | Incident commander assigned, war room opened |
| 14:50 | API completely unresponsive, error rate 100% |
| 14:55 | Investigation begins: checking servers, database, network |
| 15:10 | Database connection pool found to be exhausted |
| 15:15 | Decision made to rollback deployment |
| 15:20 | Rollback initiated |
| 15:25 | Rollback complete, service gradually recovering |
| 15:35 | Error rate down to 5% |
| 15:45 | All metrics back to normal |
| 16:00 | Monitoring continues, no new alerts |
| 16:45 | Incident declared resolved |

---

## Impact Assessment

### User Impact

**What could users not do?**
- [Affected functionality 1]
- [Affected functionality 2]

**What worked?**
- [Unaffected functionality 1]
- [Unaffected functionality 2]

### Quantitative Impact

- **Total Users Affected:** [Number]
- **Failed Requests:** [Number]
- **Successful Requests During Incident:** [Number]
- **Data Loss:** [Yes/No - if yes, describe]
- **Revenue Impact:** [$X or N/A]

### External Communication

- **Status Page Updated:** [Yes/No - time]
- **Customer Emails Sent:** [Yes/No - time]
- **Social Media Posts:** [Yes/No - time]
- **Support Tickets Created:** [Number]

---

## Root Cause

### What Went Wrong

**Primary Cause:**

[Detailed technical explanation of what caused the incident]

Example:
> The deployment introduced a new database query pattern in the UserService that opened a database connection but failed to close it in error cases. Over the course of 15 minutes, approximately 500 connections were leaked, exhausting the database connection pool (configured for 500 max connections). Once the pool was exhausted, all new requests requiring database access began failing.

**Contributing Factors:**

1. **[Factor 1]**
   - [How it contributed]

2. **[Factor 2]**
   - [How it contributed]

### Why Detection Was Delayed

- [Reason 1]
- [Reason 2]

### Why Recovery Took So Long

- [Reason 1]
- [Reason 2]

---

## What Went Well

### Good Responses

- ✅ [Something that worked well during the incident]
- ✅ [Another positive aspect]

Example:
- ✅ On-call engineer responded within 3 minutes of first alert
- ✅ Rollback process was smooth and well-documented
- ✅ Team communication was clear and frequent

### Systems That Held Up

- ✅ [System that continued working]
- ✅ [Monitoring that caught the issue]

---

## What Went Poorly

### Response Issues

- ❌ [Something that didn't work well]
- ❌ [Another issue]

Example:
- ❌ Root cause took 25 minutes to identify
- ❌ Database connection pool monitoring was not alerting
- ❌ No circuit breaker to prevent cascade failures

### Prevention Gaps

- ❌ [Gap in testing, monitoring, or processes]
- ❌ [Another gap]

---

## Action Items

### Immediate (This Week)

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| [Critical fix 1] | [Name] | [Date] | ⏳ |
| [Critical fix 2] | [Name] | [Date] | ⏳ |

### Short-term (This Month)

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| [Improvement 1] | [Name] | [Date] | ⏳ |
| [Improvement 2] | [Name] | [Date] | ⏳ |

### Long-term (This Quarter)

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| [Strategic improvement 1] | [Name] | [Date] | ⏳ |
| [Strategic improvement 2] | [Name] | [Date] | ⏳ |

---

## Prevention

### How We'll Prevent This Specific Issue

1. **[Prevention measure 1]**
   - [Details]
   - Owner: [Name]
   - Timeline: [Date]

2. **[Prevention measure 2]**
   - [Details]
   - Owner: [Name]
   - Timeline: [Date]

### How We'll Prevent Similar Issues

1. **[Broader improvement 1]**
   - [Details]
   
2. **[Broader improvement 2]**
   - [Details]

---

## Detection & Monitoring Improvements

### New Alerts to Create

- [ ] Alert on [metric] exceeds [threshold]
- [ ] Alert on [metric] exceeds [threshold]

### Monitoring Gaps to Fill

- [ ] Add monitoring for [system/metric]
- [ ] Improve visibility into [component]

### Improved Dashboards

- [ ] Create dashboard for [system]
- [ ] Add [metric] to existing dashboard

---

## Process Improvements

### Code Review

- [ ] [Specific review checklist item to add]
- [ ] [Another item]

### Testing

- [ ] [Type of test to add]
- [ ] [Testing scenario to cover]

### Deployment

- [ ] [Deployment process improvement]
- [ ] [Another improvement]

### Documentation

- [ ] [Documentation to create/update]
- [ ] [Runbook to improve]

---

## Lessons Learned

### Technical Lessons

1. **[Lesson 1]**
   - [Elaboration]

2. **[Lesson 2]**
   - [Elaboration]

### Process Lessons

1. **[Lesson 1]**
   - [Elaboration]

2. **[Lesson 2]**
   - [Elaboration]

---

## Supporting Information

### Related Incidents

- [Link to similar past incident]
- [Link to related incident]

### Code Changes

- **Problematic Commit:** [Link to commit]
- **Fix Commit:** [Link to commit]
- **Rollback Commit:** [Link to commit]

### Monitoring & Logs

- **Dashboard:** [Link]
- **Logs:** [Link or attachment]
- **Metrics:** [Link or screenshots]

### External References

- [Relevant documentation]
- [Third-party status pages]
- [Related bug reports]

---

## Follow-up Review

**Review Date:** [30 days after incident]

**Review Questions:**
- [ ] Were all action items completed?
- [ ] Have similar incidents occurred?
- [ ] Were the prevention measures effective?
- [ ] What additional improvements are needed?

---

## Appendix

### Detailed Technical Information

[Any additional technical details that are relevant but too detailed for the main sections]

### Communication Samples

**Status Page Update:**
```
[Copy of status page message]
```

**Customer Email:**
```
[Copy of email sent to customers]
```

---

**Postmortem Culture Notes:**

Remember:
- Blameless postmortems focus on systems and processes, not individuals
- The goal is learning and improvement, not punishment
- Everyone involved should feel safe sharing information
- We improve by being honest about what went wrong

---

**Last Updated:** [YYYY-MM-DD]

**Status:** [Draft | Under Review | Approved]
