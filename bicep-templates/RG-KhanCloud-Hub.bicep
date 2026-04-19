param routeTables_RT_Hub_Management_name string = 'RT-Hub-Management'
param bastionHosts_BAS_KhanCloud_Hub_name string = 'BAS-KhanCloud-Hub'
param azureFirewalls_FW_KhanCloud_Hub_name string = 'FW-KhanCloud-Hub'
param publicIPAddresses_PIP_FW_KhanCloud_name string = 'PIP-FW-KhanCloud'
param virtualNetworks_VNET_KhanCloud_Hub_name string = 'VNET-KhanCloud-Hub'
param publicIPAddresses_PIP_BAS_KhanCloud_name string = 'PIP-BAS-KhanCloud'
param networkSecurityGroups_NSG_Hub_Management_name string = 'NSG-Hub-Management'
param privateDnsZones_privatelink_vaultcore_azure_net_name string = 'privatelink.vaultcore.azure.net'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'
param privateDnsZones_privatelink_backup_windowsazure_com_name string = 'privatelink.backup.windowsazure.com'
param virtualNetworks_VNET_MS_MedSol_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-MS-Network/providers/Microsoft.Network/virtualNetworks/VNET-MS-MedSol'
param virtualNetworks_VNET_SB_SecureBank_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-SB-Network/providers/Microsoft.Network/virtualNetworks/VNET-SB-SecureBank'
param virtualNetworks_VNET_SF_ShopFast_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-SF-Network/providers/Microsoft.Network/virtualNetworks/VNET-SF-ShopFast'

resource networkSecurityGroups_NSG_Hub_Management_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_Hub_Management_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-Bastion-SSH'
        id: networkSecurityGroups_NSG_Hub_Management_name_Allow_Bastion_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.2.0/26'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-Bastion-RDP'
        id: networkSecurityGroups_NSG_Hub_Management_name_Allow_Bastion_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '10.0.2.0/26'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Deny-All-Inbound'
        id: networkSecurityGroups_NSG_Hub_Management_name_Deny_All_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4000
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource privateDnsZones_privatelink_backup_windowsazure_com_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_backup_windowsazure_com_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_vaultcore_azure_net_name
  location: 'global'
  properties: {}
}

resource publicIPAddresses_PIP_BAS_KhanCloud_name_resource 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIPAddresses_PIP_BAS_KhanCloud_name
  location: 'westeurope'
  tags: {
    Environment: 'Production'
    Owner: 'KhanCloud Solutions'
    Client: 'KhanCloud Solutions'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    ipAddress: '132.220.62.92'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_PIP_FW_KhanCloud_name_resource 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIPAddresses_PIP_FW_KhanCloud_name
  location: 'westeurope'
  tags: {
    Environment: 'Production'
    Owner: 'KhanCloud Solutions'
    Client: 'KhanCloud Solutions'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '52.157.138.50'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource routeTables_RT_Hub_Management_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_Hub_Management_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_Hub_Management_name_Force_To_Firewall.id
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.1.4'
        }
        type: 'Microsoft.Network/routeTables/routes'
      }
    ]
  }
}

resource networkSecurityGroups_NSG_Hub_Management_name_Allow_Bastion_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_Hub_Management_name}/Allow-Bastion-RDP'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '10.0.2.0/26'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_NSG_Hub_Management_name_resource
  ]
}

resource networkSecurityGroups_NSG_Hub_Management_name_Allow_Bastion_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_Hub_Management_name}/Allow-Bastion-SSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.2.0/26'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_NSG_Hub_Management_name_resource
  ]
}

resource networkSecurityGroups_NSG_Hub_Management_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_Hub_Management_name}/Deny-All-Inbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Deny'
    priority: 4000
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_NSG_Hub_Management_name_resource
  ]
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_stasecurebank 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'stasecurebank'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.1.3.5'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_backup_windowsazure_com_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_backup_windowsazure_com_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_vaultcore_azure_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource privateDnsZones_privatelink_backup_windowsazure_com_name_link_backup_ms 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_backup_windowsazure_com_name_resource
  name: 'link-backup-ms'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_MS_MedSol_externalid
    }
  }
}

