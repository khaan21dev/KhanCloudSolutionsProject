param vaults_KV_SB_SecureBank_name string = 'KV-SB-SecureBank'
param privateEndpoints_PE_KV_SecureBank_name string = 'PE-KV-SecureBank'
param userAssignedIdentities_MI_SB_Storage_name string = 'MI-SB-Storage'
param virtualNetworks_VNET_SB_SecureBank_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-SB-Network/providers/Microsoft.Network/virtualNetworks/VNET-SB-SecureBank'

resource vaults_KV_SB_SecureBank_name_resource 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: vaults_KV_SB_SecureBank_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: '89274b0e-092f-4a8c-9112-c15a8d44ad7b'
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    enablePurgeProtection: true
    vaultUri: 'https://kv-sb-securebank.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_MI_SB_Storage_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: userAssignedIdentities_MI_SB_Storage_name
  location: 'westeurope'
}

resource vaults_KV_SB_SecureBank_name_Key_SB_DiskEncryption 'Microsoft.KeyVault/vaults/keys@2025-05-01' = {
  parent: vaults_KV_SB_SecureBank_name_resource
  name: 'Key-SB-DiskEncryption'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_KV_SB_SecureBank_name_conn_kv_securebank 'Microsoft.KeyVault/vaults/privateEndpointConnections@2025-05-01' = {
  parent: vaults_KV_SB_SecureBank_name_resource
  name: 'conn-kv-securebank'
  location: 'westeurope'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      actionsRequired: 'None'
    }
  }
}

resource privateEndpoints_PE_KV_SecureBank_name_resource 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpoints_PE_KV_SecureBank_name
  location: 'westeurope'
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'conn-kv-securebank'
        id: '${privateEndpoints_PE_KV_SecureBank_name_resource.id}/privateLinkServiceConnections/conn-kv-securebank'
        properties: {
          privateLinkServiceId: vaults_KV_SB_SecureBank_name_resource.id
          groupIds: [
            'vault'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: '${virtualNetworks_VNET_SB_SecureBank_externalid}/subnets/PrivateEndpointSubnet'
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'kv-sb-securebank.vault.azure.net'
        ipAddresses: [
          '10.1.3.4'
        ]
      }
    ]
    ipVersionType: 'IPv4'
  }
}
