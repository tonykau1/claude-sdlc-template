# Security Review Checklist

Perform this security review for every feature before deployment. Think like an attacker!

## 🔐 Authentication & Authorization

### Authentication
- [ ] **Password security**
  - Passwords hashed with bcrypt/argon2?
  - Minimum password requirements enforced?
  - Password complexity rules reasonable?
  - No password in logs or error messages?

- [ ] **Session management**
  - Session tokens cryptographically secure?
  - Session expiration implemented?
  - Sessions invalidated on logout?
  - Concurrent session handling appropriate?

- [ ] **Account protection**
  - Account lockout after failed attempts?
  - Rate limiting on login endpoint?
  - Password reset flow secure?
  - Email verification required?

- [ ] **MFA/2FA** (if applicable)
  - Two-factor authentication available?
  - Backup codes provided?
  - TOTP implemented securely?

### Authorization
- [ ] **Access control**
  - Every endpoint checks permissions?
  - Principle of least privilege applied?
  - Role-based access control (RBAC) implemented?
  - No authorization bypass possible?

- [ ] **Resource ownership**
  - Users can only access their own resources?
  - Direct object references checked?
  - IDOR (Insecure Direct Object Reference) prevented?

- [ ] **Privilege escalation prevented**
  - Users can't elevate their own permissions?
  - Admin actions require admin role?
  - Role changes audited?

## 💉 Input Validation & Injection

### SQL Injection
- [ ] **Queries parameterized**
  - No string concatenation in queries?
  - ORM used correctly?
  - Prepared statements used?
  - Dynamic queries avoided?

- [ ] **Input sanitized**
  - User input never directly in SQL?
  - Special characters escaped?
  - Input length limited?

### XSS (Cross-Site Scripting)
- [ ] **Output encoding**
  - User content HTML-escaped?
  - Framework escaping enabled?
  - Dangerous HTML tags stripped?
  - Content-Type headers correct?

- [ ] **Dangerous APIs avoided**
  - No `dangerouslySetInnerHTML` (React)?
  - No `v-html` with user content (Vue)?
  - No `eval()` with user input?
  - No `innerHTML` with user content?

### Command Injection
- [ ] **Shell commands avoided**
  - No system calls with user input?
  - If unavoidable, input strictly validated?
  - Safer alternatives used?

### Path Traversal
- [ ] **File paths validated**
  - User input not in file paths?
  - Path traversal sequences blocked (../, ../)?
  - Whitelist approach for file access?

### Other Injection
- [ ] **LDAP injection prevented**
- [ ] **XML injection prevented**
- [ ] **Template injection prevented**
- [ ] **NoSQL injection prevented**

## 🔑 Secrets & Credentials

- [ ] **No secrets in code**
  - API keys not in source code?
  - Passwords not hardcoded?
  - Private keys not committed?
  - Database credentials externalized?

- [ ] **Environment variables used**
  - Secrets in environment variables?
  - `.env` file not committed?
  - `.env.example` updated?

- [ ] **Secrets not logged**
  - Passwords not in logs?
  - API keys not in error messages?
  - Tokens not in debug output?

- [ ] **Secrets management**
  - Secrets rotated regularly?
  - Different secrets per environment?
  - Access to secrets limited?

## 🔒 Data Protection

### Encryption
- [ ] **Data at rest encrypted**
  - Sensitive data encrypted in database?
  - Encryption keys managed properly?
  - Strong encryption algorithms used (AES-256)?

- [ ] **Data in transit encrypted**
  - HTTPS enforced everywhere?
  - TLS 1.2+ required?
  - No mixed content warnings?
  - Certificate valid and trusted?

### Sensitive Data
- [ ] **PII properly handled**
  - Personally Identifiable Information minimized?
  - Data retention policy enforced?
  - GDPR/CCPA compliance (if applicable)?
  - User consent obtained?

- [ ] **Payment data secure**
  - Credit cards never stored (use Stripe, etc.)?
  - PCI-DSS compliance (if applicable)?
  - Payment flow secure?

- [ ] **Health data protected**
  - HIPAA compliance (if applicable)?
  - PHI encrypted and access logged?

## 🌐 API Security

- [ ] **Authentication required**
  - All endpoints require auth (except public ones)?
  - Token validation on every request?
  - API keys not in URLs?

- [ ] **Rate limiting implemented**
  - Per user/IP rate limits?
  - Prevents brute force?
  - Prevents DOS?

- [ ] **CORS configured properly**
  - Not wildcard (*) in production?
  - Specific origins whitelisted?
  - Credentials handling correct?

- [ ] **Input validation**
  - Request body validated?
  - Query parameters validated?
  - Headers validated?
  - File uploads restricted?

- [ ] **Error responses secure**
  - No stack traces in production?
  - Generic error messages externally?
  - Detailed logs internally only?

## 🛡️ CSRF & SSRF Protection

### CSRF (Cross-Site Request Forgery)
- [ ] **CSRF tokens used**
  - State-changing operations protected?
  - CSRF token validated?
  - SameSite cookie attribute set?

- [ ] **Double-submit cookie** (alternative)
  - Cookie and header match?

### SSRF (Server-Side Request Forgery)
- [ ] **URL validation**
  - User-provided URLs validated?
  - Internal IPs blocked?
  - Cloud metadata endpoints blocked?
  - URL scheme whitelisted?

## 🔐 Session & Cookie Security

- [ ] **Secure cookies**
  - `Secure` flag set (HTTPS only)?
  - `HttpOnly` flag set (no JavaScript access)?
  - `SameSite` attribute set?
  - Appropriate expiration set?

- [ ] **Session fixation prevented**
  - Session ID regenerated on login?
  - Old session invalidated?

