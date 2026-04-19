param vaults_KV_MS_MedSol_name string = 'KV-MS-MedSol'
param privateEndpoints_PE_KV_MedSol_name string = 'PE-KV-MedSol'
param userAssignedIdentities_MI_MS_Storage_name string = 'MI-MS-Storage'
param virtualNetworks_VNET_MS_MedSol_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-MS-Network/providers/Microsoft.Network/virtualNetworks/VNET-MS-MedSol'

resource vaults_KV_MS_MedSol_name_resource 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: vaults_KV_MS_MedSol_name
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
    vaultUri: 'https://kv-ms-medsol.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_MI_MS_Storage_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: userAssignedIdentities_MI_MS_Storage_name
  location: 'westeurope'
}

resource vaults_KV_MS_MedSol_name_Key_MS_DiskEncryption 'Microsoft.KeyVault/vaults/keys@2025-05-01' = {
  parent: vaults_KV_MS_MedSol_name_resource
  name: 'Key-MS-DiskEncryption'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_KV_MS_MedSol_name_conn_kv_medsol 'Microsoft.KeyVault/vaults/privateEndpointConnections@2025-05-01' = {
  parent: vaults_KV_MS_MedSol_name_resource
  name: 'conn-kv-medsol'
  location: 'westeurope'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      actionsRequired: 'None'
    }
  }
}

resource privateEndpoints_PE_KV_MedSol_name_resource 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpoints_PE_KV_MedSol_name
  location: 'westeurope'
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'conn-kv-medsol'
        id: '${privateEndpoints_PE_KV_MedSol_name_resource.id}/privateLinkServiceConnections/conn-kv-medsol'
        properties: {
          privateLinkServiceId: vaults_KV_MS_MedSol_name_resource.id
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
      id: '${virtualNetworks_VNET_MS_MedSol_externalid}/subnets/PrivateEndpointSubnet'
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'kv-ms-medsol.vault.azure.net'
        ipAddresses: [
          '10.3.3.4'
        ]
      }
    ]
    ipVersionType: 'IPv4'
  }
}
