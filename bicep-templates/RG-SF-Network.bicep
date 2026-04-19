param routeTables_RT_SF_App_name string = 'RT-SF-App'
param routeTables_RT_SF_Web_name string = 'RT-SF-Web'
param routeTables_RT_SF_Storage_name string = 'RT-SF-Storage'
param networkSecurityGroups_NSG_SF_App_name string = 'NSG-SF-App'
param networkSecurityGroups_NSG_SF_Web_name string = 'NSG-SF-Web'
param virtualNetworks_VNET_SF_ShopFast_name string = 'VNET-SF-ShopFast'
param networkSecurityGroups_NSG_SF_Storage_name string = 'NSG-SF-Storage'
param virtualNetworks_VNET_KhanCloud_Hub_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-KhanCloud-Hub/providers/Microsoft.Network/virtualNetworks/VNET-KhanCloud-Hub'

resource networkSecurityGroups_NSG_SF_App_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_SF_App_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-Web-Inbound'
        id: networkSecurityGroups_NSG_SF_App_name_Allow_Web_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '10.2.1.0/24'
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
        name: 'Allow-Management-SSH'
        id: networkSecurityGroups_NSG_SF_App_name_Allow_Management_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.4.0/24'
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
        id: networkSecurityGroups_NSG_SF_App_name_Deny_All_Inbound.id
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

resource networkSecurityGroups_NSG_SF_Storage_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_SF_Storage_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-App-Inbound'
        id: networkSecurityGroups_NSG_SF_Storage_name_Allow_App_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '10.2.2.0/24'
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
        name: 'Deny-All-Inbound'
        id: networkSecurityGroups_NSG_SF_Storage_name_Deny_All_Inbound.id
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

resource networkSecurityGroups_NSG_SF_Web_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_SF_Web_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-HTTP-Inbound'
        id: networkSecurityGroups_NSG_SF_Web_name_Allow_HTTP_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
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
        name: 'Allow-HTTPS-Inbound'
        id: networkSecurityGroups_NSG_SF_Web_name_Allow_HTTPS_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
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
        name: 'Allow-Management-SSH'
        id: networkSecurityGroups_NSG_SF_Web_name_Allow_Management_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.4.0/24'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Deny-All-Inbound'
        id: networkSecurityGroups_NSG_SF_Web_name_Deny_All_Inbound.id
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

resource routeTables_RT_SF_App_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_SF_App_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_SF_App_name_Force_To_Firewall.id
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

resource routeTables_RT_SF_Storage_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_SF_Storage_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_SF_Storage_name_Force_To_Firewall.id
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

resource routeTables_RT_SF_Web_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_SF_Web_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_SF_Web_name_Force_To_Firewall.id
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

resource networkSecurityGroups_NSG_SF_Storage_name_Allow_App_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Storage_name}/Allow-App-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '10.2.2.0/24'
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
    networkSecurityGroups_NSG_SF_Storage_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_Web_name_Allow_HTTP_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Web_name}/Allow-HTTP-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
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
    networkSecurityGroups_NSG_SF_Web_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_Web_name_Allow_HTTPS_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Web_name}/Allow-HTTPS-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
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
    networkSecurityGroups_NSG_SF_Web_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_App_name_Allow_Management_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_App_name}/Allow-Management-SSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.4.0/24'
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
    networkSecurityGroups_NSG_SF_App_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_Web_name_Allow_Management_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Web_name}/Allow-Management-SSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.4.0/24'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_NSG_SF_Web_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_App_name_Allow_Web_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_App_name}/Allow-Web-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '10.2.1.0/24'
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
    networkSecurityGroups_NSG_SF_App_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_App_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_App_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_SF_App_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_Storage_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Storage_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_SF_Storage_name_resource
  ]
}

resource networkSecurityGroups_NSG_SF_Web_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_SF_Web_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_SF_Web_name_resource
  ]
}

resource routeTables_RT_SF_App_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_SF_App_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_SF_App_name_resource
  ]
}

resource routeTables_RT_SF_Storage_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_SF_Storage_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_SF_Storage_name_resource
  ]
}

resource routeTables_RT_SF_Web_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_SF_Web_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_SF_Web_name_resource
  ]
}

resource virtualNetworks_VNET_SF_ShopFast_name_SF_to_Hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_VNET_SF_ShopFast_name}/SF-to-Hub'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_VNET_KhanCloud_Hub_externalid
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
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_VNET_SF_ShopFast_name_resource
  ]
}

resource virtualNetworks_VNET_SF_ShopFast_name_AppSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_SF_ShopFast_name}/AppSubnet'
  properties: {
    addressPrefixes: [
      '10.2.2.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_SF_App_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_SF_App_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_SF_ShopFast_name_resource
  ]
}

resource virtualNetworks_VNET_SF_ShopFast_name_StorageSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_SF_ShopFast_name}/StorageSubnet'
  properties: {
    addressPrefixes: [
      '10.2.3.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_SF_Storage_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_SF_Storage_name_resource.id
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
        locations: [
          'westeurope'
          'northeurope'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_SF_ShopFast_name_resource
  ]
}

resource virtualNetworks_VNET_SF_ShopFast_name_WebSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_SF_ShopFast_name}/WebSubnet'
  properties: {
    addressPrefixes: [
      '10.2.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_SF_Web_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_SF_Web_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_SF_ShopFast_name_resource
  ]
}

resource virtualNetworks_VNET_SF_ShopFast_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_VNET_SF_ShopFast_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'WebSubnet'
        id: virtualNetworks_VNET_SF_ShopFast_name_WebSubnet.id
        properties: {
          addressPrefixes: [
            '10.2.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_SF_Web_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_SF_Web_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AppSubnet'
        id: virtualNetworks_VNET_SF_ShopFast_name_AppSubnet.id
        properties: {
          addressPrefixes: [
            '10.2.2.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_SF_App_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_SF_App_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'StorageSubnet'
        id: virtualNetworks_VNET_SF_ShopFast_name_StorageSubnet.id
        properties: {
          addressPrefixes: [
            '10.2.3.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_SF_Storage_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_SF_Storage_name_resource.id
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'westeurope'
                'northeurope'
              ]
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'SF-to-Hub'
        id: virtualNetworks_VNET_SF_ShopFast_name_SF_to_Hub.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_VNET_KhanCloud_Hub_externalid
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
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}
