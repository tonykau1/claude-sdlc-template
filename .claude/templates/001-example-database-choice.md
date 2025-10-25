# ADR 001: Database Choice for User Data

**Date:** 2025-10-25

**Status:** Accepted

**Deciders:** Engineering Team (Alice, Bob, Charlie), CTO (David)

**Tags:** database, architecture, backend

---

## Context

We're building a B2B SaaS application for project management that needs to store:
- User accounts and authentication data
- Projects, tasks, and comments
- File metadata (actual files stored in S3)
- Activity logs and audit trails
- Real-time collaboration features

**Technical Constraints:**
- Must scale to 100,000+ users within 2 years
- Need strong data consistency for financial/billing data
- Real-time updates required for collaborative features
- Budget: ~$500/month for database hosting initially

**Business Requirements:**
- GDPR compliance required (EU customers)
- Need to export user data on request
- 99.9% uptime SLA
- Fast query performance for dashboards

**Team Considerations:**
- Team has strong PostgreSQL experience
- Limited experience with NoSQL databases
- Small team (4 engineers), can't dedicate someone to DB ops

## Decision

**We will use PostgreSQL as our primary database, hosted on AWS RDS.**

**Reasoning:**
1. **ACID Guarantees:** Critical for billing and subscription data
2. **Team Expertise:** Team is productive with PostgreSQL, reducing risk
3. **Rich Query Capabilities:** Complex JOINs needed for dashboard queries
4. **JSON Support:** Can store flexible metadata in JSONB columns
5. **Mature Ecosystem:** Excellent tooling, libraries, and documentation
6. **Managed Service:** RDS handles backups, failover, and scaling

## Consequences

### Positive Consequences ✅

- **Strong Consistency:** No eventual consistency issues for critical data
- **Developer Productivity:** Team can start building immediately
- **Query Flexibility:** SQL provides powerful querying for complex reports
- **Data Integrity:** Foreign keys and constraints prevent data corruption
- **Compliance Friendly:** ACID properties help with audit requirements
- **Lower Operational Overhead:** RDS manages patches, backups, and high availability

### Negative Consequences ⚠️

- **Scaling Limitations:** Vertical scaling has limits; sharding is complex if needed
- **Cost at Scale:** RDS pricing increases with instance size
- **Real-time Challenges:** Need additional tools (Redis, WebSockets) for real-time features
- **Schema Changes:** Migrations on large tables can be slow
- **Possible Over-engineering:** Simple CRUD might not need full RDBMS power

### Neutral Consequences ℹ️

- **Learning Curve for New Hires:** Need PostgreSQL knowledge (but common skill)
- **Vendor Relationship:** Tied to AWS ecosystem (but using standard PostgreSQL)
- **Backup Strategy:** Need to configure and test RDS backups properly

## Alternatives Considered

### Alternative 1: MongoDB (NoSQL Document Store)

**Description:** Use MongoDB for flexible schema and horizontal scaling

**Pros:**
- Flexible schema (good for rapid prototyping)
- Horizontal scaling easier than PostgreSQL
- Popular with Node.js ecosystem
- Good for document-heavy data

**Cons:**
- Team has limited experience (slower development)
- Eventual consistency can cause issues for billing data
- No foreign keys (data integrity in application code)
- Overkill for our data structure (mostly relational)
- Less mature for complex queries

**Why not chosen:** Our data is highly relational, and team expertise with PostgreSQL outweighs MongoDB's scaling benefits at our current stage.

### Alternative 2: MySQL

**Description:** Use MySQL as a mature, widely-adopted RDBMS

**Pros:**
- Very mature and battle-tested
- Large community and ecosystem
- Good performance
- Team has some experience

**Cons:**
- Less feature-rich than PostgreSQL (limited JSON support)
- Some advanced features require paid editions
- PostgreSQL has better standards compliance
- Team prefers PostgreSQL syntax and features

**Why not chosen:** PostgreSQL offers more features we need (better JSON support, full-text search) while being equally mature.

