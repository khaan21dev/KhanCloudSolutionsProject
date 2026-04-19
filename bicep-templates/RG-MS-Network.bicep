param routeTables_RT_MS_PE_name string = 'RT-MS-PE'
param routeTables_RT_MS_App_name string = 'RT-MS-App'
param routeTables_RT_MS_Data_name string = 'RT-MS-Data'
param virtualNetworks_VNET_MS_MedSol_name string = 'VNET-MS-MedSol'
param networkSecurityGroups_NSG_MS_PE_name string = 'NSG-MS-PE'
param networkSecurityGroups_NSG_MS_App_name string = 'NSG-MS-App'
param networkSecurityGroups_NSG_MS_Data_name string = 'NSG-MS-Data'
param virtualNetworks_VNET_KhanCloud_Hub_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-KhanCloud-Hub/providers/Microsoft.Network/virtualNetworks/VNET-KhanCloud-Hub'

resource networkSecurityGroups_NSG_MS_App_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_MS_App_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-Management-SSH'
        id: networkSecurityGroups_NSG_MS_App_name_Allow_Management_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.4.0/24'
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
        id: networkSecurityGroups_NSG_MS_App_name_Deny_All_Inbound.id
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

resource networkSecurityGroups_NSG_MS_Data_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_MS_Data_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-App-Inbound'
        id: networkSecurityGroups_NSG_MS_Data_name_Allow_App_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '10.3.1.0/24'
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
        id: networkSecurityGroups_NSG_MS_Data_name_Deny_All_Inbound.id
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

resource networkSecurityGroups_NSG_MS_PE_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_NSG_MS_PE_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-App-Inbound'
        id: networkSecurityGroups_NSG_MS_PE_name_Allow_App_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '10.3.1.0/24'
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
        name: 'Allow-Data-Inbound'
        id: networkSecurityGroups_NSG_MS_PE_name_Allow_Data_Inbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '10.3.2.0/24'
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
        id: networkSecurityGroups_NSG_MS_PE_name_Deny_All_Inbound.id
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

resource routeTables_RT_MS_App_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_MS_App_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_MS_App_name_Force_To_Firewall.id
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

resource routeTables_RT_MS_Data_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_MS_Data_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_MS_Data_name_Force_To_Firewall.id
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

resource routeTables_RT_MS_PE_name_resource 'Microsoft.Network/routeTables@2025-05-01' = {
  name: routeTables_RT_MS_PE_name
  location: 'westeurope'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Force-To-Firewall'
        id: routeTables_RT_MS_PE_name_Force_To_Firewall.id
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

resource networkSecurityGroups_NSG_MS_Data_name_Allow_App_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_Data_name}/Allow-App-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '10.3.1.0/24'
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
    networkSecurityGroups_NSG_MS_Data_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_PE_name_Allow_App_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_PE_name}/Allow-App-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '10.3.1.0/24'
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
    networkSecurityGroups_NSG_MS_PE_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_PE_name_Allow_Data_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_PE_name}/Allow-Data-Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '10.3.2.0/24'
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
    networkSecurityGroups_NSG_MS_PE_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_App_name_Allow_Management_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_App_name}/Allow-Management-SSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.4.0/24'
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
    networkSecurityGroups_NSG_MS_App_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_App_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_App_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_MS_App_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_Data_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_Data_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_MS_Data_name_resource
  ]
}

resource networkSecurityGroups_NSG_MS_PE_name_Deny_All_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_NSG_MS_PE_name}/Deny-All-Inbound'
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
    networkSecurityGroups_NSG_MS_PE_name_resource
  ]
}

resource routeTables_RT_MS_App_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_MS_App_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_MS_App_name_resource
  ]
}

resource routeTables_RT_MS_Data_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_MS_Data_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_MS_Data_name_resource
  ]
}

resource routeTables_RT_MS_PE_name_Force_To_Firewall 'Microsoft.Network/routeTables/routes@2025-05-01' = {
  name: '${routeTables_RT_MS_PE_name}/Force-To-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_RT_MS_PE_name_resource
  ]
}

resource virtualNetworks_VNET_MS_MedSol_name_MS_to_Hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_VNET_MS_MedSol_name}/MS-to-Hub'
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
    virtualNetworks_VNET_MS_MedSol_name_resource
  ]
}

resource virtualNetworks_VNET_MS_MedSol_name_AppSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_MS_MedSol_name}/AppSubnet'
  properties: {
    addressPrefixes: [
      '10.3.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_MS_App_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_MS_App_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_MS_MedSol_name_resource
  ]
}

resource virtualNetworks_VNET_MS_MedSol_name_DataSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_MS_MedSol_name}/DataSubnet'
  properties: {
    addressPrefixes: [
      '10.3.2.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_MS_Data_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_MS_Data_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_MS_MedSol_name_resource
  ]
}

resource virtualNetworks_VNET_MS_MedSol_name_PrivateEndpointSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_VNET_MS_MedSol_name}/PrivateEndpointSubnet'
  properties: {
    addressPrefixes: [
      '10.3.3.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_MS_PE_name_resource.id
    }
    routeTable: {
      id: routeTables_RT_MS_PE_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNET_MS_MedSol_name_resource
  ]
}

resource virtualNetworks_VNET_MS_MedSol_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_VNET_MS_MedSol_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'AppSubnet'
        id: virtualNetworks_VNET_MS_MedSol_name_AppSubnet.id
        properties: {
          addressPrefixes: [
            '10.3.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_MS_App_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_MS_App_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'DataSubnet'
        id: virtualNetworks_VNET_MS_MedSol_name_DataSubnet.id
        properties: {
          addressPrefixes: [
            '10.3.2.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_MS_Data_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_MS_Data_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'PrivateEndpointSubnet'
        id: virtualNetworks_VNET_MS_MedSol_name_PrivateEndpointSubnet.id
        properties: {
          addressPrefixes: [
            '10.3.3.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_MS_PE_name_resource.id
          }
          routeTable: {
            id: routeTables_RT_MS_PE_name_resource.id
          }
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
        name: 'MS-to-Hub'
        id: virtualNetworks_VNET_MS_MedSol_name_MS_to_Hub.id
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
