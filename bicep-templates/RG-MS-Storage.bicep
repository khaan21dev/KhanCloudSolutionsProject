param storageAccounts_stamedsol_name string = 'stamedsol'
param privateEndpoints_PE_Storage_MedSol_name string = 'PE-Storage-MedSol'
param virtualNetworks_VNET_MS_MedSol_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-MS-Network/providers/Microsoft.Network/virtualNetworks/VNET-MS-MedSol'
param userAssignedIdentities_MI_MS_Storage_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-MS-DataProtection/providers/Microsoft.ManagedIdentity/userAssignedIdentities/MI-MS-Storage'

resource storageAccounts_stamedsol_name_resource 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: storageAccounts_stamedsol_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourcegroups/RG-MS-DataProtection/providers/Microsoft.ManagedIdentity/userAssignedIdentities/MI-MS-Storage': {
        tenantId: '89274b0e-092f-4a8c-9112-c15a8d44ad7b'
      }
    }
  }
  properties: {
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    networkAcls: {
      ipv6Rules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentities_MI_MS_Storage_externalid
      }
      keyvaultproperties: {
        keyvaulturi: 'https://kv-ms-medsol.vault.azure.net'
        keyname: 'Key-MS-DiskEncryption'
      }
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Keyvault'
    }
    accessTier: 'Hot'
  }
}

resource privateEndpoints_PE_Storage_MedSol_name_resource 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpoints_PE_Storage_MedSol_name
  location: 'westeurope'
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'conn-storage-medsol'
        id: '${privateEndpoints_PE_Storage_MedSol_name_resource.id}/privateLinkServiceConnections/conn-storage-medsol'
        properties: {
          privateLinkServiceId: storageAccounts_stamedsol_name_resource.id
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
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
        fqdn: 'stamedsol.blob.core.windows.net'
        ipAddresses: [
          '10.3.3.5'
        ]
      }
    ]
    ipVersionType: 'IPv4'
  }
}

resource storageAccounts_stamedsol_name_default 'Microsoft.Storage/storageAccounts/blobServices@2025-06-01' = {
  parent: storageAccounts_stamedsol_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: true
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 90
    }
    isVersioningEnabled: true
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stamedsol_name_default 'Microsoft.Storage/storageAccounts/fileServices@2025-06-01' = {
  parent: storageAccounts_stamedsol_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_stamedsol_name_storageAccounts_stamedsol_name_ce36f274_597c_4f83_929b_4fe7132f27e7 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-06-01' = {
  parent: storageAccounts_stamedsol_name_resource
  name: '${storageAccounts_stamedsol_name}.ce36f274-597c-4f83-929b-4fe7132f27e7'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stamedsol_name_default 'Microsoft.Storage/storageAccounts/queueServices@2025-06-01' = {
  parent: storageAccounts_stamedsol_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stamedsol_name_default 'Microsoft.Storage/storageAccounts/tableServices@2025-06-01' = {
  parent: storageAccounts_stamedsol_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}
