param virtualMachines_VM_KhanCloud_Mgmt_01_name string = 'VM-KhanCloud-Mgmt-01'
param availabilitySets_AS_KhanCloud_Management_name string = 'AS-KhanCloud-Management'
param networkInterfaces_vm_khancloud_mgmt_01459_name string = 'vm-khancloud-mgmt-01459'
param virtualNetworks_VNET_KhanCloud_Hub_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-KhanCloud-Hub/providers/Microsoft.Network/virtualNetworks/VNET-KhanCloud-Hub'

resource networkInterfaces_vm_khancloud_mgmt_01459_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_vm_khancloud_mgmt_01459_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_khancloud_mgmt_01459_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.4.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_VNET_KhanCloud_Hub_externalid}/subnets/ManagementSubnet'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource availabilitySets_AS_KhanCloud_Management_name_resource 'Microsoft.Compute/availabilitySets@2025-04-01' = {
  name: availabilitySets_AS_KhanCloud_Management_name
  location: 'westeurope'
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformUpdateDomainCount: 5
    platformFaultDomainCount: 2
    virtualMachines: [
      {
        id: virtualMachines_VM_KhanCloud_Mgmt_01_name_resource.id
      }
    ]
  }
}

resource virtualMachines_VM_KhanCloud_Mgmt_01_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_VM_KhanCloud_Mgmt_01_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    availabilitySet: {
      id: availabilitySets_AS_KhanCloud_Management_name_resource.id
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_VM_KhanCloud_Mgmt_01_name}_OsDisk_1_6bbef63fd36e49858ac5d100de880b29'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM_KhanCloud_Mgmt_01_name}_OsDisk_1_6bbef63fd36e49858ac5d100de880b29'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_VM_KhanCloud_Mgmt_01_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_khancloud_mgmt_01459_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
