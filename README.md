# KhanCloud Solutions — Azure MSP Infrastructure

**A production-grade Azure Managed Service Provider infrastructure managing three fully isolated client environments from a single subscription — built on hub-spoke architecture with centralised security, zero trust networking, and enterprise grade identity management.**

---

## Project Overview

Managing multiple clients on a shared Azure infrastructure introduces a fundamental challenge — how do you provide each client with complete isolation, dedicated security controls, and least privilege access while maintaining centralised management and cost efficiency?

This project solves that problem by implementing a hub-spoke network topology where KhanCloud operates as the MSP managing three clients with completely different security and compliance requirements — a FinTech company, an e-commerce platform, and a healthcare provider — each with tailored infrastructure within the same subscription.

---

## Architecture

**Company Structure:**

KhanCloud Solutions manages three clients from a single Azure subscription:

- **SecureBank** — FinTech company requiring strict security, private endpoints, customer managed encryption keys, and zero public access
- **ShopFast** — E-commerce company requiring high availability, public blob access for product images, and service endpoint connectivity
- **MedSol** — Healthcare company requiring GDPR compliance, data protection, private endpoints, and 90-day soft delete retention

**Design Principles:**

- Hub-spoke network topology for centralised security and complete client isolation
- Zero trust model — no implicit trust between clients or between clients and hub
- Least privilege access — every user and group has minimum required permissions
- Defence in depth — multiple security layers at every level

**Network topology:**
```
Internet
    ↓
Azure Firewall (Hub VNET 10.0.0.0/16)
    ↓
VNET Peering (Hub to all Spokes — Spokes cannot reach each other)
    ↓
SecureBank Spoke    ShopFast Spoke    MedSol Spoke
(10.1.0.0/16)       (10.2.0.0/16)     (10.3.0.0/16)
```

---

## Infrastructure Components

**Networking:**
- 1 Hub VNET (10.0.0.0/16) — KhanCloud central network
- 3 Spoke VNETs — one per client
- VNET Peering — hub connected to all spokes, spoke-to-spoke traffic explicitly blocked
- Azure Firewall — centralised traffic inspection with network and application rule collections
- Azure Bastion — secure VM access without public IPs
- 10 NSGs — one per subnet with least privilege inbound and outbound rules
- 10 Route Tables — forcing all traffic through Azure Firewall
- 3 Private DNS Zones — for storage, Key Vault, and backup private endpoints

**Security:**
- Azure Firewall with deny spoke-to-spoke, allow management, and allow internet rule collections
- Network Security Groups on every subnet
- Private Endpoints for SecureBank and MedSol storage and Key Vault
- Service Endpoints for ShopFast storage
- Customer Managed Keys for SecureBank and MedSol disk encryption
- Azure Key Vault with RBAC authorisation and purge protection enabled
- Azure Policy enforcing security standards across all resources

**Identity and Access:**
- 20 Entra ID users across KhanCloud and all 3 clients
- 18 Security Groups organised by client and role
- RBAC assignments scoped to specific resource groups per group
- Managed Identities for storage account encryption key access

**Compute:**
- 5 Virtual Machines — Ubuntu Server 24.04 LTS
- 3 Availability Sets for high availability
- Azure Bastion connectivity verified end to end

**Storage:**
- 3 Storage Accounts — one per client with different security configurations
  - SecureBank — private endpoint, customer managed keys, no public access
  - ShopFast — service endpoint, public blob access for product images
  - MedSol — private endpoint, customer managed keys, 90-day soft delete
- Blob versioning, soft delete, and lifecycle policies configured per client requirements

**Monitoring and Backup:**
- Log Analytics Workspace — central monitoring for all clients
- 3 Recovery Services Vaults — one per client with dedicated backup policies

---

## Network Security Design

**Firewall Rules:**

| Collection | Priority | Action | Purpose |
|---|---|---|---|
| NRC-Deny-Spoke-to-Spoke | 50 | Deny | Block all inter-client traffic |
| NRC-Allow-Management-to-Spokes | 150 | Allow | Admin SSH access to client VMs |
| NRC-Allow-Internet | 200 | Allow | Internet access on ports 80/443 |

