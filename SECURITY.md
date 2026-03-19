# Security Policy

## ⚠️ Educational & Learning Purpose ONLY

**DO NOT USE THIS PROJECT OR ITS CONFIGURATIONS IN A PRODUCTION ENVIRONMENT.**

This `ansible-lab` project is designed strictly as a local, multi-tier infrastructure simulation for learning Configuration Management (Ansible), Container Orchestration (Docker Compose), and basic Linux administration.

### Known Insecure Practices Used in This Lab

To minimize the learning curve and focus purely on mastering DevOps tools, deliberately insecure configurations are employed in this project. These include:

1. **Hardcoded Passwords:** Pre-configured root passwords (e.g., `root:ansible-lab`) are baked directly into the `Dockerfile`s.
2. **Root User Operations:** All automation, container execution, and SSH access occur as the `root` user for simplicity, which violates the Principle of Least Privilege.
3. **SSH Vulnerabilities:** Password-based SSH authentication (`PasswordAuthentication yes`) is enabled alongside `PermitRootLogin yes` in the target nodes.
4. **Relaxed Host Key Checking:** SSH strict host key checking is often disabled in labs to allow automation to run seamlessly on the first connection without manual prompts.
5. **No Network Encryption:** Services communicate over unencrypted HTTP (Port 80) rather than HTTPS.

### Production Recommendations

If you intend to implement these infrastructure concepts in a real-world, production-facing environment, you **MUST** adopt industry security best practices:

- Disable `PermitRootLogin` and enforce SSH key-based authentication exclusively.
- **Never** commit secrets, passwords, or private keys to source control. Use secret management tools like HashiCorp Vault, AWS Secrets Manager, or Ansible Vault.
- Adhere to the Principle of Least Privilege by creating dedicated, non-root service accounts for running applications.
- Use TLS/SSL (HTTPS) for all internal and external network communication.
- Implement strict network firewalls (e.g., UFW, Security Groups) to restrict inter-service communication.

## Reporting a Vulnerability

As this is a deliberately insecure educational sandbox, please **do not** report vulnerabilities related to the intentionally relaxed security configurations mentioned above. 

If you find an issue that prevents the lab from functioning as intended, please open a standard Issue on the repository.
