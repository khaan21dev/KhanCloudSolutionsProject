# KhanCloud Solutions — Azure MSP Infrastructure

## Overview
KhanCloud Solutions is a fictional Managed Service Provider (MSP) based in Wrocław, Poland. This project demonstrates a production-grade Azure infrastructure managing three client environments from a single Azure subscription using hub and spoke network architecture.

This project was built as part of my AZ-104 Microsoft Azure Administrator certification preparation.

---

## Architecture

### Company Structure
KhanCloud manages three clients:
- **SecureBank** — FinTech company requiring strict security and compliance
- **ShopFast** — E-commerce company requiring high availability and scaling
- **MedSol** — Healthcare company requiring data protection and GDPR compliance

### Design Principles
- Hub and spoke network topology for centralized security and client isolation
- Zero trust security model — no implicit trust between clients
- Least privilege access — every user and group has minimum required permissions
- Defence in depth — multiple security layers (Firewall, NSG, Private Endpoints)

---

## Infrastructure Components

### Networking
- **1 Hub VNET** (10.0.0.0/16) — KhanCloud central network
- **3 Spoke VNETs** — one per client (10.1.0.0/16, 10.2.0.0/16, 10.3.0.0/16)
- **VNET Peering** — hub connected to all spokes, spokes cannot communicate directly
- **Azure Firewall** — centralized traffic inspection and control
- **Azure Bastion** — secure VM access without public IPs
- **10 NSGs** — one per subnet with least privilege rules
- **10 Route Tables** — forcing all traffic through Azure Firewall
- **3 Private DNS Zones** — for storage, Key Vault, and backup private endpoints

### Security
- **Azure Firewall** with network and application rule collections
- **Network Security Groups** on every subnet
- **Private Endpoints** for SecureBank and MedSol storage and Key Vault
- **Service Endpoints** for ShopFast storage
- **Customer Managed Keys** for SecureBank and MedSol disk encryption
- **Azure Key Vault** with RBAC authorization and purge protection
- **Azure Policy** enforcing security standards across all resources

### Identity & Access
- **20 Entra ID users** across KhanCloud and all 3 clients
- **18 Security Groups** organized by client and role
- **RBAC assignments** scoped to specific resource groups per group
- **Managed Identities** for storage account encryption

### Compute
- **5 Virtual Machines** — Ubuntu Server 24.04 LTS
- **3 Availability Sets** — for high availability
- **Azure Bastion** connectivity verified end to end

### Storage
- **3 Storage Accounts** — one per client with different security configurations
  - SecureBank — private endpoint, customer managed keys, no public access
  - ShopFast — service endpoint, public blob access for product images
  - MedSol — private endpoint, customer managed keys, 90 day soft delete
- Blob versioning, soft delete, and lifecycle policies configured

### Monitoring & Backup
- **Log Analytics Workspace** — central monitoring for all clients
- **3 Recovery Services Vaults** — one per client for VM backup

---

## Network Security Design

### Firewall Rules
| Collection | Priority | Action | Purpose |
|---|---|---|---|
| NRC-Deny-Spoke-to-Spoke | 50 | Deny | Block all inter-client traffic |
| NRC-Allow-Management-to-Spokes | 150 | Allow | Admin SSH access to client VMs |
| NRC-Allow-Internet | 200 | Allow | Internet access on ports 80/443 |

### Client Isolation
All spoke-to-spoke traffic is explicitly denied at the firewall level. SecureBank cannot reach ShopFast or MedSol and vice versa — proven through connectivity testing.

### Connectivity Testing
Successfully tested the full chain:
**Laptop → Bastion → VM-KhanCloud-Mgmt-01 (10.0.4.4) → VM-SB-App-01 (10.1.1.4)**

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

## Technologies Used
- Microsoft Azure
- Azure CLI
- Bicep (Infrastructure as Code)
- Ubuntu Server 24.04 LTS
- Azure Entra ID
- Git / GitHub

---

## Author
Built by Elkhan as part of AZ-104 Microsoft Azure Administrator certification preparation.