resource privateDnsZones_privatelink_backup_windowsazure_com_name_link_backup_sb 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_backup_windowsazure_com_name_resource
  name: 'link-backup-sb'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SB_SecureBank_externalid
    }
  }
}

resource privateDnsZones_privatelink_backup_windowsazure_com_name_link_backup_sf 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_backup_windowsazure_com_name_resource
  name: 'link-backup-sf'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SF_ShopFast_externalid
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_link_blob_ms 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'link-blob-ms'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_MS_MedSol_externalid
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_link_blob_sb 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'link-blob-sb'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SB_SecureBank_externalid
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_link_blob_sf 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'link-blob-sf'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SF_ShopFast_externalid
    }
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_link_kv_ms 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: 'link-kv-ms'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_MS_MedSol_externalid
    }
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_link_kv_sb 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: 'link-kv-sb'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SB_SecureBank_externalid
    }
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_link_kv_sf 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: 'link-kv-sf'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_SF_ShopFast_externalid
    }
  }
}

resource routeTables_RT_Hub_Management_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_Hub_Management_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_Hub_Management_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/AzureBastionSubnet'
  properties: {
    addressPrefixes: [
      '10.0.2.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_AzureFirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/AzureFirewallSubnet'
  properties: {
    addressPrefixes: [
      '10.0.1.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/GatewaySubnet'
  properties: {
    addressPrefixes: [
      '10.0.3.0/27'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_MS 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/Hub-to-MS'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_VNET_MS_MedSol_externalid
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_SB 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/Hub-to-SB'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_VNET_SB_SecureBank_externalid
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_SF 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/Hub-to-SF'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_VNET_SF_ShopFast_externalid
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}

resource azureFirewalls_FW_KhanCloud_Hub_name_resource 'Microsoft.Network/azureFirewalls@2025-05-01' = {
  name: azureFirewalls_FW_KhanCloud_Hub_name
  location: 'westeurope'
  tags: {
    Environment: 'Production'
    Owner: 'KhanCloud Solutions'
    Client: 'KhanCloud Solutions'
  }
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
    additionalProperties: {}
    ipConfigurations: [
      {
        name: 'PIP-FW-KhanCloud'
        id: '${azureFirewalls_FW_KhanCloud_Hub_name_resource.id}/azureFirewallIpConfigurations/PIP-FW-KhanCloud'
        properties: {
          publicIPAddress: {
            id: publicIPAddresses_PIP_FW_KhanCloud_name_resource.id
          }
          subnet: {
            id: virtualNetworks_VNET_KhanCloud_Hub_name_AzureFirewallSubnet.id
          }
        }
      }
    ]
    networkRuleCollections: [
      {
        name: 'NRC-Allow-Internet'
        id: '${azureFirewalls_FW_KhanCloud_Hub_name_resource.id}/networkRuleCollections/NRC-Allow-Internet'
        properties: {
          priority: 200
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'Allow-SB-Internet'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.1.0.0/16'
              ]
              destinationAddresses: [
                '*'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '80'
                '443'
              ]
            }
            {
              name: 'Allow-SF-Internet'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.2.0.0/16'
              ]
              destinationAddresses: [
                '*'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '80'
                '443'
              ]
            }
            {
              name: 'Allow-MS-Internet'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.3.0.0/16'
              ]
              destinationAddresses: [
                '*'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '80'
                '443'
              ]
            }
            {
              name: 'Allow-Hub-Internet'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.0.0.0/16'
              ]
              destinationAddresses: [
                '*'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '80'
                '443'
              ]
            }
          ]
        }
      }
      {
        name: 'NRC-Deny-Spoke-to-Spoke'
        id: '${azureFirewalls_FW_KhanCloud_Hub_name_resource.id}/networkRuleCollections/NRC-Deny-Spoke-to-Spoke'
        properties: {
          priority: 100
          action: {
            type: 'Deny'
          }
          rules: [
            {
              name: 'Deny-SB-to-SF-MS'
              protocols: [
                'Any'
              ]
              sourceAddresses: [
                '10.1.0.0/16'
              ]
              destinationAddresses: [
                '10.2.0.0/16'
                '10.3.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '*'
              ]
            }
            {
              name: 'Deny-SF-to-SB-MS'
              protocols: [
                'Any'
              ]
              sourceAddresses: [
                '10.2.0.0/16'
              ]
              destinationAddresses: [
                '10.1.0.0/16'
                '10.3.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '*'
              ]
            }
            {
              name: ' Deny-MS-to-SB-SF'
              protocols: [
                'Any'
              ]
              sourceAddresses: [
                '10.3.0.0/16'
              ]
              destinationAddresses: [
                '10.1.0.0/16'
                '10.2.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '*'
              ]
            }
          ]
        }
      }
      {
        name: 'NRC-Allow-Management-to-Spokes'
        id: '${azureFirewalls_FW_KhanCloud_Hub_name_resource.id}/networkRuleCollections/NRC-Allow-Management-to-Spokes'
        properties: {
          priority: 150
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'Allow-Mgmt-to-SB'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.0.4.0/24'
              ]
              destinationAddresses: [
                '10.1.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '22'
              ]
            }
            {
              name: 'Allow-Mgmt-to-SF'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.0.4.0/24'
              ]
              destinationAddresses: [
                '10.2.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '22'
              ]
            }
            {
              name: 'Allow-Mgmt-to-MS'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                '10.0.4.0/24'
              ]
              destinationAddresses: [
                '10.3.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '22'
              ]
            }
          ]
        }
      }
    ]
    applicationRuleCollections: []
    natRuleCollections: []
  }
}

