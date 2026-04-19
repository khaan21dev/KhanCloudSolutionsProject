param storageAccounts_stashopfast_name string = 'stashopfast'
param virtualNetworks_VNET_SF_ShopFast_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-SF-Network/providers/Microsoft.Network/virtualNetworks/VNET-SF-ShopFast'

resource storageAccounts_stashopfast_name_resource 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: storageAccounts_stashopfast_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      ipv6Rules: []
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: '${virtualNetworks_VNET_SF_ShopFast_externalid}/subnets/StorageSubnet'
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
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
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_stashopfast_name_default 'Microsoft.Storage/storageAccounts/blobServices@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_resource
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
      days: 7
    }
    isVersioningEnabled: true
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stashopfast_name_default 'Microsoft.Storage/storageAccounts/fileServices@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_resource
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

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stashopfast_name_default 'Microsoft.Storage/storageAccounts/queueServices@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stashopfast_name_default 'Microsoft.Storage/storageAccounts/tableServices@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_stashopfast_name_default_order_files 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_default
  name: 'order-files'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stashopfast_name_resource
  ]
}

resource storageAccounts_stashopfast_name_default_product_images 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_default
  name: 'product-images'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Blob'
  }
  dependsOn: [
    storageAccounts_stashopfast_name_resource
  ]
}

resource storageAccounts_stashopfast_name_default_static_assets 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-06-01' = {
  parent: storageAccounts_stashopfast_name_default
  name: 'static-assets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Blob'
  }
  dependsOn: [
    storageAccounts_stashopfast_name_resource
  ]
}
