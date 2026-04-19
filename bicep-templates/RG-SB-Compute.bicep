param availabilitySets_AS_SB_App_name string = 'AS-SB-App'
param virtualMachines_VM_SB_App_01_name string = 'VM-SB-App-01'
param virtualMachines_VM_SB_Data_01_name string = 'VM-SB-Data-01'
param vaults_RSV_SecureBank_name string = 'RSV-SecureBank'
param networkInterfaces_vm_sb_app_01465_name string = 'vm-sb-app-01465'
param networkInterfaces_vm_sb_data_01890_name string = 'vm-sb-data-01890'
param virtualNetworks_VNET_SB_SecureBank_externalid string = '/subscriptions/0b22688b-de65-4537-a762-c377fb98aa5e/resourceGroups/RG-SB-Network/providers/Microsoft.Network/virtualNetworks/VNET-SB-SecureBank'

resource networkInterfaces_vm_sb_app_01465_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_vm_sb_app_01465_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_sb_app_01465_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.1.1.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_VNET_SB_SecureBank_externalid}/subnets/AppSubnet'
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

resource networkInterfaces_vm_sb_data_01890_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_vm_sb_data_01890_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_sb_data_01890_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.1.2.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_VNET_SB_SecureBank_externalid}/subnets/DataSubnet'
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

resource vaults_RSV_SecureBank_name_resource 'Microsoft.RecoveryServices/vaults@2025-08-01' = {
  name: vaults_RSV_SecureBank_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
  }
  properties: {
    monitoringSettings: {
      azureMonitorAlertSettings: {
        alertsForAllJobFailures: 'Enabled'
        alertsForAllReplicationIssues: 'Enabled'
        alertsForAllFailoverIssues: 'Enabled'
      }
      classicAlertSettings: {
        alertsForCriticalOperations: 'Enabled'
        emailNotificationsForSiteRecovery: 'Enabled'
      }
    }
    securitySettings: {
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: 14
        softDeleteState: 'Enabled'
        enhancedSecurityState: 'Enabled'
      }
      sourceScanConfiguration: {
        state: 'Disabled'
      }
    }
    redundancySettings: {
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
    }
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource availabilitySets_AS_SB_App_name_resource 'Microsoft.Compute/availabilitySets@2025-04-01' = {
  name: availabilitySets_AS_SB_App_name
  location: 'westeurope'
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformUpdateDomainCount: 5
    platformFaultDomainCount: 2
    virtualMachines: [
      {
        id: virtualMachines_VM_SB_App_01_name_resource.id
      }
    ]
  }
}

resource virtualMachines_VM_SB_Data_01_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_VM_SB_Data_01_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
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
        name: '${virtualMachines_VM_SB_Data_01_name}_OsDisk_1_de37fa1f56e443b08d9fe04e0ed5fa84'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM_SB_Data_01_name}_OsDisk_1_de37fa1f56e443b08d9fe04e0ed5fa84'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_VM_SB_Data_01_name
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
          id: networkInterfaces_vm_sb_data_01890_name_resource.id
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

resource vaults_RSV_SecureBank_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-08-01' = {
  parent: vaults_RSV_SecureBank_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V1'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-04-20T07:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-04-20T07:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_RSV_SecureBank_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-08-01' = {
  parent: vaults_RSV_SecureBank_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2026-04-20T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-04-20T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_RSV_SecureBank_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-08-01' = {
  parent: vaults_RSV_SecureBank_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2026-04-20T07:00:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2026-04-20T07:00:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_RSV_SecureBank_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2025-08-01' = {
  parent: vaults_RSV_SecureBank_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_RSV_SecureBank_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2025-08-01' = {
  parent: vaults_RSV_SecureBank_name_resource
  name: 'default'
  properties: {}
}

resource virtualMachines_VM_SB_App_01_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_VM_SB_App_01_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    availabilitySet: {
      id: availabilitySets_AS_SB_App_name_resource.id
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
        name: '${virtualMachines_VM_SB_App_01_name}_OsDisk_1_1abcb0fe7c334de5bd31867d558ffce7'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM_SB_App_01_name}_OsDisk_1_1abcb0fe7c334de5bd31867d558ffce7'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_VM_SB_App_01_name
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
          id: networkInterfaces_vm_sb_app_01465_name_resource.id
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