### Alternative 3: DynamoDB (AWS NoSQL)

**Description:** Use AWS DynamoDB for serverless, scalable NoSQL database

**Pros:**
- Serverless (no server management)
- Automatic scaling
- Pay-per-request pricing (cost-effective at low scale)
- Integrated with AWS ecosystem

**Cons:**
- Eventual consistency by default (problems for billing)
- Query limitations (can't easily do complex JOINs)
- Team has zero experience
- Harder to model relational data
- Difficult to change access patterns after launch

**Why not chosen:** Our data is highly relational, and the query limitations would significantly complicate application code.

## Implementation Notes

**Key Implementation Steps:**
1. Set up RDS PostgreSQL instance (db.t3.medium initially)
2. Configure Multi-AZ for high availability
3. Set up automated backups (daily, 7-day retention)
4. Use connection pooling (PgBouncer) for efficiency
5. Implement database migrations using a tool (Flyway or Liquibase)
6. Create read replicas if read traffic grows

**Timeline:**
- Week 1: Set up RDS instance and access
- Week 2: Define initial schema
- Week 3: Implement migrations
- Week 4: Load test and optimize

**Dependencies:**
- AWS account with RDS access
- Database migration tool selected
- Connection pooling strategy

**Migration Path:**
- If we outgrow single instance: Add read replicas
- If read replicas insufficient: Implement caching (Redis)
- If still insufficient: Consider sharding or multi-region

**Rollback Strategy:**
- If PostgreSQL proves inadequate: Re-evaluate in Q3 2026
- Data export scripts to be written upfront for portability

## Validation

**How will we know if this decision was correct?**

**Success Criteria:**
- Database can handle 10,000 concurrent users without performance degradation
- Query response times < 100ms for 95th percentile
- Zero data loss incidents
- Developers can implement features without database limitations
- Database costs stay within $500/month for first year

**Metrics to Monitor:**
- Query performance (via pg_stat_statements)
- Connection pool utilization
- Disk I/O and CPU usage
- Replication lag (if using replicas)
- Database costs vs. usage

**Timeline for Evaluation:**
- 6-month review (April 2026): Assess performance and cost
- 12-month review (October 2026): Decide if scaling strategy needs adjustment

**Conditions that might trigger reconsideration:**
- Query performance degrades below SLAs
- Scaling costs exceed 20% of infrastructure budget
- Team finds PostgreSQL limitations blocking key features
- Real-time requirements can't be met with current architecture

## References

**Related Resources:**
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [AWS RDS Best Practices](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html)
- [Team Discussion (Slack)](https://company.slack.com/archives/C123/p1234567890)
- [Database Benchmark Results](https://company.notion.so/db-benchmarks)
- [Similar ADR from CompanyX](https://github.com/company-x/architecture-decisions/blob/main/005-database.md)

**Research Articles:**
- "PostgreSQL vs MongoDB for SaaS Applications" - [Link]
- "Scaling PostgreSQL: What Works" - [Link]

## Notes

**Assumptions Made:**
- User data growth will be predictable and gradual
- Most queries will be read-heavy (10:1 read:write ratio)
- Real-time features can be handled with separate pub/sub system
- GDPR compliance doesn't require data residency in specific regions initially

**Open Questions:**
- ~~How will we handle real-time collaboration?~~ Answered: Use Redis pub/sub + WebSockets
- ~~What's the data retention policy?~~ Answered: 7 years for financial data, flexible for others

**Future Considerations:**
- If we add time-series data (metrics, analytics), consider TimescaleDB extension
- If full-text search becomes critical, consider Elasticsearch for search index
- Multi-region expansion will require replication strategy

---

## Example of How to Use This ADR

This ADR demonstrates:
1. **Clear problem statement** in Context
2. **Explicit decision** with reasoning
3. **Honest assessment** of consequences (both good and bad)
4. **Thoughtful alternatives** that were seriously considered
5. **Practical implementation** details
6. **Measurable success criteria** for validation

When creating your own ADRs, aim for this level of detail for significant decisions.