resource bastionHosts_BAS_KhanCloud_Hub_name_resource 'Microsoft.Network/bastionHosts@2025-05-01' = {
  name: bastionHosts_BAS_KhanCloud_Hub_name
  location: 'westeurope'
  tags: {
    Environment: 'Production'
    Owner: 'KhanCloud Solutions'
    Client: 'KhanCloud Solutions'
  }
  sku: {
    name: 'Basic'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    dnsName: 'bst-9d915575-b213-4ccc-aa36-d55c66a74535.bastion.azure.com'
    scaleUnits: 2
    enableTunneling: false
    enableIpConnect: false
    disableCopyPaste: false
    enableShareableLink: false
    enableKerberos: false
    enableSessionRecording: false
    enablePrivateOnlyBastion: false
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionHosts_BAS_KhanCloud_Hub_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_PIP_BAS_KhanCloud_name_resource.id
          }
          subnet: {
            id: virtualNetworks_VNET_KhanCloud_Hub_name_AzureBastionSubnet.id
          }
        }
      }
    ]
  }
}

resource privateDnsZones_privatelink_backup_windowsazure_com_name_link_backup_hub 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_backup_windowsazure_com_name_resource
  name: 'link-backup-hub'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_KhanCloud_Hub_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_link_blob_hub 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'link-blob-hub'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_KhanCloud_Hub_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_link_kv_hub 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: 'link-kv-hub'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNET_KhanCloud_Hub_name_resource.id
    }
  }
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_VNET_KhanCloud_Hub_name
  location: 'westeurope'
  tags: {
    Environment: 'Production'
    Owner: 'KhanCloud Solutions'
    Client: 'KhanCloud Solutions'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_AzureFirewallSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'GatewaySubnet'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_GatewaySubnet.id
        properties: {
          addressPrefixes: [
            '10.0.3.0/27'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'ManagementSubnet'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_ManagementSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.4.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_Hub_Management_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_Hub_Management_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_AzureBastionSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'Hub-to-SB'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_SB.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_VNET_SB_SecureBank_externalid
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
      {
        name: 'Hub-to-SF'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_SF.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_VNET_SF_ShopFast_externalid
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
      {
        name: 'Hub-to-MS'
        id: virtualNetworks_VNET_KhanCloud_Hub_name_Hub_to_MS.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_VNET_MS_MedSol_externalid
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.3.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.3.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_VNET_KhanCloud_Hub_name_ManagementSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_KhanCloud_Hub_name}/ManagementSubnet'
  properties: {
    addressPrefixes: [
      '10.0.4.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_Hub_Management_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_Hub_Management_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_KhanCloud_Hub_name_resource
  ]
}