## 📝 Logging & Monitoring

- [ ] **Security events logged**
  - Failed login attempts?
  - Permission denials?
  - Suspicious activity?
  - Admin actions?

- [ ] **Logs protected**
  - Sensitive data not logged?
  - Logs access restricted?
  - Log tampering prevented?

- [ ] **Monitoring configured**
  - Alerts for suspicious patterns?
  - Rate limit violations tracked?
  - Failed auth attempts monitored?

## 🌐 HTTP Security Headers

- [ ] **Security headers configured**
  ```
  Content-Security-Policy: default-src 'self'
  X-Content-Type-Options: nosniff
  X-Frame-Options: DENY
  X-XSS-Protection: 1; mode=block
  Strict-Transport-Security: max-age=31536000
  Referrer-Policy: no-referrer
  Permissions-Policy: geolocation=(), camera=()
  ```

- [ ] **CSP (Content Security Policy)**
  - No inline scripts (or nonce/hash used)?
  - External resources whitelisted?
  - Report-only mode tested first?

## 📦 Dependencies & Supply Chain

- [ ] **Dependencies scanned**
  - `npm audit` / `pip audit` run?
  - Known vulnerabilities addressed?
  - Dependency updates recent?

- [ ] **Dependency integrity**
  - Lock files committed?
  - Subresource Integrity for CDN resources?
  - Dependencies from trusted sources?

- [ ] **License compliance**
  - Licenses reviewed?
  - No GPL in proprietary code?
  - License obligations met?

## 🔍 Vulnerability Testing

### Automated Scanning
- [ ] **SAST (Static Analysis)**
  - Code scanned for vulnerabilities?
  - SonarQube / Semgrep / Bandit run?

- [ ] **DAST (Dynamic Analysis)**
  - Running app scanned?
  - OWASP ZAP / Burp Suite used?

- [ ] **Dependency scanning**
  - Snyk / Dependabot configured?
  - Vulnerability alerts enabled?

### Manual Testing
- [ ] **Tested as attacker**
  - Tried SQL injection on inputs?
  - Tried XSS payloads?
  - Tried accessing other users' data?
  - Tried privilege escalation?

- [ ] **Fuzzing attempted**
  - Invalid input tested?
  - Boundary conditions tested?
  - Unexpected data types tried?

## 🚨 Common Vulnerability Checklist

### OWASP Top 10 (2021)
- [ ] **A01: Broken Access Control**
- [ ] **A02: Cryptographic Failures**
- [ ] **A03: Injection**
- [ ] **A04: Insecure Design**
- [ ] **A05: Security Misconfiguration**
- [ ] **A06: Vulnerable Components**
- [ ] **A07: Authentication Failures**
- [ ] **A08: Data Integrity Failures**
- [ ] **A09: Logging & Monitoring Failures**
- [ ] **A10: Server-Side Request Forgery**

## 📋 Threat Modeling

- [ ] **Threat model updated**
  - New attack surface identified?
  - Threat scenarios documented?
  - Mitigations in place?
  - Residual risks accepted?

- [ ] **Attack vectors considered**
  - How could attacker abuse this?
  - What's the impact?
  - What's the likelihood?
  - Is mitigation sufficient?

## 🔒 Specific Feature Types

### File Upload
- [ ] File type validated (not just extension)?
- [ ] File size limited?
- [ ] Virus scanning implemented?
- [ ] Uploaded files not executed?
- [ ] Files stored outside web root?
- [ ] Filename sanitized?

### Email
- [ ] Email injection prevented?
- [ ] Rate limiting on email sending?
- [ ] SPF/DKIM configured?
- [ ] Email content sanitized?

### OAuth/SSO
- [ ] State parameter validated?
- [ ] Redirect URI validated?
- [ ] Authorization code used once?
- [ ] Token endpoint authenticated?

### Webhooks
- [ ] Webhook signatures verified?
- [ ] Replay attacks prevented?
- [ ] Rate limiting applied?
- [ ] Timeout configured?

## 📊 Security Metrics

- [ ] **Security metrics tracked**
  - Failed authentication attempts?
  - Authorization failures?
  - Vulnerability count?
  - Time to patch?

## 🎓 Security Training

- [ ] **Team awareness**
  - Team knows common vulnerabilities?
  - Secure coding practices followed?
  - Security champions identified?

## ✅ Final Security Sign-off

- [ ] **Security review complete**
  - All high/critical issues resolved?
  - Medium issues documented or mitigated?
  - Low issues tracked for future work?

- [ ] **Compliance verified**
  - GDPR compliance (if EU users)?
  - CCPA compliance (if CA users)?
  - HIPAA compliance (if health data)?
  - Industry-specific requirements met?

- [ ] **Documentation updated**
  - Threat model current?
  - Security controls documented?
  - Incident response plan updated?

---

## 🚨 Red Flags - Stop Deployment If:

- Authentication can be bypassed
- Users can access others' data
- Secrets exposed in code or logs
- SQL injection possible
- XSS vulnerabilities present
- Critical dependencies have known CVEs
- No rate limiting on sensitive endpoints
- HTTPS not enforced

## 💡 Security Mindset

**Think like an attacker:**
- What would I try if I wanted to break this?
- What's the worst that could happen?
- Who would want to attack this and why?
- What data is most valuable to protect?

**Defense in depth:**
- Never rely on a single security control
- Assume outer layers will fail
- Multiple layers of protection

## 📚 Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheets](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

## Next Steps

After security review:
1. Document findings
2. Fix critical issues immediately
3. Plan remediation for others
4. Update threat model
5. Proceed with deployment (if approved)