**Client Isolation:**

All spoke-to-spoke traffic is explicitly denied at the firewall level. SecureBank cannot reach ShopFast or MedSol and vice versa — verified through live connectivity testing.

**Connectivity testing result:**

Laptop → Bastion → VM-KhanCloud-Mgmt-01 (10.0.4.4) → VM-SB-App-01 (10.1.1.4) ✅

---

## RBAC Design

| Group | Role | Scope |
|---|---|---|
| SG-KhanCloud-Admin | Owner | Subscription |
| SG-KhanCloud-HelpDesk | Reader | Subscription |
| SG-SB-Admin | Contributor | All SecureBank RGs |
| SG-SB-Development | Contributor | RG-SB-Compute only |
| SG-SB-DBAdmin | Contributor | RG-SB-Storage only |
| SG-SB-Audit | Reader | All SecureBank RGs |
| SG-SF-StorageAdmin | Storage Blob Data Contributor | RG-SF-Storage only |
| SG-SF-Operations | Virtual Machine Contributor | RG-SF-Compute only |
| SG-MS-DPO | Backup Contributor | RG-MS-DataProtection only |

---

## Project Focus

**My role on this project was Cloud Architect and Infrastructure Engineer.**

- Designed the complete hub-spoke network topology and client isolation model
- Provisioned all Azure resources using Azure CLI and Bicep IaC templates
- Designed and implemented the RBAC model across 20 users and 18 security groups
- Configured Azure Firewall rule collections enforcing zero trust between clients
- Implemented private endpoints with private DNS zones for SecureBank and MedSol
- Configured customer managed keys using Key Vault and managed identities for storage encryption
- Verified end-to-end connectivity and client isolation through live testing
- Documented all architecture decisions and infrastructure components

---

## Visual Proof

Screenshots of all deployed resources, network topology, firewall rules, RBAC assignments, private endpoints, and connectivity testing are available in the `screenshots/` folder.

---

## Technologies Used

- Microsoft Azure
- Azure CLI
- Bicep — Infrastructure as Code
- Ubuntu Server 24.04 LTS
- Microsoft Entra ID
- Git and GitHub

---

## Skills Demonstrated

**Network Architecture**
- Hub-spoke topology design and implementation
- VNET peering with asymmetric routing control
- Azure Firewall rule collections — network, application, and DNAT
- NSG design with least privilege inbound and outbound rules
- Private endpoints with private DNS zone integration
- Service endpoints for cost-optimised connectivity

**Security Engineering**
- Zero trust network design across multiple client environments
- Customer managed encryption keys with Key Vault and managed identities
- Defence in depth — firewall, NSG, private endpoints, encryption at rest
- Azure Policy for subscription-wide governance enforcement
- Purge protection and soft delete for data recovery compliance

**Identity and Governance**
- Entra ID user and group management at scale
- RBAC scoping at subscription, resource group, and resource level
- Least privilege principle applied across all role assignments
- Managed identity configuration for service-to-service authentication

**Infrastructure as Code**
- Bicep templates for repeatable resource deployment
- Parameterised templates supporting multiple client environments
- Azure CLI scripting for automation and configuration

---

## Business Problem Solved

Managed Service Providers face a constant tension between operational efficiency and client security. Managing each client in a separate Azure subscription is expensive and operationally complex. Managing them together in a single subscription without proper isolation creates unacceptable security risk — particularly when clients operate in regulated industries like finance and healthcare.

This infrastructure solves that problem directly. Three clients with completely different security and compliance requirements — FinTech, e-commerce, and healthcare — share a single subscription with complete network isolation, dedicated encryption keys, tailored storage security configurations, and granular RBAC that ensures each client's team can only access their own resources.

The result is an MSP infrastructure that scales efficiently while meeting the strictest security and compliance requirements of each individual client.
